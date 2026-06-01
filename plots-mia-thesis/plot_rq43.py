#!/usr/bin/env python3
"""
RQ43 plot: per-precision performance of the softmax_polynomial kernel as a
function of the `max_bits_lost` attribute attached to math.exp. Mirrors
plot_rq32's layout for the exp kernel — same x-axis (max_bits_lost),
same y-axis (avg cycles / byte), one panel per precision (f16/f32/f64) —
but draws softmax_polynomial measurements instead of exp_micro.

Data source: `results/kernels.softmax_polynomial.csv`. The plot picks up
every row with `impl = linalg_xdsl_b<N>` (the Snakefile's
XDSL_LINALG_MAX_BITS_LOST_VARIANTS), groups by precision and
max_bits_lost, and averages cycles/byte across the input sizes that were
benchmarked. The `baseline` rows (libm exp_kernel — added by the
baseline.c.template in kernels/softmax_polynomial) are drawn as a
horizontal reference line per panel.

If the CSV does not yet contain baseline rows (the variants are
registered in the Snakefile but the run hasn't been triggered yet) the
baseline line is omitted and only the polynomial curve is drawn.

Usage:
    python plot_rq43.py [-i results/kernels.softmax_polynomial.csv] \\
        [-o plots-mia-thesis/output/rq43_plots.pdf]
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
    savefig,
)


BITS_LOST_VARIANT_RE = re.compile(r"linalg_xdsl_b(-?\d+)$")

POLY_COLOR = "#33a02c"     # matches rq32
BASELINE_COLOR = "#1f78b4"  # matches rq32


def load_bits_lost_csv(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df = df[df["impl"].str.match(BITS_LOST_VARIANT_RE)].copy()
    df["max_bits_lost"] = df["impl"].str.extract(BITS_LOST_VARIANT_RE).astype(int)
    return annotate_kernel_df(df)


def load_baseline_csv(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df = df[df["impl"] == "baseline"].copy()
    if df.empty:
        return df
    return annotate_kernel_df(df)


def avg_per_bits_lost(df: pd.DataFrame, precision: str, metric: str) -> pd.Series:
    return (
        df[df["precision"] == precision]
        .groupby("max_bits_lost")[metric]
        .mean()
        .sort_index()
    )


def avg_baseline(df: pd.DataFrame, precision: str, metric: str) -> float:
    if df.empty or "precision" not in df.columns or metric not in df.columns:
        return float("nan")
    sub = df.loc[df["precision"] == precision, metric]
    return float("nan") if sub.empty else float(sub.mean())


def plot_rq43(poly_df: pd.DataFrame, baseline_df: pd.DataFrame) -> plt.Figure:
    fig, axes = plt.subplots(
        1, len(PRECISIONS), figsize=(len(PRECISIONS) * 4.5, 4.0), sharey=False,
    )

    for col_idx, precision in enumerate(PRECISIONS):
        ax = axes[col_idx]
        series = avg_per_bits_lost(poly_df, precision, "cycles_per_byte")
        baseline = avg_baseline(baseline_df, precision, "cycles_per_byte")

        if not series.empty:
            ax.plot(
                series.index, series.values,
                marker="o", linestyle="-", color=POLY_COLOR,
                label="Chebyshev polynomial (softmax)",
            )
        if not np.isnan(baseline):
            ax.axhline(
                baseline, color=BASELINE_COLOR, linestyle="--",
                label=f"libm baseline ({baseline:.3g})",
            )

        ax.set_title(precision)
        ax.set_xlabel(
            r"User-specified exp accuracy bound (max bits lost, looser $\rightarrow$)"
        )
        if col_idx == 0:
            ax.set_ylabel("avg cycles / byte")
        if not series.empty:
            ax.set_xticks(series.index)
        ax.grid(True, alpha=0.3)
        ax.legend(loc="best", fontsize=8)

    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.softmax_polynomial.csv",
        help="Input CSV with softmax_polynomial measurements",
    )
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/rq43_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    poly_df = load_bits_lost_csv(args.input)
    baseline_df = load_baseline_csv(args.input)
    fig = plot_rq43(poly_df, baseline_df)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
