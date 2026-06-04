#!/usr/bin/env python3
"""
Softmax appendix plot: per-element comparison of correctly-rounded exp(x_i)
against the degree-d Chebyshev-Lobatto approximation, for a hand-picked
subset of degrees d in {2, 3, 4, 6, 12} (chosen so the visible variation
stays readable) and three input vectors per precision (f16, f32, f64).

Inputs are generated the way the softmax_polynomial kernel sees them:
    x ~ uniform(-1, 1, N)      (mirrors softmax_polynomial/gendata.py)
    x' = x - max(x)            (the max-shift the kernel performs before exp)
so every x'_i lies in [CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER] =
[-2, 0] — the domain on which the pass fits exp. The Chebyshev coefficients
are computed with the same DCT-I formula used by xdsl_kernel_generate_source_chebyshev
in the Snakefile, and each approximation is evaluated with Clenshaw's
recurrence entirely in the target precision (via
`eval_chebyshev_clenshaw_lowered`, exactly as plot_rq13 does for exp), so the
curves here correspond bit-for-bit to what the xDSL pipeline emits — every
mul/add/sub rounded back to the element type, not summed in f64.

Three different random seeds give three different input vectors per precision.
Each panel:
    x-axis = element index i
    y-axis = exp(x'_i)
with a "true" curve (correctly-rounded exp in the target precision) and one
curve per degree d in DEGREES = {2, 3, 4, 6, 12}.

Usage:
    python softmax_appendix.py [--n 16] [--seeds 0 1 2] \\
        [-o plots-mia-thesis/output/softmax_appendix.pdf]
"""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from plot_utils import (
    DEGREE_COLORS,
    DEGREE_LINESTYLES,
    PRECISION_NUMPY_DTYPE,
    PRECISIONS,
    chebyshev_lobatto_coeffs,
    despine,
    eval_chebyshev_clenshaw_lowered,
    savefig,
)


DEFAULT_N = 16
DEFAULT_SEEDS = [0, 1, 2]

# Hand-picked subset of Chebyshev degrees to plot — restricted from the full
# 2..12 range so the visible per-degree variation stays readable.
DEGREES = [2, 3, 4, 6, 12]


def softmax_xprime(seed: int, n: int, precision: str) -> np.ndarray:
    """Reproduce the per-element input that softmax_polynomial feeds to
    exp_kernel: gendata's uniform(-1, 1, N) sequence cast to `precision`,
    then x - max(x). Uses the legacy global RNG to match gendata.py."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    np.random.seed(seed)
    x = np.random.uniform(-1.0, 1.0, n).astype(dtype)
    return (x - x.max()).astype(dtype)


def chebyshev_approx(x_prime: np.ndarray, degree: int, precision: str) -> np.ndarray:
    """Degree-d Chebyshev-Lobatto interpolant of exp on [-2, 0], evaluated
    with Clenshaw's recurrence entirely in `precision` — the exact arithmetic
    the xDSL lowering emits, reproduced the same way plot_rq13 does
    (`eval_chebyshev_clenshaw_lowered`), rather than summing in f64 and
    rounding only the final value."""
    return eval_chebyshev_clenshaw_lowered(
        chebyshev_lobatto_coeffs(degree), x_prime, precision
    )


def plot_softmax_appendix(n: int, seeds: list[int]) -> plt.Figure:
    fig, axes = plt.subplots(
        len(PRECISIONS), len(seeds),
        figsize=(len(seeds) * 4.0, len(PRECISIONS) * 3.0),
        sharex=True,
    )

    for row, precision in enumerate(PRECISIONS):
        dtype = PRECISION_NUMPY_DTYPE[precision]
        for col, seed in enumerate(seeds):
            ax = axes[row][col]
            x_prime = softmax_xprime(seed, n, precision)
            idx = np.arange(n)

            exp_true = np.exp(x_prime.astype(np.float64)).astype(dtype)
            ax.plot(
                idx, exp_true,
                color="black", marker="o", linestyle="-", linewidth=1.4,
                label="exp(x) (correctly rounded)" if (row == 0 and col == 0) else None,
            )

            for d in DEGREES:
                approx = chebyshev_approx(x_prime, d, precision)
                ax.plot(
                    idx, approx,
                    color=DEGREE_COLORS[d], linestyle=DEGREE_LINESTYLES[d],
                    marker="x", markersize=4, linewidth=0.8,
                    label=f"d={d}" if (row == 0 and col == 0) else None,
                )

            if col == 0:
                ax.set_ylabel(f"{precision}\nexp(x'_i)")
            if row == len(PRECISIONS) - 1:
                ax.set_xlabel("element index i")
            ax.set_title(f"seed={seed}, N={n}")
            ax.grid(True, alpha=0.3)

    axes[0][0].legend(ncol=2, fontsize=7, loc="upper left", bbox_to_anchor=(0.0, -0.0))
    fig.suptitle(
        "Softmax exp inputs: correctly-rounded vs degree-d Chebyshev approximation"
    )
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--n", type=int, default=DEFAULT_N,
        help="Number of elements per input vector",
    )
    parser.add_argument(
        "--seeds", type=int, nargs="+", default=DEFAULT_SEEDS,
        help="Random seeds for the three input vectors",
    )
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/softmax_appendix.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    fig = plot_softmax_appendix(args.n, args.seeds)
    despine(fig)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
