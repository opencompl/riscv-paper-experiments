#!/usr/bin/env python3
"""
RQ11 plot: signed approximation error p_d(x) - exp(x) on the interval
[CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER] for each Chebyshev degree d
in XDSL_LINALG_CHEBYSHEV_DEGREE_VARIANTS.

The polynomial p_d is the degree-d Chebyshev-Lobatto interpolant of exp,
computed with the same DCT-I formula used by the Snakefile rule
xdsl_kernel_generate_source_chebyshev — so the curves here correspond exactly
to what the xDSL pipeline emits.

Usage:
    python plot_rq11.py [--output plots-mia-thesis/output/rq11_plots.pdf]
"""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from plot_utils import (
    CHEBYSHEV_DEGREES,
    CHEBYSHEV_DOMAIN_LOWER,
    CHEBYSHEV_DOMAIN_UPPER,
    DEGREE_COLORS,
    DEGREE_LINESTYLES,
    chebyshev_lobatto_coeffs,
    despine,
    eval_chebyshev,
    savefig,
)


def plot_rq11() -> plt.Figure:
    x = np.linspace(CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER, 2001)
    exp_x = np.exp(x)

    fig, ax = plt.subplots(figsize=(8, 5))
    for d in CHEBYSHEV_DEGREES:
        approx = eval_chebyshev(chebyshev_lobatto_coeffs(d), x)
        ax.plot(
            x, approx - exp_x,
            color=DEGREE_COLORS[d], linestyle=DEGREE_LINESTYLES[d],
            label=f"d={d}",
        )

    ax.axhline(0.0, color="black", linewidth=0.5)
    ax.set_xlabel("x")
    ax.set_ylabel(r"$p_d(x) - \exp(x)$")
    ax.set_title(
        f"Chebyshev-Lobatto approximation error on "
        f"[{CHEBYSHEV_DOMAIN_LOWER}, {CHEBYSHEV_DOMAIN_UPPER}]"
    )
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(ncol=2, fontsize=8, loc="best")
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", "-o", default="plots-mia-thesis/output/rq11_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    fig = plot_rq11()
    despine(fig)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
