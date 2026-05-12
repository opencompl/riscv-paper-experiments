#!/usr/bin/env python3
"""
RQ1 plot: how does the Chebyshev polynomial degree affect cycles/byte and FPU
utilization of the xDSL polynomial pipeline, compared to the libm baseline?

For each precision (f16, f32, f64) produce two plots:
  - degree vs. avg cycles/byte (averaged across input sizes N)
  - degree vs. avg FPU utilization (averaged across input sizes N)
The libm baseline (from exp_micro) is drawn as a horizontal reference line.

Usage:
    python plot_rq1.py \
        [--exp-micro results/kernels.exp_micro.csv] \
        [--exp-polynomial results/kernels.exp_polynomial.csv] \
        [--output output/rq1_plots.pdf]
"""

import argparse
import re
from pathlib import Path

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from plot_utils import savefig


PRECISION_BYTES = {"f16": 2, "f32": 4, "f64": 8}
PRECISIONS = ["f16", "f32", "f64"]
DEGREE_RE = re.compile(r"linalg_xdsl_d(\d+)$")


def _annotate(df: pd.DataFrame) -> pd.DataFrame:
    parts = df["params"].str.split("x")
    df = df.copy()
    df["precision"] = parts.str[-1]
    df["total_elements"] = parts.apply(lambda ps: int(np.prod([int(p) for p in ps[:-1]])))
    df["total_input_bytes"] = df.apply(
        lambda r: r["total_elements"] * PRECISION_BYTES[r["precision"]], axis=1
    )
    df["cycles_per_byte"] = df["cycles"] / df["total_input_bytes"]
    return df


def load_polynomial(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df = df[df["impl"].str.match(DEGREE_RE)].copy()
    df["degree"] = df["impl"].str.extract(DEGREE_RE).astype(int)
    return _annotate(df)


def load_micro_baseline(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df = df[df["impl"] == "baseline"].copy()
    return _annotate(df)


def avg_per_degree(df: pd.DataFrame, precision: str, metric: str) -> pd.DataFrame:
    return (
        df[df["precision"] == precision]
        .groupby("degree")[metric]
        .mean()
        .sort_index()
    )


def avg_baseline(df: pd.DataFrame, precision: str, metric: str) -> float:
    return df.loc[df["precision"] == precision, metric].mean()


def plot_rq1(poly_df: pd.DataFrame, baseline_df: pd.DataFrame) -> plt.Figure:
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
        "--output", "-o", default="plots-mia-thesis/output/rq1_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)

    poly_df = load_polynomial(args.exp_polynomial)
    baseline_df = load_micro_baseline(args.exp_micro)

    fig = plot_rq1(poly_df, baseline_df)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
