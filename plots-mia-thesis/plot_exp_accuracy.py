#!/usr/bin/env python3
"""
Plot accuracy of Taylor-series exp approximations vs np.exp baseline.

One plot per precision (f16, f32, f64).
Each plot has lines for t={3,4,5,6} showing |np.exp(x) - taylor_t(x)| vs x.
x range per precision: [log(smallest_subnormal), 0.5].
"""

import argparse
from pathlib import Path
from typing import Sequence

import numpy as np
import numpy.typing as npt
import pandas as pd
from matplotlib.axes import Axes

from plot_utils import IMPL_COLORS, IMPL_MARKERS, GridPlotRow, plot_combined, savefig


PRECISIONS = {
    "f16": np.float16,
    "f32": np.float32,
    "f64": np.float64,
}

TERMS = [3, 4, 5, 6]

# Reuse the Exp_linalg_xdsl_tN keys from plot_utils
TERM_KEYS = {t: f"Exp_linalg_xdsl_t{t}" for t in TERMS}


def taylor_exp(x: np.ndarray, t: int) -> np.ndarray:
    """Taylor series exp(x) = sum_{k=0}^{t-1} x^k / k!"""
    result = np.ones_like(x)
    term = np.ones_like(x)
    for k in range(1, t):
        term = term * x / k
        result = result + term
    return result


def build_accuracy_dfs(x_max: float, n_points: int) -> list[pd.DataFrame]:
    """Build one DataFrame per precision with x as index and one column per t."""
    dfs = []
    for prec_name, dtype in PRECISIONS.items():
        x_min = float(np.log(np.finfo(dtype).smallest_subnormal))
        x_f64 = np.linspace(x_min, x_max, n_points)
        x = x_f64.astype(dtype)

        baseline = np.exp(x.astype(np.float64)).astype(dtype)

        data = {}
        for t in TERMS:
            approx = taylor_exp(x, t).astype(dtype)
            error = np.abs(baseline.astype(np.float64) - approx.astype(np.float64))
            data[TERM_KEYS[t]] = error

        df = pd.DataFrame(data, index=x.astype(np.float64))
        df.index.name = f"x ({prec_name})"
        dfs.append(df)
    return dfs


class ExpAccuracyPlotRow(GridPlotRow):
    ylabel = "|exp(x) - taylor_t(x)|"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        all_vals = pd.concat(dfs).replace(0, np.nan)
        log_min = np.floor(np.log10(all_vals.min().min()))
        log_max = np.ceil(np.log10(all_vals.max().max()))
        return np.logspace(log_min, log_max, num=int(log_max - log_min) + 1)

    @classmethod
    def plot_grid_cell(cls, ax: Axes, df: pd.DataFrame, *, hide_xlabel: bool) -> None:
        for col in df:
            ax.plot(
                df.index, df[col],
                color=IMPL_COLORS[col], marker=IMPL_MARKERS[col],
                markevery=max(1, len(df) // 20), markersize=4,
            )
        ax.set_yscale("log")
        if not hide_xlabel:
            ax.set_xlabel(df.index.name)


def main():
    parser = argparse.ArgumentParser(description="Plot exp accuracy")
    parser.add_argument("--output", "-o", default="output/exp_accuracy.pdf")
    parser.add_argument("--x-max", type=float, default=0.5)
    parser.add_argument("--n-points", type=int, default=1000)
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)

    dfs = build_accuracy_dfs(args.x_max, args.n_points)
    rows = [ExpAccuracyPlotRow(dfs)]
    fig = plot_combined(
        rows,
        legend_cols=len(TERMS),
        rcparams_cfg_file="config/gridplot.mplstyle",
        figsize=(len(dfs) * 6, 4),
    )
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
