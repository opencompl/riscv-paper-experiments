#!/usr/bin/env python3
"""
RQ12 plot: bits of mantissa lost by the Chebyshev approximation, per precision.

For each precision (f16, f32, f64) and each degree d we compute
    ulp_err(x) = |approx_DTYPE(x) − exp_rn_DTYPE(x)|  /  ulp_DTYPE(exp_rn(x))
and plot
    bits_lost(x) = log2(ulp_err(x)).

bits_lost = 0  → 1 ULP off (last representable step from the correctly-rounded
                 result; precision floor).
bits_lost = k  → bottom k bits of the mantissa are unreliable.
bits_lost = mantissa_bits[prec] → all precision gone.

NOTE: the f64 reference is computed via np.exp(f64), itself accurate to ~1
ULP, so the lowest bits_lost values for f64 conflate polynomial error with
libm's residual roundoff. Use mpmath for a strictly-correct f64 reference.

Usage:
    python plot_rq12.py [--output plots-mia-thesis/output/rq12_plots.pdf]
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
    PRECISION_MANTISSA_BITS,
    PRECISION_NUMPY_DTYPE,
    PRECISIONS,
    chebyshev_lobatto_coeffs,
    despine,
    eval_chebyshev,
    savefig,
    ulp,
)


def plot_rq12(xmin: float, xmax: float, npoints: int) -> plt.Figure:
    x = np.linspace(xmin, xmax, npoints)
    exp_true = np.exp(x.astype(np.float64))  # high-precision reference value

    fig, axes = plt.subplots(1, len(PRECISIONS), figsize=(len(PRECISIONS) * 5, 5))

    for col_idx, precision in enumerate(PRECISIONS):
        ax = axes[col_idx]
        dtype = PRECISION_NUMPY_DTYPE[precision]
        exp_rn = exp_true.astype(dtype)               # correctly-rounded reference
        ulp_rn = ulp(exp_true, precision)             # ulp(exp_rn) in DTYPE
        mantissa_bits = PRECISION_MANTISSA_BITS[precision]
        for d in CHEBYSHEV_DEGREES:
            approx = eval_chebyshev(chebyshev_lobatto_coeffs(d), x).astype(dtype)
            ulp_err = np.abs(
                approx.astype(np.float64) - exp_rn.astype(np.float64)
            ) / ulp_rn
            with np.errstate(divide="ignore"):
                bits_lost = np.log2(ulp_err)
            # exact matches → -inf; drop them so the line is broken there
            bits_lost = np.where(np.isfinite(bits_lost), bits_lost, np.nan)
            ax.plot(
                x, bits_lost,
                color=DEGREE_COLORS[d], linestyle=DEGREE_LINESTYLES[d],
                linewidth=0.8,
                label=f"d={d}",
            )

        ax.axhline(0.0, color="black", linestyle="--", linewidth=0.8,
                   label="1 ULP (0 bits lost)")
        ax.axhline(mantissa_bits, color="red", linestyle="--", linewidth=0.8,
                   label=f"all mantissa bits lost")
        ax.set_ylim(-2, mantissa_bits + 4)
        ax.set_xlabel("x")
        ax.set_title(precision)
        ax.grid(True, which="both", alpha=0.3)

    axes[0].set_ylabel(r"bits lost  $=\log_2(|\mathrm{ULP\ error}|)$")
    axes[-1].legend(ncol=2, fontsize=7, loc="best")
    fig.suptitle(
        f"Chebyshev approximation: mantissa bits lost vs correctly-rounded "
        f"exp on [{xmin}, {xmax}]"
    )
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", "-o", default="plots-mia-thesis/output/rq12_plots.pdf",
        help="Output plot file",
    )
    parser.add_argument(
        "--xmin", type=float, default=CHEBYSHEV_DOMAIN_LOWER,
        help="Left edge of x window",
    )
    parser.add_argument(
        "--xmax", type=float, default=CHEBYSHEV_DOMAIN_UPPER,
        help="Right edge of x window",
    )
    parser.add_argument(
        "--npoints", type=int, default=2001,
        help="Number of x samples in the window",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    fig = plot_rq12(args.xmin, args.xmax, args.npoints)
    despine(fig)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
