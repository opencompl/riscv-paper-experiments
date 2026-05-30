#!/usr/bin/env python3
"""
RQ1 plot: how does the Chebyshev polynomial degree affect cycles/byte and FPU
utilization of the xDSL polynomial pipeline, compared to the libm baseline?

For each precision (f16, f32, f64) produce two plots:
  - degree vs. avg cycles/byte (averaged across input sizes N)
  - degree vs. avg FPU utilization (averaged across input sizes N)
The libm baseline (from exp_micro) is drawn as a horizontal reference line.
The vendor kernel (snrt, from exp_macro) is drawn as a second horizontal
reference line; it is only measured in f64, so it appears on the f64 plots.

Usage:
    python plot_rq1.py \
        [--exp-micro results/kernels.exp_micro.csv] \
        [--exp-polynomial results/kernels.exp_polynomial.csv] \
        [--exp-macro results/kernels.exp_macro.csv] \
        [--output plots-mia-thesis/output/rq1_plots.pdf]
"""

import argparse
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from plot_utils import (
    PRECISIONS,
    load_baseline_csv,
    load_chebyshev_csv,
    load_vendor_csv,
    savefig,
)


def avg_per_degree(df: pd.DataFrame, precision: str, metric: str) -> pd.Series:
    return (
        df[df["precision"] == precision]
        .groupby("degree")[metric]
        .mean()
        .sort_index()
    )


def avg_baseline(df: pd.DataFrame, precision: str, metric: str) -> float:
    return df.loc[df["precision"] == precision, metric].mean()


def plot_rq1(
    poly_df: pd.DataFrame,
    baseline_df: pd.DataFrame,
    vendor_df: pd.DataFrame,
) -> plt.Figure:
    fig, axes = plt.subplots(2, len(PRECISIONS), figsize=(len(PRECISIONS) * 5, 8))

    metrics = [
        ("cycles_per_byte", "Avg cycles / byte"),
        ("fpss_fpu_occupancy", "Avg FPU utilization"),
    ]

    for row_idx, (metric, ylabel) in enumerate(metrics):
        for col_idx, precision in enumerate(PRECISIONS):
            ax = axes[row_idx, col_idx]
            series = avg_per_degree(poly_df, precision, metric)
            baseline = avg_baseline(baseline_df, precision, metric)
            vendor = avg_baseline(vendor_df, precision, metric)

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
            # vendor kernel (snrt) is only measured in f64 -> NaN elsewhere
            if not np.isnan(vendor):
                ax.axhline(
                    vendor, color="#e31a1c", linestyle="-.",
                    label=f"vendor kernel ({vendor:.3g})",
                )

            ax.set_title(f"{precision}")
            ax.set_xlabel("Chebyshev degree")
            ax.set_ylabel(ylabel)
            if not series.empty:
                ax.set_xticks(series.index)
            ax.grid(True, alpha=0.3)
            ax.legend(loc="best", fontsize=8)

    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--exp-micro", default="results/kernels.exp_micro.csv",
        help="Input CSV with libm baseline measurements",
    )
    parser.add_argument(
        "--exp-polynomial", default="results/kernels.exp_polynomial.csv",
        help="Input CSV with Chebyshev polynomial degree-variant measurements",
    )
    parser.add_argument(
        "--exp-macro", default="results/kernels.exp_macro.csv",
        help="Input CSV with vendor kernel (snrt) measurements",
    )
    parser.add_argument(
        "--output", "-o", default="plots-mia-thesis/output/rq1_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)

    poly_df = load_chebyshev_csv(args.exp_polynomial)
    baseline_df = load_baseline_csv(args.exp_micro)
    vendor_df = load_vendor_csv(args.exp_macro)

    fig = plot_rq1(poly_df, baseline_df, vendor_df)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
