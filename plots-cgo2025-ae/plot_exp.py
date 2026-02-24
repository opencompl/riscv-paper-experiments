#!/usr/bin/env python3
"""
Plot exp vs relu comparison from kernels.exp.csv.

Usage:
    python plot_exp.py [--input results/kernels.exp.csv] [--output output/exp_plots.pdf]
"""

import argparse
from pathlib import Path
from typing import Sequence

import numpy as np
import numpy.typing as npt
import pandas as pd
from matplotlib.axes import Axes

from data import EXP_FLOPS_F16, EXP_FLOPS_F32, EXP_FLOPS_F64
from fpu import FPUGridPlotRow
from plot_utils import IMPL_COLORS, IMPL_MARKERS, GridPlotRow, plot_combined, savefig


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
    df["bitwidth"] = df["precision"].str.extract(r"f(\d+)").astype(int)

    def get_flops(row):
        if row["test"] == "exp":
            flops_per_elem = {16: EXP_FLOPS_F16, 32: EXP_FLOPS_F32, 64: EXP_FLOPS_F64}[row["bitwidth"]]
        else:
            flops_per_elem = 1
        return flops_per_elem * row["total_elements"]

    df["flops"] = df.apply(get_flops, axis=1)
    df["throughput"] = df["flops"] / df["cycles"]

    # Capitalize test names for display
    df["test"] = df["test"].map({"exp": "Exp", "relu": "ReLU"})

    df = df.sort_values("total_elements")
    return df


def make_pivoted_dfs(
    df: pd.DataFrame, metric: str, precisions: list[str],
) -> list[pd.DataFrame]:
    """Create one pivoted DataFrame per precision, with kernels as columns."""
    dfs = []
    for prec in precisions:
        prec_df = df[df["precision"] == prec]
        pivoted = prec_df.pivot_table(
            index="total_elements", columns="test", values=metric,
        )
        cols = [c for c in ["Exp", "ReLU"] if c in pivoted.columns]
        pivoted = pivoted[cols]
        pivoted.index.name = f"Exp N ({prec})"
        dfs.append(pivoted)
    return dfs


class ExpThroughputPlotRow(GridPlotRow):
    ylabel = "Throughput (FP ops/cycle)"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        max_val = max(df.max().max() for df in dfs)
        step = max(1, int(np.ceil(max_val / 8)))
        return np.arange(0, max_val + step + 1, step).astype(np.float64)

    @classmethod
    def plot_grid_cell(cls, ax: Axes, df: pd.DataFrame, *, hide_xlabel: bool) -> None:
        for col in df:
            if col == "Performance Roofline":
                continue
            ax.scatter(
                x=df.index, y=df[col],
                color=IMPL_COLORS[col], marker=IMPL_MARKERS[col],
            )
        ax.set_xticks(df.index)
        if not hide_xlabel:
            ax.set_xlabel(df.index.name)

    @classmethod
    def get_roofline(cls, df: pd.DataFrame) -> float | None:
        if "Performance Roofline" in df.columns:
            return df["Performance Roofline"].iloc[0]
        return None


class ExpCyclesPlotRow(GridPlotRow):
    ylabel = "Cycles"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        max_val = max(df.max().max() for df in dfs)
        step = max(1, int(np.ceil(max_val / 8)))
        magnitude = 10 ** int(np.log10(step))
        step = int(np.ceil(step / magnitude)) * magnitude
        return np.arange(0, max_val + step + 1, step).astype(np.float64)

    @classmethod
    def plot_grid_cell(cls, ax: Axes, df: pd.DataFrame, *, hide_xlabel: bool) -> None:
        for col in df:
            ax.scatter(
                x=df.index, y=df[col],
                color=IMPL_COLORS[col], marker=IMPL_MARKERS[col],
            )
        ax.set_xticks(df.index)
        if not hide_xlabel:
            ax.set_xlabel(df.index.name)


def get_exp_dfs(df: pd.DataFrame) -> tuple[list[pd.DataFrame], list[pd.DataFrame], list[pd.DataFrame]]:
    precisions = sorted(df["precision"].unique())

    fpu_dfs = make_pivoted_dfs(df, "fpss_fpu_occupancy", precisions)
    throughput_dfs = make_pivoted_dfs(df, "throughput", precisions)
    cycles_dfs = make_pivoted_dfs(df, "cycles", precisions)

    # Add roofline values to throughput dfs
    for i, prec in enumerate(precisions):
        bitwidth = int(prec[1:])
        throughput_dfs[i]["Performance Roofline"] = float(64 // bitwidth)

    return fpu_dfs, throughput_dfs, cycles_dfs


def plot_exp(fpu_dfs, throughput_dfs, cycles_dfs):
    ncols = len(fpu_dfs)
    rows = [
        FPUGridPlotRow(fpu_dfs, hide_xtick_labels=True),
        ExpThroughputPlotRow(throughput_dfs, hide_xtick_labels=True),
        ExpCyclesPlotRow(cycles_dfs),
    ]
    return plot_combined(
        rows,
        legend_cols=3,
        rcparams_cfg_file="config/gridplot.mplstyle",
        figsize=(ncols * 3.5, len(rows) * 1.8),
    )


def main():
    parser = argparse.ArgumentParser(description="Plot exp vs relu comparison")
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.exp.csv",
        help="Input CSV file",
    )
    parser.add_argument(
        "--output", "-o",
        default="output/exp_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(exist_ok=True)

    df = load_and_prepare(args.input)
    fpu_dfs, throughput_dfs, cycles_dfs = get_exp_dfs(df)
    fig = plot_exp(fpu_dfs, throughput_dfs, cycles_dfs)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
