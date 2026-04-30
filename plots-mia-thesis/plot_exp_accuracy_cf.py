#!/usr/bin/env python3
"""
Plot accuracy of exp approximations using HEIR's approach:
CF (Caratheodory-Fejer) approximation + Chebyshev Paterson-Stockmeyer evaluation.

Port of HEIR's pipeline from:
https://github.com/google/heir/blob/980e966/lib/Utils/Approximation/CaratheodoryFejer.cpp
https://github.com/google/heir/blob/980e966/lib/Utils/Polynomial/ChebyshevPatersonStockmeyer.h

One plot per precision (f16, f32, f64).
Each plot has lines for degree={4,8,12,16} showing |np.exp(x) - cf_ps_d(x)| vs x.
"""

import argparse
import os
from pathlib import Path
from typing import Sequence

import numpy as np
import numpy.typing as npt
import pandas as pd
from matplotlib.axes import Axes

from plot_utils import IMPL_COLORS, IMPL_MARKERS, GridPlotRow, plot_combined, savefig

os.chdir(Path(__file__).resolve().parent)

PRECISIONS = {
    "f16": np.float16,
    "f32": np.float32,
    "f64": np.float64,
}

DEGREES = [4, 8, 12, 16]

DEGREE_KEYS = {d: f"Exp_linalg_xdsl_c{d}" for d in DEGREES}


# ---------------------------------------------------------------------------
# Chebyshev interpolation (port of HEIR's Chebyshev.cpp)
# ---------------------------------------------------------------------------

def chebyshev_points(n: int) -> np.ndarray:
    """Chebyshev points of the second kind on [-1, 1], left to right."""
    if n == 0:
        return np.array([])
    if n == 1:
        return np.array([0.0])
    m = n - 1
    j = np.arange(-m, m + 1, 2)
    return np.sin(np.pi * j / (2 * m))


def interpolate_chebyshev(values: np.ndarray) -> np.ndarray:
    """Compute Chebyshev coefficients from function values at Chebyshev points.

    Port of HEIR's interpolateChebyshev (vals2coeffs via FFT/DCT).
    """
    n = len(values)
    if n == 0:
        return np.array([])
    if n == 1:
        return values.copy()

    # Construct input to IFFT for DCT:
    # [v_{n-1}, v_{n-2}, ..., v_0, v_1, ..., v_{n-2}]
    fft_input = np.concatenate([values[::-1][:-1], values[:-1]])
    ifft_result = np.fft.ifft(fft_input).real

    coeffs = ifft_result[:n].copy()
    # Non-endpoint coefficients are scaled by 2
    coeffs[1:n - 1] *= 2.0

    return coeffs


def standard_chop(coeffs: np.ndarray, tol: float = 1e-16) -> int:
    """Port of chebfun's standardChop. Returns cutoff index."""
    if tol >= 1:
        return 1
    n = len(coeffs)
    if n < 17:
        return n

    # Step 1: monotonically nonincreasing envelope
    abs_coeffs = np.abs(coeffs)
    envelope = np.maximum.accumulate(abs_coeffs[::-1])[::-1]
    if envelope[0] == 0:
        return 1
    envelope = envelope / envelope[0]

    # Step 2: scan for plateau
    plateau_point = 0
    j2 = 0
    for j in range(2, n + 1):
        j2 = int(round(1.25 * j + 5))
        if j2 > n:
            return n
        e1 = envelope[j - 1]
        e2 = envelope[j2 - 2]
        if e1 == 0:
            r = float('inf')
        else:
            r = 3 * (1 - np.log(e1) / np.log(tol))
        if e1 == 0 or (e2 / e1) > r:
            plateau_point = j - 2
            break

    if envelope[plateau_point] == 0:
        return plateau_point

    # Step 3: refine cutoff
    tol_pow = tol ** (7.0 / 6.0)
    j3 = int(np.sum(envelope >= tol_pow))
    if j3 < j2:
        j2 = j3 + 1
        if j2 < len(envelope):
            envelope[j2] = tol_pow

    cc = np.log10(np.maximum(envelope[:j2], 1e-320))
    if j2 > 1:
        cc += np.linspace(0, (-1.0 / 3.0) * np.log10(tol), j2)

    cutoff = max(int(np.argmin(cc)), 1)
    return cutoff


def interpolate_chebyshev_smart(func, tol=1e-16, max_degree=129):
    """Adaptively find Chebyshev interpolant degree. Port of HEIR's smart selection."""
    deg = 17
    while deg <= max_degree:
        num_pts = 1 + deg
        pts = chebyshev_points(num_pts)
        vals = np.array([func(x) for x in pts])
        coeffs = interpolate_chebyshev(vals)

        cutoff = standard_chop(coeffs, tol)
        if cutoff < deg:
            return coeffs[:cutoff]
        deg = 2 * deg - 1

    # Return full coefficients at max degree
    return coeffs


# ---------------------------------------------------------------------------
# Caratheodory-Fejer approximation (port of HEIR's CaratheodoryFejer.cpp)
# ---------------------------------------------------------------------------

def cf_approximation_unit_interval(func, degree: int) -> np.ndarray:
    """CF approximation on [-1, 1]. Returns Chebyshev coefficients.

    Port of HEIR's caratheodoryFejerApproximationUnitInterval.
    """
    cheb_coeffs = interpolate_chebyshev_smart(func)
    cheb_degree = len(cheb_coeffs) - 1

    if cheb_degree <= degree:
        return cheb_coeffs

    # Tail coefficients for Hankel matrix
    tail = cheb_coeffs[degree + 1:]
    hankel_size = len(tail)

    # Build Hankel matrix
    hankel = np.zeros((hankel_size, hankel_size))
    for i in range(hankel_size):
        for j in range(hankel_size):
            if i + j < hankel_size:
                hankel[i, j] = tail[i + j]

    # Eigendecomposition
    eigenvalues, eigenvectors = np.linalg.eigh(hankel)

    # Find eigenvector for largest absolute eigenvalue
    max_idx = np.argmax(np.abs(eigenvalues))
    max_eigvec = eigenvectors[:, max_idx]

    v1 = max_eigvec[0]
    vv = max_eigvec[1:]

    b = list(tail)
    t = cheb_degree - degree - 1

    for i in range(degree, -degree - 1, -1):
        slice_b = b[:t]
        s = sum(slice_b[j] * vv[j] for j in range(len(slice_b)))
        z = -s / v1
        b.insert(0, z)

    bb = list(b[degree: 2 * degree + 1])
    for i in range(1, len(bb)):
        bb[i] = bb[i] + b[degree - 1 - (i - 1)]

    pk = np.array([cheb_coeffs[i] - bb[i] for i in range(len(bb))])
    return pk


def cf_approximation(func, degree: int, lower: float, upper: float) -> np.ndarray:
    """CF approximation on [lower, upper]. Returns Chebyshev coefficients."""
    mid = (lower + upper) / 2.0
    half = (upper - lower) / 2.0

    def scaled_func(x):
        return func(mid + half * x)

    return cf_approximation_unit_interval(scaled_func, degree)


# ---------------------------------------------------------------------------
# Chebyshev decomposition (port of HEIR's ChebyshevDecomposition.cpp)
# ---------------------------------------------------------------------------

def chebyshev_divide(p: list[float], k: int) -> tuple[list[float], list[float]]:
    """Divide Chebyshev polynomial p by T_k: find q, r such that p = q*T_k + r.

    Uses the identity 2*T_m*T_n = T_{m+n} + T_{|m-n|}.
    Port of HEIR's dividePolynomials.
    """
    if k >= len(p):
        return [], list(p)

    p = list(p)  # work on a copy
    q = [0.0] * (len(p) - k)

    for i in range(len(p) - 1, k - 1, -1):
        if p[i] == 0.0:
            continue
        if i == k:
            q[0] = p[i]
        else:
            # p_i*T_i = p_i*(2*T_k*T_{i-k} - T_{|i-2k|})
            q[i - k] = p[i] * 2.0
            p[abs(i - 2 * k)] -= p[i]
            p[i] = 0.0

    r = p[:k]
    return q, r


def chebyshev_decompose(coeffs: list[float], k: int) -> list[list[float]]:
    """Decompose p = p_0 + p_1*T_k + p_2*T_k^2 + ...

    Each p_i is a Chebyshev polynomial of degree < k.
    Port of HEIR's decompose.
    """
    p = list(coeffs)
    result = []
    while p:
        p, remainder = chebyshev_divide(p, k)
        result.append(remainder)
    return result


# ---------------------------------------------------------------------------
# Chebyshev Paterson-Stockmeyer evaluation (port of HEIR's
# ChebyshevPatersonStockmeyer.h)
# ---------------------------------------------------------------------------

def optimal_split(log_degree: int) -> int:
    """Port of HEIR's optimalSplit (from Lattigo)."""
    log_split = log_degree >> 1
    a = (1 << log_split) + (1 << (log_degree - log_split)) + log_degree - log_split - 3
    b = (1 << (log_split + 1)) + (1 << (log_degree - log_split - 1)) + log_degree - log_split - 4
    if a > b:
        log_split += 1
    return log_split


def split_degree(n: int) -> tuple[int, int]:
    """Split n = a + b minimizing |a-b|, preferring odd values for Chebyshev.

    Port of HEIR's splitDegree (based on Lee et al. 2020).
    """
    assert n > 0
    if (n & (n - 1)) == 0:
        return n // 2, n // 2
    k = (n - 1).bit_length() - 1
    a = (1 << k) - 1
    b = n - a
    return a, b


def compute_chebyshev_T(t: np.ndarray, max_degree: int) -> dict[int, np.ndarray]:
    """Compute T_0(t), T_1(t), ..., T_{max_degree}(t) using the recursive
    doubling approach from HEIR's genChebyshevPowerRecursive.

    Uses T_n = 2*T_a*T_b - T_{|a-b|} where (a,b) = splitDegree(n).
    """
    cache: dict[int, np.ndarray] = {}

    def get_T(n: int) -> np.ndarray:
        if n in cache:
            return cache[n]
        if n == 0:
            cache[0] = np.ones_like(t, dtype=np.float64)
            return cache[0]
        if n == 1:
            cache[1] = t.copy()
            return cache[1]
        a, b = split_degree(n)
        T_a = get_T(a)
        T_b = get_T(b)
        c = abs(a - b)
        T_c = get_T(c)
        cache[n] = 2.0 * T_a * T_b - T_c
        return cache[n]

    for i in range(max_degree + 1):
        get_T(i)
    return cache


MIN_COEFF = 1e-15


def eval_chebyshev_ps(coeffs: np.ndarray, x: np.ndarray,
                      lower: float, upper: float) -> np.ndarray:
    """Evaluate Chebyshev polynomial using Paterson-Stockmeyer as in HEIR.

    Port of HEIR's patersonStockmeyerChebyshevPolynomialEvaluation.
    Coefficients follow the convention f(x) = sum_k c_k T_k(x).
    """
    # Map x from [lower, upper] to [-1, 1]
    t = (2.0 * x - lower - upper) / (upper - lower)

    degree = len(coeffs) - 1
    if degree < 0:
        return np.zeros_like(x, dtype=np.float64)
    if degree == 0:
        return np.full_like(x, float(coeffs[0]), dtype=np.float64)

    # Choose k using HEIR's optimal split
    log_degree = int(degree).bit_length()
    log_split = optimal_split(log_degree)
    k = 1 << log_split

    # Decompose p = p_0 + p_1*T_k + p_2*T_k^2 + ...
    decomposition = chebyshev_decompose(list(coeffs), k)

    # Precompute T_0(t) .. T_k(t) using recursive doubling
    T_vals = compute_chebyshev_T(t, k)

    # Evaluate baby steps: each p_i(t) = sum_j p_i[j] * T_j(t)
    baby_steps: list[np.ndarray | None] = []
    for sub_coeffs in decomposition:
        if not any(abs(c) >= MIN_COEFF for c in sub_coeffs):
            baby_steps.append(None)
            continue
        pol = np.zeros_like(t, dtype=np.float64)
        for j, c in enumerate(sub_coeffs):
            if abs(c) >= MIN_COEFF:
                pol = pol + c * T_vals[j]
        baby_steps.append(pol)

    # Combine baby steps in tree structure using T_k
    y = T_vals[k]  # T_k(t)
    y_power = y.copy()
    while len(baby_steps) > 1:
        next_steps: list[np.ndarray | None] = []
        for i in range(0, len(baby_steps), 2):
            combined = baby_steps[i]
            if i + 1 < len(baby_steps) and baby_steps[i + 1] is not None:
                scaled = baby_steps[i + 1] * y_power
                if combined is not None:
                    combined = combined + scaled
                else:
                    combined = scaled
            next_steps.append(combined)
        baby_steps = next_steps
        y_power = y_power * y_power  # T_k^{2^i} via squaring

    result = baby_steps[0]
    return result if result is not None else np.zeros_like(t, dtype=np.float64)


# ---------------------------------------------------------------------------
# Plotting
# ---------------------------------------------------------------------------

def build_accuracy_dfs(x_max: float, n_points: int) -> list[pd.DataFrame]:
    dfs = []
    for prec_name, dtype in PRECISIONS.items():
        x_min = float(np.log(np.finfo(dtype).smallest_subnormal))
        x_f64 = np.linspace(x_min, x_max, n_points)
        x = x_f64.astype(dtype)

        baseline = np.exp(x.astype(np.float64)).astype(dtype)

        data = {}
        for d in DEGREES:
            cf_coeffs = cf_approximation(np.exp, d, lower=x_min, upper=x_max)
            approx = eval_chebyshev_ps(cf_coeffs, x.astype(np.float64), x_min, x_max)
            error = np.abs(baseline.astype(np.float64) - approx)
            error[~np.isfinite(error)] = np.nan
            data[DEGREE_KEYS[d]] = error

        df = pd.DataFrame(data, index=x.astype(np.float64))
        df.index.name = f"x ({prec_name})"
        dfs.append(df)
    return dfs


class ExpAccuracyPlotRow(GridPlotRow):
    ylabel = "|exp(x) - cf_ps_d(x)|"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        all_vals = pd.concat(dfs).replace(0, np.nan).dropna(how="all")
        finite_min = all_vals.min().min()
        finite_max = all_vals.max().max()
        if not np.isfinite(finite_min) or not np.isfinite(finite_max) or finite_min <= 0:
            return np.logspace(-16, 2, num=19)
        log_min = np.floor(np.log10(finite_min))
        log_max = np.ceil(np.log10(finite_max))
        return np.logspace(log_min, log_max, num=int(log_max - log_min) + 1)

    @classmethod
    def plot_grid_cell(cls, ax: Axes, df: pd.DataFrame, *, hide_xlabel: bool) -> None:
        for col in df:
            ax.plot(
                df.index, df[col],
                color=IMPL_COLORS[col], marker=IMPL_MARKERS[col],
                markevery=max(1, len(df) // 20), markersize=4,
            )
        ax.set_yscale("log")
        if not hide_xlabel:
            ax.set_xlabel(df.index.name)


def main():
    parser = argparse.ArgumentParser(description="Plot CF exp accuracy")
    parser.add_argument("--output", "-o", default="output/exp_accuracy_cf.pdf")
    parser.add_argument("--x-max", type=float, default=0.5)
    parser.add_argument("--n-points", type=int, default=1000)
    args = parser.parse_args()

    Path(args.output).parent.mkdir(parents=True, exist_ok=True)

    dfs = build_accuracy_dfs(args.x_max, args.n_points)
    rows = [ExpAccuracyPlotRow(dfs)]
    fig = plot_combined(
        rows,
        legend_cols=len(DEGREES),
        rcparams_cfg_file="config/gridplot.mplstyle",
        figsize=(len(dfs) * 6, 4),
    )
    savefig(fig, args.output)
    print(f"Saved plot to {args.output}")


if __name__ == "__main__":
    main()
