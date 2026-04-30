#!/usr/bin/env python3
"""
Plot true exp(x) vs Chebyshev polynomial approximations of degree 4,8,12,16.

One subplot per precision (f16, f32, f64), showing the true function and
each Chebyshev approximation over the same interval used in the accuracy plots.
"""

import math as pymath
import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D

# Ensure we run relative to the script's directory
os.chdir(Path(__file__).resolve().parent)


PRECISIONS = {
    "f16": np.float16,
    "f32": np.float32,
    "f64": np.float64,
}

DEGREES = [8, 12, 16]

DEGREE_COLORS = {
    4: "#a6cee3",   # light_blue
    8: "#1f78b4",   # dark_blue
    12: "#33a02c",  # dark_green
    16: "#e31a1c",  # dark_red
}

DEGREE_MARKERS = {4: "s", 8: "D", 12: "^", 16: "v"}


def chebyshev_coefficients(f, degree, lower, upper):
    n = degree
    nodes = [pymath.cos(pymath.pi * j / n) for j in range(n + 1)]
    mid = (upper + lower) / 2.0
    half = (upper - lower) / 2.0
    values = [f(half * t + mid) for t in nodes]
    coeffs = []
    for k in range(n + 1):
        s = 0.0
        for j in range(n + 1):
            w = 0.5 if (j == 0 or j == n) else 1.0
            s += w * values[j] * pymath.cos(pymath.pi * k * j / n)
        coeffs.append(2.0 * s / n)
    return coeffs


def chebyshev_exp(x, degree, lower, upper):
    coeffs = chebyshev_coefficients(pymath.exp, degree, lower, upper)
    t = (2.0 * x - lower - upper) / (upper - lower)
    two_t = 2.0 * t
    b_prev2 = np.zeros_like(x, dtype=np.float64)
    b_prev1 = np.zeros_like(x, dtype=np.float64)
    for k in range(degree, 0, -1):
        b_k = two_t * b_prev1 - b_prev2 + coeffs[k]
        b_prev2 = b_prev1
        b_prev1 = b_k
    return coeffs[0] / 2.0 + t * b_prev1 - b_prev2


def main():
    x_max = -5
    n_points = 500

    plt.style.use("config/gridplot.mplstyle")
    fig, axes = plt.subplots(1, 3, figsize=(18, 5))

    for ax, (prec_name, dtype) in zip(axes, PRECISIONS.items()):
        x_min = float(np.log(np.finfo(dtype).smallest_subnormal))
        x = np.linspace(x_min, x_max, n_points)

        true_vals = np.exp(x)

        # Plot true exp(x)
        ax.plot(x, true_vals, color="black", linewidth=2, label="exp(x)", zorder=10)

        # Plot each Chebyshev approximation
        for d in DEGREES:
            approx = chebyshev_exp(x, d, lower=x_min, upper=x_max)
            ax.plot(
                x, approx,
                color=DEGREE_COLORS[d],
                linewidth=1.2,
                alpha=0.8,
                label=f"Chebyshev deg {d}",
            )

        ax.set_title(f"{prec_name}  (interval [{x_min:.1f}, {x_max}])")
        ax.set_xlabel("x")
        ax.axhline(y=0, color="gray", linewidth=0.5, linestyle="--")

    axes[0].set_ylabel("y")

    # Shared legend
    lines = [
        Line2D([], [], color="black", linewidth=2, label="exp(x)"),
    ] + [
        Line2D([], [], color=DEGREE_COLORS[d], linewidth=1.2, label=f"Chebyshev deg {d}")
        for d in DEGREES
    ]
    labels = [l.get_label() for l in lines]
    fig.legend(lines, labels, ncols=5, loc="upper center", bbox_to_anchor=(0.5, 1.05))

    fig.tight_layout(pad=2.5)

    out = Path("output/exp_chebyshev_vs_true.pdf")
    out.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(out)
    print(f"Saved to {out}")


if __name__ == "__main__":
    main()
