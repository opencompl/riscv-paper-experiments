from matplotlib.figure import Figure

import pandas as pd
from typing import Sequence, NamedTuple
from plot_utils import plot_combined

from fpu import FPUGridPlotRow
from data import (
    get_pivoted_all,
    get_pivoted_fpu,
    get_pivoted_cycles,
    Operator,
    get_params_dfs,
    get_operator_df,
    Impl,
)
from throughput import ThroughputGridPlotRow
from cycles import CyclesGridPlotRow


class LLRDataFrames(NamedTuple):
    fpu_dfs: Sequence[pd.DataFrame]
    throughput_dfs: Sequence[pd.DataFrame]
    cycles_dfs: Sequence[pd.DataFrame]


def get_llr_dfs(llr_kernels_df: pd.DataFrame) -> LLRDataFrames:
    llr_pivoted_all_df = (
        get_pivoted_all(llr_kernels_df)
        .loc[:, (slice(None), 'Ours')]
        .droplevel('impl', axis=1)
    )
    llr_pivoted_fpu_df = pd.DataFrame(
        get_pivoted_fpu(llr_pivoted_all_df).rename(Impl.OURS)
    )
    llr_pivoted_cycles_df = get_pivoted_cycles(llr_pivoted_all_df).rename(
        columns={"cycles": Impl.OURS}
    )
    operators = (Operator.SUM, Operator.RELU, Operator.MATMUL_TRANSB)
    llr_fpu_dfs = tuple(
        param_df
        for operator in operators
        for param_df in get_params_dfs(
            get_operator_df(llr_pivoted_fpu_df, operator, bitwidth=32)
        )
    )
    # Remove the matmul_t 1 fpu df
    llr_fpu_dfs = llr_fpu_dfs[:4] + llr_fpu_dfs[5:]
    llr_throughput_dfs: list[pd.DataFrame] = []
    llr_cycles_dfs: list[pd.DataFrame] = []
    for operator in operators:
        llr_operator_df = get_operator_df(llr_pivoted_cycles_df, operator, bitwidth=32)
        llr_operator_params_dfs = tuple(get_params_dfs(llr_operator_df))
        # Remove the matmul_t 1 params df
        if operator == Operator.MATMUL_TRANSB:
            llr_operator_params_dfs = llr_operator_params_dfs[1:]
        llr_operator_throughput_dfs = tuple(
            pd.DataFrame(
                {"Ours": df["Throughput"], "Performance Roofline": df["Max Throughput"]}
            )
            for df in llr_operator_params_dfs
        )
        llr_operator_cycles_dfs = tuple(
            df[[Impl.OURS, "Min Cycles", "Overhead"]] for df in llr_operator_params_dfs
        )
        llr_throughput_dfs.extend(llr_operator_throughput_dfs)
        llr_cycles_dfs.extend(llr_operator_cycles_dfs)

    return LLRDataFrames(llr_fpu_dfs, llr_throughput_dfs, llr_cycles_dfs)


def plot_llr(llr_dfs: LLRDataFrames) -> Figure:
    return plot_combined(
        FPUGridPlotRow.get_rows(
            llr_dfs.fpu_dfs, 6, hide_xlabel=True, hide_xtick_labels=[True]
        )
        + ThroughputGridPlotRow.get_rows(
            llr_dfs.throughput_dfs, 6, hide_xlabel=True, hide_xtick_labels=[True]
        )
        + CyclesGridPlotRow.get_rows(llr_dfs.cycles_dfs, 6),
        legend_cols=4,
        rcparams_cfg_file="config/gridplot.mplstyle",
    )
