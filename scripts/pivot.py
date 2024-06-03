#!/usr/bin/env python3

import pandas as pd
import argparse
import sys
import os
from os.path import join


def main():
    parser = argparse.ArgumentParser(
        description="Produce pivot table CSV files given a global results CSV. "
        "Read from stdin, write to predefined file names.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-d",
        "--outdir",
        type=str,
        default=os.getcwd(),
        help="Output directory for the resulting CSVs",
    )
    args = parser.parse_args()

    df = pd.read_csv(sys.stdin)

    df["kernels"] = df["test"].astype(str) + " " + df["params"]

    # Filter the DataFrame to keep only the necessary columns
    df = df[["kernels", "impl", "cycles", "fpss_fpu_occupancy", "total_ipc"]]

    PIVOTED_COLS = {
        "linalg",
        "baseline",
        "snitch_stream",
        "snrt",
        "linalg_xdsl",
        "riscv_scf",
        "scf",
    }

    df = df[df["impl"].isin(PIVOTED_COLS)]

    pivoted_all = df.pivot(index="kernels", columns="impl")
    pivoted = pivoted_all["cycles"]
    pivoted_fpu = pivoted_all["fpss_fpu_occupancy"]
    pivoted_ipc = pivoted_all["total_ipc"]

    pivoted["min_llvm_mlir"] = pivoted[["baseline", "linalg"]].min(axis=1)
    # TODO: linalg_xdsl when that's ready
    # TODO: uncomment when adding back xdsl flow
    # pivoted["speedup"] = pivoted["min_llvm_mlir"].div(pivoted["snitch_stream"]).map(lambda val: f"{val:.2f}x" if not math.isnan(val) else "?x")

    pivoted.to_csv(
        join(args.outdir, "pivoted.csv"), float_format=lambda val: str(int(val))
    )
    pivoted_fpu.to_csv(
        join(args.outdir, "pivoted_fpu.csv"), float_format=lambda val: f"{val:.2f}"
    )
    pivoted_ipc.to_csv(
        join(args.outdir, "pivoted_ipc.csv"), float_format=lambda val: f"{val:.2f}"
    )


if __name__ == "__main__":
    main()
