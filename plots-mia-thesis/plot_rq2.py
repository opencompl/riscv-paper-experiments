#!/usr/bin/env python3
"""
RQ2 plot: accuracy vs performance Pareto, one panel per precision (f16/f32/f64).

  x = max_bits_lost (the accuracy bound passed to lower-exp-to-polynomial;
      moving right = looser accuracy)
  y = avg cycles / byte across input sizes N (lower = faster)

The lower-left corner is "best" (more accurate AND faster). A reasonable
pipeline should produce a monotone-decreasing curve: relaxing the bound buys
performance.

Source data is `kernels.exp_micro.csv`. The plot expects rows with
`impl = linalg_xdsl_b<N>` where <N> is the integer `max_bits_lost` (negative
allowed, e.g. `linalg_xdsl_b-1` for correctly-rounded). The Snakefile does
not yet emit these variants — once it does, the plot picks them up
automatically. Until then only the libm baseline reference line is drawn.

Usage:
    python plot_rq2.py [-i results/kernels.exp_micro.csv] \\
        [-o plots-mia-thesis/output/rq2_plots.pdf]
"""

import argparse
import re
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from plot_utils import (
    PRECISIONS,
    annotate_kernel_df,
    load_baseline_csv,
    savefig,
)


# Inferred naming: `linalg_xdsl_b<N>` where <N> is the integer max_bits_lost
# the pass was invoked with (e.g. `linalg_xdsl_b-1`, `linalg_xdsl_b0`,
# `linalg_xdsl_b4`). Negative values are correctly-rounded; 0 is libm-grade;
# higher values relax the bound.
BITS_LOST_VARIANT_RE = re.compile(r"linalg_xdsl_b(-?\d+)$")


def load_bits_lost_csv(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df = df[df["impl"].str.match(BITS_LOST_VARIANT_RE)].copy()
    df["max_bits_lost"] = df["impl"].str.extract(BITS_LOST_VARIANT_RE).astype(int)
    return annotate_kernel_df(df)


def avg_per_bits_lost(df: pd.DataFrame, precision: str, metric: str) -> pd.Series:
    return (
        df[df["precision"] == precision]
        .groupby("max_bits_lost")[metric]
        .mean()
        .sort_index()
    )


def avg_baseline(df: pd.DataFrame, precision: str, metric: str) -> float:
    return df.loc[df["precision"] == precision, metric].mean()


def plot_rq2(poly_df: pd.DataFrame, baseline_df: pd.DataFrame) -> plt.Figure:
    fig, axes = plt.subplots(
        1, len(PRECISIONS), figsize=(len(PRECISIONS) * 4.5, 4.0), sharey=False
    )

    for col_idx, precision in enumerate(PRECISIONS):
        ax = axes[col_idx]
        series = avg_per_bits_lost(poly_df, precision, "cycles_per_byte")
        baseline = avg_baseline(baseline_df, precision, "cycles_per_byte")

        if not series.empty:
            ax.plot(
                series.index, series.values,
                marker="o", linestyle="none", color="#33a02c",
                label="Chebyshev polynomial",
            )
        if not np.isnan(baseline):
            ax.axhline(
                baseline, color="#1f78b4", linestyle="--",
                label=f"libm baseline ({baseline:.3g})",
            )

        ax.set_title(precision)
        ax.set_xlabel(r"max_bits_lost  (looser $\rightarrow$)")
        ax.set_ylabel("avg cycles / byte")
        if not series.empty:
            ax.set_xticks(series.index)
        ax.grid(True, alpha=0.3)
        ax.legend(loc="best", fontsize=8)

    fig.suptitle("Accuracy vs performance Pareto for our polynomial approximation of exp(x)")
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.exp_micro.csv",
        help="Input CSV with exp_micro measurements",
    )
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/rq2_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    poly_df = load_bits_lost_csv(args.input)
    baseline_df = load_baseline_csv(args.input)
    fig = plot_rq2(poly_df, baseline_df)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
