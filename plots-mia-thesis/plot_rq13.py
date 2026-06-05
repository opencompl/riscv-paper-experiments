#!/usr/bin/env python3
"""
RQ13 plot: bits of mantissa lost by the Chebyshev approximation *as the
compiler actually evaluates it*, per precision.

This is the realised-error twin of plot_rq12.py. Where plot_rq12 sums the
Chebyshev series in f64 and rounds only the final value (it measures the
mathematical error of the polynomial), this plot reproduces the exact
arithmetic emitted by the xDSL lowering

    math.exp  --lower-exp-to-polynomial-->  polynomial.eval
              --expand-polynomial-eval--->  arith.{mulf,addf,subf}

i.e. Clenshaw's recurrence with the domain map, the constant 2.0, every
Chebyshev coefficient and c_0/2 materialised as arith.constants of the element
type (rounded to the precision) and *every* mul/add/sub rounded back to the
precision. The Chebyshev-Lobatto coefficients carried by the `polynomial.eval`
op are the same ones plot_rq12 uses; the only difference is how they are
evaluated. eval_chebyshev_clenshaw_lowered has been validated
bit-for-bit against running `expand-polynomial-eval` on the generated IR.

For each precision (f16, f32, f64) and each degree d we compute
    ulp_err(x) = |approx_DTYPE(x) − exp_rn_DTYPE(x)|  /  ulp_DTYPE(exp_rn(x))
and plot
    bits_lost(x) = log2(ulp_err(x)).

bits_lost = 0  → 1 ULP off (last representable step from the correctly-rounded
                 result; precision floor).
bits_lost = k  → bottom k bits of the mantissa are unreliable.
bits_lost = mantissa_bits[prec] → all precision gone.

NOTE: the f64 reference is computed via np.exp(f64), itself accurate to ~1
ULP, so the lowest bits_lost values for f64 conflate polynomial/roundoff error
with libm's residual roundoff. Use mpmath for a strictly-correct f64 reference.

Usage:
    python plot_rq13.py [--output plots-mia-thesis/output/rq13_plots.pdf]
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
    eval_chebyshev_clenshaw_lowered,
    savefig,
    ulp,
)


def plot_rq13(xmin: float, xmax: float, npoints: int) -> plt.Figure:
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
            # evaluate exactly as the lowering passes do, in the element type
            approx = eval_chebyshev_clenshaw_lowered(
                chebyshev_lobatto_coeffs(d), x, precision
            )
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
        f"Chebyshev approximation (as lowered): mantissa bits lost vs "
        f"correctly-rounded exp on [{xmin}, {xmax}]"
    )
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/rq13_plots.pdf",
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
    fig = plot_rq13(args.xmin, args.xmax, args.npoints)
    despine(fig)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
