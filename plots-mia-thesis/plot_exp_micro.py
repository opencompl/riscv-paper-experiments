#!/usr/bin/env python3
"""
Plot exp_micro kernel results: FPU utilization and cycles/byte
for different numbers of Taylor terms (t=3,4,5,6), per precision.

Usage:
    python plot_exp_micro.py [--input results/kernels.exp_micro.csv] [--output output/exp_micro_plots.pdf]
"""

import argparse
from pathlib import Path
from typing import Sequence

import numpy as np
import numpy.typing as npt
import pandas as pd
from matplotlib.axes import Axes

from fpu import FPUGridPlotRow
from plot_utils import GridPlotRow, plot_combined, savefig


PRECISION_BYTES = {"f16": 2, "f32": 4, "f64": 8}

TERMS_VARIANTS = ["linalg_xdsl_t3", "linalg_xdsl_t4", "linalg_xdsl_t5", "linalg_xdsl_t6"]

# Colors and markers for each terms variant (after pivoting, columns are "Exp_{impl}")
TERMS_COLORS = {
    "Exp_linalg_xdsl_t3": "#1f78b4",  # dark blue
    "Exp_linalg_xdsl_t4": "#b2df8a",  # light green
    "Exp_linalg_xdsl_t5": "#33a02c",  # dark green
    "Exp_linalg_xdsl_t6": "#e31a1c",  # dark red
}

TERMS_MARKERS = {
    "Exp_linalg_xdsl_t3": "s",
    "Exp_linalg_xdsl_t4": "D",
    "Exp_linalg_xdsl_t5": "^",
    "Exp_linalg_xdsl_t6": "v",
}

TERMS_LABELS = {
    "Exp_linalg_xdsl_t3": "t=3",
    "Exp_linalg_xdsl_t4": "t=4",
    "Exp_linalg_xdsl_t5": "t=5",
    "Exp_linalg_xdsl_t6": "t=6",
}


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

    # Keep only terms variants
    df = df[df["impl"].isin(TERMS_VARIANTS)].copy()

    df["total_input_bytes"] = df.apply(
        lambda row: row["total_elements"] * PRECISION_BYTES[row["precision"]], axis=1,
    )
    df["cycles_per_byte"] = df["cycles"] / df["total_input_bytes"]

    df = df.sort_values("total_elements")
    return df


def make_pivoted_dfs(
    df: pd.DataFrame, metric: str, precisions: list[str],
) -> list[pd.DataFrame]:
    """Create one pivoted DataFrame per precision, with terms variant as columns."""
    dfs = []
    for prec in precisions:
        prec_df = df[df["precision"] == prec]
        pivoted = prec_df.pivot_table(
            index="total_elements", columns="impl", values=metric,
        )
        pivoted.columns = [f"Exp_{c}" for c in pivoted.columns]
        pivoted.index.name = f"N ({prec})"
        dfs.append(pivoted)
    return dfs


class ExpTermsFPUPlotRow(FPUGridPlotRow):
    @classmethod
    def plot_grid_cell(cls, ax: Axes, df: pd.DataFrame, *, hide_xlabel: bool) -> None:
        for col in df:
            ax.plot(
                df.index, df[col],
                color=TERMS_COLORS[col], marker=TERMS_MARKERS[col],
                label=TERMS_LABELS.get(col, col),
            )
        ax.set_xticks(df.index)
        if not hide_xlabel:
            ax.set_xlabel(df.index.name)


class ExpTermsCyclesPerBytePlotRow(GridPlotRow):
    ylabel = "Cycles / Byte"

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
            ax.plot(
                df.index, df[col],
                color=TERMS_COLORS[col], marker=TERMS_MARKERS[col],
                label=TERMS_LABELS.get(col, col),
            )
        ax.set_xticks(df.index)
        if not hide_xlabel:
            ax.set_xlabel(df.index.name)


def get_exp_dfs(df: pd.DataFrame) -> tuple[list[pd.DataFrame], list[pd.DataFrame]]:
    precisions = sorted(df["precision"].unique())

    fpu_dfs = make_pivoted_dfs(df, "fpss_fpu_occupancy", precisions)
    cycles_per_byte_dfs = make_pivoted_dfs(df, "cycles_per_byte", precisions)

    return fpu_dfs, cycles_per_byte_dfs


def plot_exp(fpu_dfs, cycles_per_byte_dfs):
    ncols = len(fpu_dfs)
    rows = [
        ExpTermsFPUPlotRow(fpu_dfs, hide_xtick_labels=True),
        ExpTermsCyclesPerBytePlotRow(cycles_per_byte_dfs),
    ]
    return plot_combined(
        rows,
        legend_cols=4,
        rcparams_cfg_file="config/gridplot.mplstyle",
        figsize=(ncols * 6, len(rows) * 3.5),
    )


def main():
    parser = argparse.ArgumentParser(description="Plot exp_micro kernel results by terms")
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.exp_micro.csv",
        help="Input CSV file",
    )
    parser.add_argument(
        "--output", "-o",
        default="output/exp_micro_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(exist_ok=True)

    df = load_and_prepare(args.input)
    fpu_dfs, cycles_per_byte_dfs = get_exp_dfs(df)
    fig = plot_exp(fpu_dfs, cycles_per_byte_dfs)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()