#!/usr/bin/env python3
"""
RQ41 plot: realised mantissa bits lost in the softmax *output* as a
function of the `max_bits_lost` attribute attached to math.exp, per
precision.

For each precision (f16, f32, f64) and each value of max_bits_lost in
the range exposed by XDSL_LINALG_MAX_BITS_LOST_VARIANTS (-1 .. 16) we
reproduce the softmax_polynomial kernel arithmetic in software:

    m   = max(x)                        (in DTYPE)
    e_i = exp_target(x_i - m)           (in DTYPE)
    s   = Sum_i e_i                     (sequential, DTYPE)
    inv = 1 / s                         (DTYPE; for f16, via f32 like
                                         softmax.c's __divsf3 fallback)
    z_i = e_i * inv                     (DTYPE)

Two runs differ only in `exp_target`:
    reference:    exp(x_i - m) computed in f64, rounded to DTYPE
                  (correctly-rounded libm exp at the target precision).
    approximated: degree-d Chebyshev-Lobatto interpolant on [-2, 0]
                  evaluated *exactly as the xDSL passes lower it* —
                  same arithmetic as plot_rq13's
                  eval_chebyshev_clenshaw_lowered (every coefficient
                  rounded to DTYPE, every mul/add/sub rounded back to
                  DTYPE). The degree d is the one the pass picks at
                  this (precision, max_bits_lost) — see plot_rq31's
                  chosen_degree.

Per (precision, max_bits_lost) we draw `samples` input vectors of size
`n` from uniform(-1, 1) (same distribution as
softmax_polynomial/gendata.py), compute

    ulp_err_i = |approx_i - ref_i| / ulp_DTYPE(ref_i)

per output element, average across elements and across vectors, then
report

    bits_lost = log2(max(1, mean ulp_err))

so the floor of 0 bits corresponds to "within 1 ULP of the reference".

f16 cap: XDSL_LINALG_MAX_BITS_LOST_VARIANTS_F16 drops bN with N >= 11
because f16 has 11 mantissa bits and the pass's Chebyshev fit becomes
degenerate (degree 0 -> ZeroDivisionError). We mirror that by skipping
those points on the f16 curve.

Usage:
    python plot_rq41.py [--n 64] [--samples 100] [--seed 0] \\
        [-o plots-mia-thesis/output/rq41_plots.pdf]
"""

import argparse
import math as pymath
from functools import lru_cache
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from plot_rq31 import chosen_degree
from plot_utils import (
    CHEBYSHEV_DOMAIN_LOWER,
    CHEBYSHEV_DOMAIN_UPPER,
    PRECISION_MANTISSA_BITS,
    PRECISION_NUMPY_DTYPE,
    PRECISIONS,
    chebyshev_lobatto_coeffs,
    despine,
    eval_chebyshev_clenshaw_lowered,
    savefig,
    ulp,
)


# Full XDSL_LINALG_MAX_BITS_LOST_VARIANTS range from the Snakefile.
BITS_LOST_VALUES: list[int] = list(range(-1, 17))
# f16: snakefile's XDSL_LINALG_MAX_BITS_LOST_VARIANTS_F16 keeps only N < 11.
F16_BITS_LOST_CAP = 11

DEFAULT_N = 64
DEFAULT_SAMPLES = 100
DEFAULT_SEED = 0

REF_COLOR = "#e31a1c"
IDEAL_COLOR = "#000000"
MANTISSA_LIMIT_COLOR = "#827b7b"


@lru_cache(maxsize=None)
def _cached_coeffs(degree: int) -> tuple[float, ...]:
    return tuple(chebyshev_lobatto_coeffs(degree))


def _seq_sum(e: np.ndarray, precision: str) -> np.ndarray:
    """Sequential sum in DTYPE, matching softmax.c's `s += e[i];` loop."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    s = dtype(0)
    for v in e:
        s = dtype(s + dtype(v))
    return s


def _reciprocal(s: np.ndarray, precision: str) -> np.ndarray:
    """1/s as softmax.c does it: f32-emulated for f16 (__divsf3), DTYPE-native otherwise."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    if precision == "f16":
        return dtype(np.float32(1.0) / np.float32(s))
    return dtype(dtype(1.0) / s)


def _softmax_finish(e: np.ndarray, precision: str) -> np.ndarray:
    """Steps 2b/3 of softmax.c: sum(e), 1/s, e *= inv_s."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    s = _seq_sum(e, precision)
    inv = _reciprocal(s, precision)
    return (e * inv).astype(dtype)


def softmax_reference(x: np.ndarray, precision: str) -> np.ndarray:
    """softmax.c arithmetic in DTYPE with exp replaced by correctly-rounded
    libm exp at the target precision (computed in f64, rounded to DTYPE)."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    xd = x.astype(dtype)
    m = xd.max()
    xp = (xd - m).astype(dtype)
    e = np.exp(xp.astype(np.float64)).astype(dtype)
    return _softmax_finish(e, precision)


def softmax_approx(x: np.ndarray, degree: int, precision: str) -> np.ndarray:
    """softmax.c arithmetic in DTYPE with exp replaced by the Chebyshev
    approximation as the xDSL passes lower it (same lowered Clenshaw as
    plot_rq13). The degree is the one the pass picks at this
    (precision, max_bits_lost)."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    xd = x.astype(dtype)
    m = xd.max()
    xp = (xd - m).astype(dtype)
    coeffs = list(_cached_coeffs(degree))
    e = eval_chebyshev_clenshaw_lowered(coeffs, xp, precision)
    return _softmax_finish(e, precision)


def per_vector_mean_ulp_err(
    x: np.ndarray, degree: int, precision: str,
) -> float:
    """Average over output elements of |approx_i - ref_i| / ulp(ref_i)."""
    approx = softmax_approx(x, degree, precision).astype(np.float64)
    ref = softmax_reference(x, precision).astype(np.float64)
    ulps = ulp(ref, precision)
    diff = np.abs(approx - ref)
    with np.errstate(divide="ignore", invalid="ignore"):
        ulp_err = diff / ulps
    ulp_err = np.where(np.isfinite(ulp_err), ulp_err, 0.0)
    return float(ulp_err.mean())


def measure_bits_lost(
    precision: str, bits_lost: int, n: int, samples: int, seed: int,
) -> float | None:
    if precision == "f16" and bits_lost >= F16_BITS_LOST_CAP:
        return None
    mantissa = PRECISION_MANTISSA_BITS[precision]
    degree, _ = chosen_degree(
        bits_lost, CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER, mantissa,
    )
    rng = np.random.default_rng(np.uint64(seed) ^ np.uint64(bits_lost & 0xFFFF))
    errs = [
        per_vector_mean_ulp_err(rng.uniform(-1.0, 1.0, n), degree, precision)
        for _ in range(samples)
    ]
    return pymath.log2(max(1.0, float(np.mean(errs))))


def plot_rq41(n: int, samples: int, seed: int) -> plt.Figure:
    fig, axes = plt.subplots(
        1, len(PRECISIONS), figsize=(len(PRECISIONS) * 5.0, 4.5),
    )
    for col, precision in enumerate(PRECISIONS):
        ax = axes[col]
        mantissa = PRECISION_MANTISSA_BITS[precision]

        xs: list[int] = []
        ys: list[float] = []
        for b in BITS_LOST_VALUES:
            v = measure_bits_lost(precision, b, n, samples, seed)
            if v is None:
                continue
            xs.append(b)
            ys.append(v)

        ax.plot(
            xs, ys,
            marker="o", linestyle="-", color=REF_COLOR,
            label="measured softmax error",
        )
        ideal_y = np.maximum(np.array(xs, dtype=float), 0.0)
        ax.plot(
            xs, ideal_y,
            color=IDEAL_COLOR, linestyle=":", linewidth=1.0,
            label="User-specified bound (max_bits_lost)",
        )
        ax.axhline(
            mantissa,
            color=MANTISSA_LIMIT_COLOR, linestyle="--", linewidth=0.8,
            label="all mantissa bits lost",
        )

        ax.set_xticks(BITS_LOST_VALUES)
        ax.set_xlim(BITS_LOST_VALUES[0] - 0.5, BITS_LOST_VALUES[-1] + 0.5)
        ax.set_ylim(-1, mantissa + 4)
        ax.set_xlabel(
            r"User-specified exp accuracy bound (max bits lost, looser $\rightarrow$)"
        )
        ax.set_title(precision)
        ax.grid(True, alpha=0.3)
        if col == 0:
            ax.set_ylabel(
                r"measured bits lost  $=\log_2(\max(1,\,\overline{\mathrm{ULP\ error}}))$"
            )
            ax.legend(loc="best", fontsize=7)

    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--n", type=int, default=DEFAULT_N,
        help="Size of each sample input vector",
    )
    parser.add_argument(
        "--samples", type=int, default=DEFAULT_SAMPLES,
        help="Number of sample input vectors per (precision, max_bits_lost)",
    )
    parser.add_argument(
        "--seed", type=int, default=DEFAULT_SEED,
        help="Base seed for input-vector sampling",
    )
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/rq41_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    fig = plot_rq41(args.n, args.samples, args.seed)
    despine(fig)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
