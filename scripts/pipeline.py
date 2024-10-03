from pathlib import Path
import pandas as pd


def merge_stats(
    kernels_df: pd.DataFrame, regalloc_df: pd.DataFrame, output: Path | None
):
    kernels_df = kernels_df[kernels_df["test"] == "matmul"].set_index("impl")
    df = regalloc_df.join(kernels_df["fpss_fpu_occupancy"])

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
    }

    df = df.rename(columns=col_names, index=row_names)

    print(df.to_csv(output, float_format="%.2f"))


def main():
    import argparse

    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("kernels", type=Path)
    arg_parser.add_argument("regalloc_stats", type=Path)
    arg_parser.add_argument("--output", "-o", type=Path, default=None)

    args = arg_parser.parse_args()
    kernels = args.kernels
    regalloc_stats = args.regalloc_stats
    output = args.output

    kernels_df = pd.read_csv(kernels)
    regalloc_df = pd.read_json(regalloc_stats, lines=True)
    regalloc_df = regalloc_df[regalloc_df.impl == "matmul"]
    del regalloc_df["impl"]
    regalloc_df = regalloc_df[regalloc_df.params == "1x20x5xf64"]
    del regalloc_df["params"]

    regalloc_df = regalloc_df.set_index("variant")

    merge_stats(kernels_df, regalloc_df, output)


if __name__ == "__main__":
    main()
