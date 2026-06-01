#!/usr/bin/env python3
"""
RQ44 plot: accuracy vs performance Pareto scatter for the
softmax_polynomial kernel, one panel per precision (f16/f32/f64).

  x = measured average ULP error of the softmax output
      (computed exactly as in plot_rq40 — softmax.c arithmetic in DTYPE
      with exp replaced by the lowered Clenshaw Chebyshev approximation,
      compared against the same kernel with correctly-rounded libm exp,
      averaged over `samples` random input vectors of size `n`)
  y = avg cycles / byte for the softmax_polynomial kernel
      (same number as plot_rq43, loaded from
       results/kernels.softmax_polynomial.csv)

Each (precision, max_bits_lost) variant becomes one scatter point. Points
are connected in order of increasing max_bits_lost and labelled with the
corresponding `bN` (or `bN..M` when several adjacent budgets pick the
same chosen degree and therefore land on the same (cycles, ulp) point).

A libm `baseline` reference (a single horizontal line at the baseline
cycles/byte mean for that precision) is drawn when the CSV contains the
baseline rows registered by the Snakefile (kernels/softmax_polynomial/
baseline.c.template).

x-axis is log-scaled. ULP errors below 1 are floored to 1 so "within 1
ULP of the reference" sits at the left edge instead of running off to
-inf; this matches the floor plot_rq40 / plot_rq42 use for the bits
conversion.

Usage:
    python plot_rq44.py [-i results/kernels.softmax_polynomial.csv] \\
        [--n 64] [--samples 100] [--seed 0] \\
        [-o plots-mia-thesis/output/rq44_plots.pdf]
"""

import argparse
import re
from functools import lru_cache
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from plot_rq31 import chosen_degree
from plot_rq40 import (
    F16_BITS_LOST_CAP,
    per_vector_mean_ulp_err,
)
from plot_rq43 import (
    BITS_LOST_VARIANT_RE,
    avg_baseline,
    load_baseline_csv,
    load_bits_lost_csv,
)
from plot_utils import (
    CHEBYSHEV_DOMAIN_LOWER,
    CHEBYSHEV_DOMAIN_UPPER,
    PRECISION_MANTISSA_BITS,
    PRECISIONS,
    savefig,
)


DEFAULT_N = 64
DEFAULT_SAMPLES = 100
DEFAULT_SEED = 0

# Sub-ULP runs are clipped to this floor so log10(x) is finite.
ULP_FLOOR = 1.0

POINT_COLOR = "#33a02c"
BASELINE_COLOR = "#1f78b4"


@lru_cache(maxsize=None)
def _measure_for_degree(
    precision: str, degree: int, n: int, samples: int, seed: int,
) -> float:
    """Mean ULP error of the softmax output for a given (precision, degree).
    Keyed on `degree` (not `max_bits_lost`) and seeded deterministically so
    that all max_bits_lost variants that resolve to the same chosen_degree
    produce *identical* measurements — they emit the same code, so the plot
    should treat them as the same Pareto point."""
    rng = np.random.default_rng(np.uint64(seed))
    errs = [
        per_vector_mean_ulp_err(rng.uniform(-1.0, 1.0, n), degree, precision)
        for _ in range(samples)
    ]
    return float(np.mean(errs))


def _measure_ulp_err(
    precision: str, bits_lost: int, n: int, samples: int, seed: int,
) -> float | None:
    """Mean ULP error of the softmax output for (precision, max_bits_lost),
    via the chosen_degree the pass would pick at that budget. Mirrors
    plot_rq40 except it returns the raw ULP error (not log2)."""
    if precision == "f16" and bits_lost >= F16_BITS_LOST_CAP:
        return None
    mantissa = PRECISION_MANTISSA_BITS[precision]
    degree, _ = chosen_degree(
        bits_lost, CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER, mantissa,
    )
    return _measure_for_degree(precision, degree, n, samples, seed)


def collect_points(
    poly_df: pd.DataFrame, n: int, samples: int, seed: int,
) -> pd.DataFrame:
    """One row per (precision, max_bits_lost) in poly_df, carrying both
    the measured ULP error (computed offline, à la rq40) and the avg
    cycles/byte (averaged over input sizes, à la rq43)."""
    rows = []
    for (precision, bits_lost), group in poly_df.groupby(["precision", "max_bits_lost"]):
        ulp_err = _measure_ulp_err(
            precision, int(bits_lost), n, samples, seed,
        )
        if ulp_err is None:
            continue
        rows.append({
            "precision": precision,
            "max_bits_lost": int(bits_lost),
            "ulp_err": ulp_err,
            "cycles_per_byte": float(group["cycles_per_byte"].mean()),
        })
    return pd.DataFrame(rows)


def _format_bits_label(bs: list[int]) -> str:
    """Collapse a sorted list of max_bits_lost values into a compact label
    (`b3` / `b-1..1` / `b-1,2,5`) for annotating coincident points."""
    if len(bs) == 1:
        return f"b{bs[0]}"
    if bs == list(range(bs[0], bs[-1] + 1)):
        return f"b{bs[0]}..{bs[-1]}"
    return "b" + ",".join(str(b) for b in bs)


def plot_rq44(
    points: pd.DataFrame, baseline_df: pd.DataFrame,
) -> plt.Figure:
    fig, axes = plt.subplots(
        1, len(PRECISIONS), figsize=(len(PRECISIONS) * 4.5, 4.0), sharey=False,
    )

    for col_idx, precision in enumerate(PRECISIONS):
        ax = axes[col_idx]
        sub = points[points["precision"] == precision].copy()
        baseline = avg_baseline(baseline_df, precision, "cycles_per_byte")

        if not sub.empty:
            sub["x"] = np.maximum(sub["ulp_err"].to_numpy(), ULP_FLOOR)
            # Variants whose chosen_degree collapses to the same value land
            # on the same (cycles, ulp) point — group them so the line and
            # annotations don't stack on top of each other.
            grp = sub.groupby(
                [sub["x"].round(9), sub["cycles_per_byte"].round(6)],
                sort=False,
            )
            groups = []
            for (x, y), g in grp:
                bs = sorted(int(b) for b in g["max_bits_lost"])
                groups.append((float(x), float(y), bs))
            groups.sort(key=lambda t: min(t[2]))

            xs = [g[0] for g in groups]
            ys = [g[1] for g in groups]
            ax.plot(
                xs, ys,
                marker="o", linestyle="-", color=POINT_COLOR,
                label="Chebyshev polynomial (per max_bits_lost)",
            )
            for x, y, bs in groups:
                ax.annotate(
                    _format_bits_label(bs),
                    (x, y),
                    textcoords="offset points",
                    xytext=(8, 8),
                    fontsize=8,
                    ha="left", va="bottom",
                    bbox=dict(
                        boxstyle="round,pad=0.15",
                        fc="white", ec="none", alpha=0.75,
                    ),
                )

        if not np.isnan(baseline):
            ax.axhline(
                baseline, color=BASELINE_COLOR, linestyle="--",
                label=f"libm baseline ({baseline:.3g})",
            )

        ax.set_xscale("log")
        ax.set_title(precision)
        ax.set_xlabel("measured average ULP error (softmax output)")
        if col_idx == 0:
            ax.set_ylabel("avg cycles / byte")
        ax.grid(True, which="both", alpha=0.3)
        ax.legend(loc="best", fontsize=8)

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
        help="Number of sample input vectors per (precision, max_bits_lost)",
    )
    parser.add_argument(
        "--seed", type=int, default=DEFAULT_SEED,
        help="Base seed for input-vector sampling",
    )
    parser.add_argument(
        "--output", "-o",
        default="plots-mia-thesis/output/rq44_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)
    poly_df = load_bits_lost_csv(args.input)
    baseline_df = load_baseline_csv(args.input)
    points = collect_points(poly_df, n=args.n, samples=args.samples, seed=args.seed)
    fig = plot_rq44(points, baseline_df)
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
