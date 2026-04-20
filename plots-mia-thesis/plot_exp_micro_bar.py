#!/usr/bin/env python3
"""
Bar charts comparing avg FPU utilization and avg cycles/byte
across all exp kernel implementation variants, per precision.

Usage:
    python plot_exp_micro_bar.py --input results/kernels.exp_micro.csv --output output/exp_bar_plots.pdf
"""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from plot_utils import IMPL_COLORS, savefig

PRECISION_BYTES = {"f16": 2, "f32": 4, "f64": 8}

# Implementations to include and their display labels (in desired bar order)
IMPLS = [
    ("baseline", "baseline"),
    ("linalg_xdsl_t3", "t3"),
    ("linalg_xdsl_t4", "t4"),
    ("linalg_xdsl_t5", "t5"),
    ("linalg_xdsl_t6", "t6"),
    ("linalg_xdsl_c4", "c4"),
    ("linalg_xdsl_c8", "c8"),
    ("linalg_xdsl_c12", "c12"),
    ("linalg_xdsl_c16", "c16"),
]

PRECISIONS = ["f16", "f32", "f64"]


def load_and_prepare(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)

    def get_total_elements(row):
        parts = row["params"].split("x")
        dims = [int(p) for p in parts[:-1]]
        return int(np.prod(dims))

    def get_precision(row):
        parts = row["params"].split("x")
        return parts[-1]

    df["total_elements"] = df.apply(get_total_elements, axis=1)
    df["precision"] = df.apply(get_precision, axis=1)
    df = df[df["test"] == "exp_micro"].copy()

    impl_names = {impl for impl, _ in IMPLS}
    df = df[df["impl"].isin(impl_names)].copy()

    df["total_input_bytes"] = df.apply(
        lambda row: row["total_elements"] * PRECISION_BYTES[row["precision"]], axis=1,
    )
    df["cycles_per_byte"] = df["cycles"] / df["total_input_bytes"]

    return df


def compute_averages(df: pd.DataFrame) -> pd.DataFrame:
    """Compute average FPU utilization and cycles/byte per (precision, impl)."""
    return (
        df.groupby(["precision", "impl"])
        .agg(
            avg_fpu=("fpss_fpu_occupancy", "mean"),
            avg_cycles_per_byte=("cycles_per_byte", "mean"),
        )
        .reset_index()
    )


def plot_bars(avg_df: pd.DataFrame) -> plt.Figure:
    plt.style.use("config/gridplot.mplstyle")

    precisions = [p for p in PRECISIONS if p in avg_df["precision"].values]
    ncols = len(precisions)

    fig, axs = plt.subplots(nrows=2, ncols=ncols, figsize=(ncols * 4.5, 7))
    if ncols == 1:
        axs = [[ax] for ax in axs]

    impl_keys = [impl for impl, _ in IMPLS]
    labels = [label for _, label in IMPLS]

    for col_idx, prec in enumerate(precisions):
        prec_df = avg_df[avg_df["precision"] == prec]

        values_fpu = []
        values_cpb = []
        colors = []
        for impl_key, _ in IMPLS:
            row = prec_df[prec_df["impl"] == impl_key]
            values_fpu.append(row["avg_fpu"].values[0] if len(row) else 0)
            values_cpb.append(row["avg_cycles_per_byte"].values[0] if len(row) else 0)
            color_key = f"Exp_{impl_key}"
            colors.append(IMPL_COLORS.get(color_key, "#888888"))

        x = np.arange(len(labels))

        # FPU utilization (top row)
        ax_fpu = axs[0][col_idx]
        ax_fpu.bar(x, values_fpu, color=colors)
        ax_fpu.set_xticks(x)
        ax_fpu.set_xticklabels(labels, rotation=45, ha="right")
        ax_fpu.set_title(prec)
        ax_fpu.set_ylim(0, 1.0)
        ax_fpu.set_yticks(np.arange(0, 1.1, 0.2))

        # Cycles / Byte (bottom row)
        ax_cpb = axs[1][col_idx]
        ax_cpb.bar(x, values_cpb, color=colors)
        ax_cpb.set_xticks(x)
        ax_cpb.set_xticklabels(labels, rotation=45, ha="right")
        ax_cpb.set_title(prec)

    axs[0][0].set_ylabel("Avg FPU Utilization")
    axs[1][0].set_ylabel("Avg Cycles / Byte")

    fig.tight_layout(pad=2.0)
    return fig


def main():
    parser = argparse.ArgumentParser(
        description="Bar chart of avg FPU utilization and cycles/byte per exp impl variant",
    )
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.exp_micro.csv",
        help="Input CSV file",
    )
    parser.add_argument(
        "--output", "-o",
        default="output/exp_bar_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(exist_ok=True)

    df = load_and_prepare(args.input)
    avg_df = compute_averages(df)
    fig = plot_bars(avg_df)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
