from pathlib import Path
import pandas as pd


def merge_stats(
    kernels_df: pd.DataFrame,
    regalloc_df: pd.DataFrame,
    frep_count_df: pd.DataFrame,
    output: Path | None,
):
    kernels_df = kernels_df[kernels_df["test"] == "matmul"].set_index("impl")
    df = regalloc_df.join(
        kernels_df[
            [
                "cycles",
                "fpss_fpu_occupancy",
                "fpss_loads",
                "fpss_stores",
                "fpss_fpu_fmadd_issues",
            ]
        ]
    )
    df = df.join(frep_count_df["frep_count"])

    df["fpss_fpu_occupancy"] *= 100

    del df["preallocated_float"]
    del df["preallocated_int"]

    row_names = {
        "linalg_0_xdsl": "Baseline",
        "linalg_1_xdsl": "+ Streams",
        "linalg_2_xdsl": "+ Scalar Replacement",
        "linalg_3_xdsl": "+ FRep",
        "linalg_4_xdsl": "+ Fuse Fill",
        "linalg_5_xdsl": "+ Unroll and Jam",
    }
    col_names = {
        "allocated_float": "F Registers",
        "allocated_int": "X Registers",
        "fpss_fpu_occupancy": "FPU Occupancy [%]",
        "cycles": "Cycles",
        "fpss_loads": "F Loads",
        "fpss_stores": "F Stores",
        "fpss_fpu_fmadd_issues": "FMAdd Issues",
        "frep_count": "FRep Count",
    }

    df = df.rename(columns=col_names, index=row_names)

    print(df.to_csv(output, float_format="%.2f"))


def main():
    import argparse

    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("kernels", type=Path)
    arg_parser.add_argument("regalloc_stats", type=Path)
    arg_parser.add_argument("frep_count", type=Path)
    arg_parser.add_argument("--output", "-o", type=Path, default=None)

    args = arg_parser.parse_args()
    kernels = args.kernels
    regalloc_stats = args.regalloc_stats
    frep_count = args.frep_count
    output = args.output

    kernels_df = pd.read_csv(kernels)
    regalloc_df = pd.read_json(regalloc_stats, lines=True)
    regalloc_df = regalloc_df[regalloc_df.impl == "matmul"]
    del regalloc_df["impl"]
    regalloc_df["allocated_int"] = regalloc_df["allocated_int"].apply(
        lambda x: sum(1 for reg in x if reg != "zero")
    )
    regalloc_df["allocated_float"] = regalloc_df["allocated_float"].apply(
        lambda x: sum(1 for reg in x)
    )

    regalloc_df = regalloc_df.set_index("variant")

    frep_count_df = pd.read_csv(frep_count)
    frep_count_df = frep_count_df.set_index("variant")

    merge_stats(kernels_df, regalloc_df, frep_count_df, output)


if __name__ == "__main__":
    main()
