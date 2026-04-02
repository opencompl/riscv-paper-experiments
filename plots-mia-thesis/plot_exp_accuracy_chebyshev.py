#!/usr/bin/env python3
"""
Plot accuracy of Chebyshev exp approximations vs np.exp baseline.

One plot per precision (f16, f32, f64).
Each plot has lines for degree={4,8,12,16} showing |np.exp(x) - chebyshev_d(x)| vs x.
Uses the default Chebyshev interval [-10, 0].
x range: [-10, 0].
"""

import argparse
import math as pymath
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

DEGREES = [4, 8, 12, 16]

DEGREE_KEYS = {d: f"Exp_linalg_xdsl_c{d}" for d in DEGREES}


def chebyshev_coefficients(
    f, degree: int, lower: float = -10.0, upper: float = 0.0,
) -> list[float]:
    """Compute Chebyshev coefficients c_0..c_n for f on [lower, upper]."""
    n = degree
    nodes = [pymath.cos(pymath.pi * j / n) for j in range(n + 1)]
    mid = (upper + lower) / 2.0
    half = (upper - lower) / 2.0
    values = [f(half * t + mid) for t in nodes]
    coeffs: list[float] = []
    for k in range(n + 1):
        s = 0.0
        for j in range(n + 1):
            w = 0.5 if (j == 0 or j == n) else 1.0
            s += w * values[j] * pymath.cos(pymath.pi * k * j / n)
        coeffs.append(2.0 * s / n)
    return coeffs


def chebyshev_exp(x: np.ndarray, degree: int, lower: float = -10.0, upper: float = 0.0) -> np.ndarray:
    """Evaluate Chebyshev polynomial approximation of exp via Clenshaw's algorithm."""
    coeffs = chebyshev_coefficients(pymath.exp, degree, lower, upper)

    # Domain mapping: t = (2x - lower - upper) / (upper - lower)
    t = (2.0 * x - lower - upper) / (upper - lower)

    two_t = 2.0 * t
    b_prev2 = np.zeros_like(x, dtype=np.float64)
    b_prev1 = np.zeros_like(x, dtype=np.float64)

    for k in range(degree, 0, -1):
        b_k = two_t * b_prev1 - b_prev2 + coeffs[k]
        b_prev2 = b_prev1
        b_prev1 = b_k

    return coeffs[0] / 2.0 + t * b_prev1 - b_prev2


def build_accuracy_dfs(x_max: float, n_points: int) -> list[pd.DataFrame]:
    """Build one DataFrame per precision with x as index and one column per degree."""
    dfs = []
    for prec_name, dtype in PRECISIONS.items():
        x_min = float(np.log(np.finfo(dtype).smallest_subnormal))
        x_f64 = np.linspace(x_min, x_max, n_points)
        x = x_f64.astype(dtype)

        baseline = np.exp(x.astype(np.float64)).astype(dtype)

        data = {}
        for d in DEGREES:
            approx = chebyshev_exp(x.astype(np.float64), d)
            error = np.abs(baseline.astype(np.float64) - approx)
            # Replace inf/nan with nan so they don't break plotting
            error[~np.isfinite(error)] = np.nan
            data[DEGREE_KEYS[d]] = error

        df = pd.DataFrame(data, index=x.astype(np.float64))
        df.index.name = f"x ({prec_name})"
        dfs.append(df)
    return dfs


class ExpAccuracyPlotRow(GridPlotRow):
    ylabel = "|exp(x) - chebyshev_d(x)|"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        all_vals = pd.concat(dfs).replace(0, np.nan).dropna(how="all")
        finite_min = all_vals.min().min()
        finite_max = all_vals.max().max()
        if not np.isfinite(finite_min) or not np.isfinite(finite_max) or finite_min <= 0:
            return np.logspace(-16, 2, num=19)
        log_min = np.floor(np.log10(finite_min))
        log_max = np.ceil(np.log10(finite_max))
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
    parser = argparse.ArgumentParser(description="Plot Chebyshev exp accuracy")
    parser.add_argument("--output", "-o", default="output/exp_accuracy_chebyshev.pdf")
    parser.add_argument("--x-max", type=float, default=0.5)
    parser.add_argument("--n-points", type=int, default=1000)
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)

    dfs = build_accuracy_dfs(args.x_max, args.n_points)
    rows = [ExpAccuracyPlotRow(dfs)]
    fig = plot_combined(
        rows,
        legend_cols=len(DEGREES),
        rcparams_cfg_file="config/gridplot.mplstyle",
        figsize=(len(dfs) * 6, 4),
    )
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
