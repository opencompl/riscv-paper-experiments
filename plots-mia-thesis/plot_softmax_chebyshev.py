#!/usr/bin/env python3
"""
Plot softmax computed with true exp vs Chebyshev approximations of degree 4,8,12,16.

Generates 10 random input vectors of length 10 in [-10, 5]. For each vector,
plots softmax(x) alongside Chebyshev-approximated softmax at degrees 4, 8, 12, 16.
"""

import math as pymath
import os
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.lines import Line2D

os.chdir(Path(__file__).resolve().parent)


DEGREES = [4, 8, 12, 16]

COLORS = {
    "softmax": "black",
    4: "#a6cee3",
    8: "#1f78b4",
    12: "#33a02c",
    16: "#e31a1c",
}


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
    x = np.asarray(x, dtype=np.float64)
    t = (2.0 * x - lower - upper) / (upper - lower)
    two_t = 2.0 * t
    b_prev2 = np.zeros_like(x, dtype=np.float64)
    b_prev1 = np.zeros_like(x, dtype=np.float64)
    for k in range(degree, 0, -1):
        b_k = two_t * b_prev1 - b_prev2 + coeffs[k]
        b_prev2 = b_prev1
        b_prev1 = b_k
    return coeffs[0] / 2.0 + t * b_prev1 - b_prev2


def softmax_chebyshev(x, degree):
    x = np.asarray(x, dtype=np.float64)
    max_x = np.max(x)
    shifted = x - max_x
    lower = float(np.min(shifted))
    upper = float(np.max(shifted))
    if lower == upper:
        return np.ones_like(x) / len(x)
    e = chebyshev_exp(shifted, degree, lower, upper)
    e = np.maximum(e, 0.0)
    s = np.sum(e)
    if s == 0:
        return np.ones_like(x) / len(x)
    return e / s


def main():
    rng = np.random.default_rng(42)
    n_plots = 10
    n_elements = 10
    inputs = [rng.uniform(-10, 300, size=n_elements) for _ in range(n_plots)]

    plt.style.use("config/gridplot.mplstyle")
    fig, axes = plt.subplots(2, 5, figsize=(22, 8))
    axes = axes.flatten()

    indices = np.arange(n_elements)

    for i, (ax, x) in enumerate(zip(axes, inputs)):
        x64 = np.asarray(x, dtype=np.float64)
        e = np.exp(x64)
        sm_true = e / np.sum(e)
        ax.plot(indices, sm_true, color=COLORS["softmax"], linewidth=3,
                marker="o", markersize=5, zorder=1, alpha=0.4)

        for zi, d in enumerate(DEGREES):
            sm_approx = softmax_chebyshev(x, d)
            ax.plot(indices, sm_approx, color=COLORS[d], linewidth=1.5,
                    alpha=0.9, marker=".", markersize=4, zorder=2 + zi)

        ax.set_title(f"Input {i+1}", fontsize=10)
        ax.set_xlabel("element index")
        if i % 5 == 0:
            ax.set_ylabel("softmax value")
        ax.set_xticks(indices)

    lines = [
        Line2D([], [], color=COLORS["softmax"], linewidth=2, marker="o",
               markersize=4, label="softmax (true exp)"),
    ] + [
        Line2D([], [], color=COLORS[d], linewidth=1.2, marker=".",
               markersize=3, label=f"c{d}_approx")
        for d in DEGREES
    ]
    labels = [l.get_label() for l in lines]
    fig.legend(lines, labels, ncols=5, loc="upper center",
               bbox_to_anchor=(0.5, 1.04))

    fig.tight_layout(pad=2.5)

    out = Path("output/softmax_chebyshev.pdf")
    out.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(out, bbox_inches="tight")
    print(f"Saved to {out}")


if __name__ == "__main__":
    main()
