from collections.abc import Iterable
import pandas as pd
import numpy as np

from enum import StrEnum


class Impl(StrEnum):
    OURS = "Ours"
    CLANG = "Clang"
    MLIR = "MLIR"


class Operator(StrEnum):
    CONV = "Conv 3x3"
    FILL = "Fill"
    MATMUL = "MatMul"
    MATMUL_TRANSB = "MatMulT"
    MAX_POOL = "Max Pool 3x3"
    RELU = "ReLU"
    SUM = "Sum"
    SUM_POOL = "Sum Pool 3x3"


OPERATOR_BY_TEST = {
    "conv2d_d1_s1_3x3": Operator.CONV,
    "fill": Operator.FILL,
    "matmul": Operator.MATMUL,
    "matmul_transb": Operator.MATMUL_TRANSB,
    "pooling_nchw_max_d1_s2_3x3": Operator.MAX_POOL,
    "relu": Operator.RELU,
    "dsum": Operator.SUM,
    "sum": Operator.SUM,
    "pooling_nchw_sum_d1_s2_3x3": Operator.SUM_POOL,
}

PARAMS_BY_OPERATOR = {
    Operator.CONV: ("M", "N"),
    Operator.FILL: ("M", "N"),
    Operator.MATMUL: ("M", "K", "N"),
    Operator.MATMUL_TRANSB: ("M", "K", "N"),
    Operator.MAX_POOL: ("M", "N"),
    Operator.RELU: ("M", "N"),
    Operator.SUM: ("M", "N"),
    Operator.SUM_POOL: ("M", "N"),
}

FLOPS_BY_OPERATOR = {
    Operator.CONV: lambda m, n: 2 * 9 * n * m,
    Operator.FILL: lambda m, n: n * m,
    Operator.MATMUL: lambda m, k, n: 2 * n * m * k,
    Operator.MATMUL_TRANSB: lambda m, k, n: 2 * n * m * k,
    Operator.MAX_POOL: lambda m, n: 9 * n * m,
    Operator.RELU: lambda m, n: n * m,
    Operator.SUM: lambda m, n: n * m,
    Operator.SUM_POOL: lambda m, n: 9 * n * m,
}
"""
FLOPS adjusted for whether the operation can benefit from the fmadd instruction.
"""

OPERAND_SHAPES_BY_OPERATOR = {
    Operator.CONV: lambda m, n: ((m, n),),
    Operator.FILL: lambda m, n: ((m, n),),
    Operator.MATMUL: lambda m, k, n: ((m, k), (k, n)),
    Operator.MATMUL_TRANSB: lambda m, k, n: ((m, k), (n, k)),
    Operator.MAX_POOL: lambda m, n: ((m, n),),
    Operator.RELU: lambda m, n: ((m, n),),
    Operator.SUM: lambda m, n: ((m, n), (m, n)),
    Operator.SUM_POOL: lambda m, n: ((m, n),),
}

FMA_OPERATORS = {Operator.CONV, Operator.MATMUL, Operator.MATMUL_TRANSB}


def _get_kernels(filename: str) -> pd.DataFrame:
    df = pd.read_csv(filename)
    df.replace(
        {
            "linalg_xdsl": Impl.OURS,
            "snitch_stream": Impl.OURS,
            "baseline": Impl.CLANG,
            "linalg": Impl.MLIR,
            **OPERATOR_BY_TEST,
        },
        inplace=True,
    )
    df = df[df.impl.isin(set(Impl))]
    df.set_index(["test", "params"], inplace=True)
    # Get the result of adding_overhead for each operator and concatenate the dataframes
    df_with_overhead = pd.concat([
        adding_overhead(df[df.index.get_level_values(0) == operator], operator)
        for operator in Operator
        if operator in df.index.get_level_values(0)
    ])
    return df_with_overhead


def get_kernels(cleaned: bool = True) -> pd.DataFrame:
    df = _get_kernels("results/kernels.csv")
    # Drop unknown operators
    df = df[df.index.get_level_values(0).isin(tuple(Operator))]
    if cleaned:
        # exclude K=400  matmul entries
        df = df[df.index.get_level_values(1) != "1x400x25xf64"]
    return df


def get_low_level_representation() -> pd.DataFrame:
    return _get_kernels("results/kernels.low_level_representation.csv")


def get_pivoted_all(kernels_df: pd.DataFrame) -> pd.DataFrame:
    return kernels_df.pivot(columns="impl")


def get_pivoted_fpu(pivoted_all_df: pd.DataFrame) -> pd.DataFrame:
    return pivoted_all_df["fpss_fpu_occupancy"]


def get_pivoted_cycles(pivoted_all_df: pd.DataFrame) -> pd.DataFrame:
    return pivoted_all_df[["cycles", "Min Cycles", "Overhead", "FLOPs", "Throughput", "Max Throughput"]]


def get_flops(operator_df: pd.DataFrame, operator: Operator) -> pd.Series:
    operator_series: list[pd.Series] = [
        operator_df[param] for param in PARAMS_BY_OPERATOR[operator]
    ]
    return FLOPS_BY_OPERATOR[operator](*operator_series)


def get_overhead(
    kernels_operator_df: pd.DataFrame,
    operator: Operator,
) -> pd.DataFrame:
    cols = PARAMS_BY_OPERATOR[operator]
    col_vals: pd.DataFrame = kernels_operator_df.index.get_level_values(1).str.extract(
        "x".join((r"(\d+)" for _ in range(len(cols)))) + r"xf(\d+)"
    )
    col_vals.columns = cols + ("bitwidth",)
    col_vals.index = kernels_operator_df.index
    col_vals = col_vals.apply(pd.to_numeric)
    flops = get_flops(col_vals, operator)
    assert (64 % col_vals.bitwidth == 0).all()
    throughput = flops / kernels_operator_df["cycles"]
    max_throughput = (2 if operator in FMA_OPERATORS else 1) * 64 // col_vals["bitwidth"]
    rel_throughput = throughput / max_throughput
    min_cycles = np.ceil((flops / max_throughput))
    overhead = kernels_operator_df["cycles"] - min_cycles
    res = pd.DataFrame({
        "Min Cycles": min_cycles,
        "Overhead": overhead,
        "FLOPs": flops,
        "Throughput": throughput,
        "Max Throughput": max_throughput,
        "Rel Throughput": rel_throughput,
        "bitwidth": col_vals["bitwidth"]
    })
    return res

def adding_overhead(
    operator_df: pd.DataFrame,
    operator: Operator,
) -> pd.DataFrame:
    return pd.concat(
        (
            operator_df,
            get_overhead(
                operator_df,
                operator
            ),
        ),
        axis=1,
    )

def get_operator_df(
    pivoted_df: pd.DataFrame, operator: Operator, *, bitwidth: int
) -> pd.DataFrame:
    cols = PARAMS_BY_OPERATOR[operator]
    operator_df = pivoted_df.loc[operator.value]
    col_vals = operator_df.index.str.extract(
        "x".join((r"(\d+)" for _ in range(len(cols)))) + r"xf(\d+)"
    )
    col_vals.columns = cols + ("bitwidth",)
    col_vals.index = operator_df.index
    df = pd.concat(
        (
            operator_df,
            col_vals.apply(pd.to_numeric),
        ),
        axis=1,
    )
    df = df[df.bitwidth == bitwidth]
    df.index.name = operator.value
    return df


def get_params_dfs(operator_df: pd.DataFrame) -> Iterable[pd.DataFrame]:
    name = operator_df.index.name
    cols = PARAMS_BY_OPERATOR[name]
    maxs = tuple(operator_df[col].max() for col in cols)
    operand_shapes_map = OPERAND_SHAPES_BY_OPERATOR[name]
    for i, col in enumerate(cols):
        my_df = operator_df
        name_components: list[str] = []
        for j, other_col in enumerate(cols):
            if i != j:
                name_components.append(str(int(maxs[j])))
                my_df = my_df[my_df[other_col] == maxs[j]]
            else:
                name_components.append(col)
        other_cols = list(cols) + ["bitwidth"]
        del other_cols[i]
        shape_string = " ".join("x".join(t) for t in operand_shapes_map(*name_components))
        new_name = f"{name} {shape_string}"
        my_df = my_df.rename(columns={col: new_name}).set_index(new_name).sort_index()
        my_df.drop(other_cols, axis=1, inplace=True)
        yield my_df


def get_regalloc() -> pd.DataFrame:
    regalloc_df = pd.read_csv("results/regalloc.csv")
    regalloc_df = regalloc_df[regalloc_df["impl"].isin(OPERATOR_BY_TEST)]
    regalloc_df.replace(OPERATOR_BY_TEST, inplace=True)
    regalloc_df = regalloc_df[~regalloc_df["params"].str.contains("f16")]
    regalloc_df.reset_index(drop=True, inplace=True)
    param_components = tuple(param.split("x") for param in regalloc_df["params"])
    bitwidths = tuple({"Bits": param[-1][1:]} for param in param_components)
    params = tuple(
        {p: v for p, v in zip("MNK", param[:-1])} for param in param_components
    )
    params_df = pd.DataFrame(params).fillna("{--}")
    regalloc_df = pd.concat((regalloc_df, pd.DataFrame(bitwidths), params_df), axis=1)
    del regalloc_df["params"]

    # Reorder columns to move Cycles and Occupancy to the end
    cols = regalloc_df.columns.tolist()
    cols = [col for col in cols if col not in ['allocated_float', 'allocated_int']] + [
        'allocated_float',
        'allocated_int',
    ]
    regalloc_df = regalloc_df[cols]

    return regalloc_df


def get_opt_pipeline() -> pd.DataFrame:
    opt_pipeline_df = pd.read_csv("results/pipeline.csv")
    opt_pipeline_df = opt_pipeline_df.rename(
        columns={
            "FPU Occupancy [%]": "Occupancy",
            "FMAdd Issues": "FMAdd",
            "FRep Count": "FRep",
            "variant": "Optimizations",
        }
    )

    return opt_pipeline_df
