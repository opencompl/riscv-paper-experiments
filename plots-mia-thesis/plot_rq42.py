#!/usr/bin/env python3
"""
RQ42 plot: Does the kernel-level exp accuracy/perf trade-off translate to
the softmax operator? Mirrors rq35's layout so the two plots can be
compared directly: same x-axis (`max_bits_lost`), same left y-axis
(avg cycles/byte). Adds a twin right y-axis showing the end-to-end softmax
output accuracy (avg bits lost in the softmax output across 100 sampled
input vectors).

Performance is loaded from `results/kernels.softmax_polynomial.csv` — same
processing as rq35. Accuracy is measured offline:
    for each (precision, max_bits_lost):
        1. recover the Chebyshev degree the pass picks (chosen_degree)
        2. sample 100 input vectors of size DEFAULT_N from uniform(-1, 1)
        3. run the softmax kernel in target precision: max-shift,
           Chebyshev approx of exp on [-2, 0], sum, normalize
        4. reference = softmax in float64, rounded to target precision
        5. per output element i: bits_lost_i = log2(max(1, ULP error_i))
        6. average over output elements per vector, then over the 100 vectors.

Caveat: the float64 reference is itself ~1 ULP off correctly-rounded for
f64; the bottom of the f64 accuracy curve conflates polynomial error with
libm's residual roundoff (same caveat as plot_rq12).

Usage:
    python plot_rq42.py [-i results/kernels.softmax_polynomial.csv] \\
        [--n 64] [--samples 100] [-o plots-mia-thesis/output/rq42_plots.pdf]
"""

import argparse
import re
from functools import lru_cache
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from plot_rq34 import chosen_degree
from plot_utils import (
    CHEBYSHEV_DOMAIN_LOWER,
    CHEBYSHEV_DOMAIN_UPPER,
    PRECISION_MANTISSA_BITS,
    PRECISION_NUMPY_DTYPE,
    PRECISIONS,
    annotate_kernel_df,
    chebyshev_lobatto_coeffs,
    eval_chebyshev,
    savefig,
    ulp,
)


BITS_LOST_VARIANT_RE = re.compile(r"linalg_xdsl_b(-?\d+)$")

DEFAULT_N = 64
DEFAULT_SAMPLES = 100
DEFAULT_SEED = 0

PERF_COLOR = "#33a02c"   # matches rq35
ACC_COLOR = "#e31a1c"


@lru_cache(maxsize=None)
def _cached_coeffs(degree: int) -> tuple[float, ...]:
    return tuple(chebyshev_lobatto_coeffs(degree))


def load_softmax_csv(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)
    df = df[df["impl"].str.match(BITS_LOST_VARIANT_RE)].copy()
    df["max_bits_lost"] = df["impl"].str.extract(BITS_LOST_VARIANT_RE).astype(int)
    return annotate_kernel_df(df)


def softmax_approx(x: np.ndarray, degree: int, precision: str) -> np.ndarray:
    """Reproduce softmax_polynomial kernel arithmetic in `precision`:
        m  = max(x)                       (in dtype)
        e  = approx_d(x - m)              (Chebyshev eval, in dtype)
        s  = sum(e)                       (in dtype)
        z  = e / s                        (in dtype)
    Polynomial eval is done in float64 and cast to dtype — same approach
    plot_rq12 uses; the kernel's Clenshaw eval in DTYPE differs slightly but
    not enough to matter for the translation question."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    x = x.astype(dtype)
    m = x.max()
    xp = (x - m).astype(dtype)
    coeffs = list(_cached_coeffs(degree))
    e = eval_chebyshev(coeffs, xp.astype(np.float64)).astype(dtype)
    s = dtype(e.sum())
    return (e / s).astype(dtype)


def softmax_reference_f64(x: np.ndarray) -> np.ndarray:
    """Reference softmax computed entirely in float64."""
    x64 = x.astype(np.float64)
    m = x64.max()
    e = np.exp(x64 - m)
    return e / e.sum()


def per_vector_bits_lost(x: np.ndarray, degree: int, precision: str) -> float:
    """Average over output elements of bits_lost_i = log2(max(1, ULP_err_i))."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    approx = softmax_approx(x, degree, precision)
    ref_f64 = softmax_reference_f64(x)
    ref_rn = ref_f64.astype(dtype)
    ulps = ulp(ref_f64, precision)  # ULP at the true value, in target precision
    diff = np.abs(approx.astype(np.float64) - ref_rn.astype(np.float64))
    with np.errstate(divide="ignore", invalid="ignore"):
        ulp_err = diff / ulps
    ulp_err = np.where(np.isfinite(ulp_err), ulp_err, 0.0)
    bits = np.log2(np.maximum(1.0, ulp_err))
    return float(bits.mean())


def measure_accuracy(
    precision: str, bits_lost: int, n: int, samples: int, seed: int,
) -> float:
    mantissa = PRECISION_MANTISSA_BITS[precision]
    degree, _ = chosen_degree(
        bits_lost, CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER, mantissa
    )
    rng = np.random.default_rng(np.uint64(seed) ^ np.uint64(bits_lost & 0xFFFF))
    vecs = [rng.uniform(-1.0, 1.0, n) for _ in range(samples)]
    return float(np.mean([per_vector_bits_lost(x, degree, precision) for x in vecs]))


def aggregate(
    df: pd.DataFrame, n: int, samples: int, seed: int,
) -> pd.DataFrame:
    """One row per (precision, max_bits_lost):
        - cycles_per_byte_mean = avg over the N values benchmarked
        - softmax_output_bits_lost = avg over `samples` input vectors of size n
    """
    rows = []
    for (precision, bits_lost), group in df.groupby(["precision", "max_bits_lost"]):
        mantissa = PRECISION_MANTISSA_BITS[precision]
        degree, capped = chosen_degree(
            bits_lost, CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER, mantissa
        )
        bits = measure_accuracy(
            precision, int(bits_lost), n=n, samples=samples, seed=seed,
        )
        rows.append({
            "precision": precision,
            "max_bits_lost": int(bits_lost),
            "degree": degree,
            "capped": capped,
            "cycles_per_byte_mean": group["cycles_per_byte"].mean(),
            "softmax_output_bits_lost": bits,
        })
    return pd.DataFrame(rows).sort_values(["precision", "max_bits_lost"])


def plot_rq42(agg: pd.DataFrame) -> plt.Figure:
    fig, axes = plt.subplots(
        1, len(PRECISIONS), figsize=(len(PRECISIONS) * 5.0, 4.5), sharey=False,
    )
    for i, precision in enumerate(PRECISIONS):
        ax = axes[i]
        sub = agg[agg["precision"] == precision].sort_values("max_bits_lost")
        if sub.empty:
            ax.set_title(f"{precision} (no data)")
            ax.grid(True, alpha=0.3)
            continue

        # Left axis: avg cycles/byte (mirrors rq35).
        l_perf, = ax.plot(
            sub["max_bits_lost"], sub["cycles_per_byte_mean"],
            marker="o", linestyle="-", color=PERF_COLOR,
            label="avg cycles / byte (softmax)",
        )

        # Right axis: softmax output bits lost.
        ax2 = ax.twinx()
        l_acc, = ax2.plot(
            sub["max_bits_lost"], sub["softmax_output_bits_lost"],
            marker="s", linestyle="--", color=ACC_COLOR,
            label="avg bits lost in softmax output",
        )

        # Reference y = x line: "exp bound translates 1:1 to softmax output".
        xs = sub["max_bits_lost"].to_numpy()
        l_ref, = ax2.plot(
            xs, np.maximum(xs, 0.0),
            color="black", linestyle=":", linewidth=1.0,
            label="ideal: output bits lost = max_bits_lost",
        )

        ax.set_xticks(xs)
        ax.set_xlabel(r"max_bits_lost  (looser $\rightarrow$)")
        ax.set_ylabel("avg cycles / byte", color=PERF_COLOR)
        ax2.set_ylabel("softmax output bits lost", color=ACC_COLOR)
        ax.tick_params(axis="y", labelcolor=PERF_COLOR)
        ax2.tick_params(axis="y", labelcolor=ACC_COLOR)
        ax.set_title(precision)
        ax.grid(True, alpha=0.3)
        if i == 0:
            ax.legend(handles=[l_perf, l_acc, l_ref], loc="best", fontsize=7)

    fig.suptitle(
        "RQ4: Softmax operator — does the kernel-level exp trade-off translate?"
    )
    fig.tight_layout()
    return fig


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.softmax_polynomial.csv",
        help="softmax_polynomial measurement CSV",
    )
    parser.add_argument(
        "--n", type=int, default=DEFAULT_N,
        help="Size of each sample input vector for the accuracy measurement",
    )
    parser.add_argument(
        "--samples", type=int, default=DEFAULT_SAMPLES,
        help="Number of sample input vectors per variant",
    )
    parser.add_argument(
        "--seed", type=int, default=DEFAULT_SEED,
        help="Base seed for input-vector sampling",
    )
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/rq42_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    df = load_softmax_csv(args.input)
    agg = aggregate(df, n=args.n, samples=args.samples, seed=args.seed)
    fig = plot_rq42(agg)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
