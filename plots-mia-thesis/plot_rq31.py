#!/usr/bin/env python3
"""
RQ31 plot: table of Chebyshev polynomial degrees picked by the
xdsl `lower-exp-to-polynomial` pass for every (precision, max_bits_lost) pair.

Rows are precision formats (f16/f32/f64). Columns are values of the
`max_bits_lost` attribute the user might attach to math.exp:

  -1 → correctly-rounded (every mantissa bit guaranteed correct)
   0 → 1 ULP / libm-grade
   k → 2^k ULPs of tolerated error

Each cell is the smallest Chebyshev-Lobatto degree the pass would pick. A `*`
prefix marks cases that hit the pass's `_MAX_DEGREE` cap (the bound isn't met
within the budget, but the polynomial is still emitted at that degree).

Mirrors `_choose_polynomial` in
    xdsl/transforms/lower_exp_to_polynomial.py
verbatim, so the numbers here are exactly what the pass picks at compile time.

Usage:
    python plot_rq31.py [--xmin -2.0] [--xmax 0.0] \\
        [--bits-lost -1 0 1 2 4 8 16] \\
        [-o plots-mia-thesis/output/rq31_plots.pdf]
"""

import argparse
import math as pymath
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

from plot_utils import (
    CHEBYSHEV_DOMAIN_LOWER,
    CHEBYSHEV_DOMAIN_UPPER,
    PRECISION_MANTISSA_BITS,
    PRECISIONS,
    savefig,
)


# Must match _MAX_DEGREE in xdsl.transforms.lower_exp_to_polynomial.
_MAX_DEGREE = 30

DEFAULT_BITS_LOST = [-1, 0, 1, 2, 4, 8, 16]


def chosen_degree(
    max_bits_lost: float, lower: float, upper: float, precision_bits: int,
) -> tuple[int, bool]:
    """Mirror of xdsl._choose_polynomial's degree-picking loop.

    Returns (degree, capped) — `capped` is True iff the loop exited because it
    hit _MAX_DEGREE without satisfying the bound.
    """
    width = upper - lower
    degree = 0
    bits_lost = (
        width * pymath.log2(pymath.e)
        + pymath.log2(width)
        + (precision_bits - 1)
    )
    while bits_lost > max_bits_lost and degree < _MAX_DEGREE:
        degree += 1
        bits_lost += pymath.log2(width) - 2 - pymath.log2(degree + 1)
    capped = bits_lost > max_bits_lost
    return degree, capped


def plot_rq31(
    xmin: float, xmax: float, bits_lost_values: list[int],
) -> plt.Figure:
    rows = PRECISIONS
    cols = bits_lost_values

    degrees = np.zeros((len(rows), len(cols)), dtype=int)
    capped = np.zeros((len(rows), len(cols)), dtype=bool)
    for i, prec in enumerate(rows):
        precision_bits = PRECISION_MANTISSA_BITS[prec]
        for j, b in enumerate(cols):
            d, c = chosen_degree(b, xmin, xmax, precision_bits)
            degrees[i, j] = d
            capped[i, j] = c

    # Annotate each cell with its degree; mark capped cells with a trailing *.
    annot = np.array([
        [f"{d}{'*' if c else ''}" for d, c in zip(row_d, row_c)]
        for row_d, row_c in zip(degrees, capped)
    ])

    fig, ax = plt.subplots(
        figsize=(2.2 + 0.7 * len(cols), 1.6 + 0.55 * len(rows))
    )
    sns.heatmap(
        degrees,
        annot=annot,
        fmt="",
        cmap="RdYlGn_r",
        vmin=0, vmax=_MAX_DEGREE,
        xticklabels=[str(b) for b in cols],
        yticklabels=rows,
        cbar=False,
        linewidths=0.5,
        linecolor="white",
        annot_kws={"fontsize": 11, "fontweight": "bold"},
        square=False,
        ax=ax,
    )
    plt.setp(ax.get_xticklabels(), rotation=0, fontsize=10)
    plt.setp(ax.get_yticklabels(), rotation=0, fontsize=10)
    ax.set_xlabel(
        r"bits lost  $=\log_2(|\mathrm{ULP\ error}|)$",
        fontsize=11,
        labelpad=10,
    )
    ax.set_ylabel("precision", fontsize=11)
    ax.xaxis.set_label_position("top")
    ax.xaxis.tick_top()

    fig.suptitle(
        f"Chebyshev polynomial degree picked by the pass on [{xmin}, {xmax}]",
        fontsize=10,
    )
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", "-o", default="plots-mia-thesis/output/rq31_plots.pdf",
        help="Output plot file",
    )
    parser.add_argument(
        "--xmin", type=float, default=CHEBYSHEV_DOMAIN_LOWER,
        help="Domain lower bound passed to the pass",
    )
    parser.add_argument(
        "--xmax", type=float, default=CHEBYSHEV_DOMAIN_UPPER,
        help="Domain upper bound passed to the pass",
    )
    parser.add_argument(
        "--bits-lost", type=int, nargs="+", default=DEFAULT_BITS_LOST,
        help="max_bits_lost column values",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    fig = plot_rq31(args.xmin, args.xmax, args.bits_lost)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
