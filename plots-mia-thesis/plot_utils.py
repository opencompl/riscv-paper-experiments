from collections.abc import Iterable
from typing import ClassVar, Sequence, cast
import math
import os
import re
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.axes import Axes
from matplotlib.figure import Figure
import numpy as np
import numpy.typing as npt
import seaborn as sns
from matplotlib.lines import Line2D
from data import Impl
from abc import ABC, abstractmethod


###########################################################
# Color palette
###########################################################

light_gray = "#cacaca"
dark_gray = "#827b7b"
light_blue = "#a6cee3"
dark_blue = "#1f78b4"
light_green = "#b2df8a"
dark_green = "#33a02c"
light_red = "#fb9a99"
dark_red = "#e31a1c"
black = "#000000"
white = "#ffffff"

COLORS = [
    light_gray,
    dark_gray,
    light_blue,
    dark_blue,
    light_green,
    dark_green,
    light_red,
    dark_red,
]


###########################################################
# RQ shared constants & helpers (plot_rq*.py)
###########################################################

# Precision metadata — sizes in bytes and IEEE-754 mantissa widths (with hidden bit).
PRECISIONS: list[str] = ["f16", "f32", "f64"]
PRECISION_BYTES: dict[str, int] = {"f16": 2, "f32": 4, "f64": 8}
PRECISION_MANTISSA_BITS: dict[str, int] = {"f16": 11, "f32": 24, "f64": 53}
PRECISION_NUMPY_DTYPE: dict[str, type] = {
    "f16": np.float16, "f32": np.float32, "f64": np.float64,
}

# Chebyshev domain & degree variants — must match the Snakefile.
CHEBYSHEV_DOMAIN_LOWER: float = -2.0
CHEBYSHEV_DOMAIN_UPPER: float = 0.0
CHEBYSHEV_DEGREES: list[int] = list(range(2, 13))

# Regex matching the variant names in XDSL_LINALG_CHEBYSHEV_DEGREE_VARIANTS.
CHEBYSHEV_DEGREE_RE: re.Pattern[str] = re.compile(r"linalg_xdsl_d(\d+)$")

# One (color, linestyle) per Chebyshev degree — used by plot_rq11 / plot_rq3 to
# keep curves directly comparable across plots. There are 11 degrees but only
# 8 colors in the project palette, so we cycle the colors and switch to a
# dashed style on wrap-around — every (color, linestyle) pair is unique.
_DEGREE_LINESTYLE_CYCLE: tuple[str, ...] = ("-", "--", ":")
DEGREE_COLORS: dict[int, str] = {
    d: COLORS[i % len(COLORS)]
    for i, d in enumerate(CHEBYSHEV_DEGREES)
}
DEGREE_LINESTYLES: dict[int, str] = {
    d: _DEGREE_LINESTYLE_CYCLE[(i // len(COLORS)) % len(_DEGREE_LINESTYLE_CYCLE)]
    for i, d in enumerate(CHEBYSHEV_DEGREES)
}


def chebyshev_lobatto_coeffs(degree: int) -> list[float]:
    """DCT-I coefficients of the degree-`degree` Lobatto interpolant of exp
    on [CHEBYSHEV_DOMAIN_LOWER, CHEBYSHEV_DOMAIN_UPPER].

    Mirrors get_chebyshev_coeffs_from_variant in the Snakefile. The returned
    coefficients use the "double-prime" convention: c_0 and c_n are NOT
    pre-halved, so eval_chebyshev applies a 1/2 weight to the endpoints.
    """
    n = degree
    nodes = [math.cos(math.pi * j / n) for j in range(n + 1)]
    mid = (CHEBYSHEV_DOMAIN_UPPER + CHEBYSHEV_DOMAIN_LOWER) / 2.0
    half = (CHEBYSHEV_DOMAIN_UPPER - CHEBYSHEV_DOMAIN_LOWER) / 2.0
    values = [math.exp(half * t + mid) for t in nodes]
    coeffs: list[float] = []
    for k in range(n + 1):
        s = 0.0
        for j in range(n + 1):
            w = 0.5 if (j == 0 or j == n) else 1.0
            s += w * values[j] * math.cos(math.pi * k * j / n)
        coeffs.append(2.0 * s / n)
    return coeffs


def eval_chebyshev(coeffs: Sequence[float], x: np.ndarray) -> np.ndarray:
    """Evaluate the double-prime Chebyshev expansion at x ∈ [domain_lower, domain_upper]."""
    mid = (CHEBYSHEV_DOMAIN_UPPER + CHEBYSHEV_DOMAIN_LOWER) / 2.0
    half = (CHEBYSHEV_DOMAIN_UPPER - CHEBYSHEV_DOMAIN_LOWER) / 2.0
    t = (x - mid) / half
    n = len(coeffs) - 1
    tk_prev = np.ones_like(t)
    tk = t.copy()
    result = 0.5 * coeffs[0] * tk_prev + (coeffs[1] * tk if n >= 1 else 0.0)
    for k in range(2, n + 1):
        tk_next = 2.0 * t * tk - tk_prev
        weight = 0.5 if k == n else 1.0
        result = result + weight * coeffs[k] * tk_next
        tk_prev, tk = tk, tk_next
    return result


def eval_chebyshev_clenshaw_lowered(
    coeffs: Sequence[float],
    x: np.ndarray,
    precision: str,
    domain_lower: float = CHEBYSHEV_DOMAIN_LOWER,
    domain_upper: float = CHEBYSHEV_DOMAIN_UPPER,
) -> np.ndarray:
    """Evaluate the Chebyshev series the way the xDSL lowering actually does.

    Mirrors, bit-for-bit, the arithmetic emitted by the two passes
    `lower-exp-to-polynomial` -> `expand-polynomial-eval` (function
    `expand_clenshaw` in xdsl/transforms/expand_polynomial_eval.py):

      * `coeffs` are the *double-precision* Chebyshev-Lobatto coefficients
        carried by the `polynomial.eval` op (see `chebyshev_lobatto_coeffs` —
        the same DCT-I values the Snakefile bakes into the IR);
      * the domain-map scale/offset, the constant 2.0, every coefficient and
        `coeffs[0]/2` are materialised as `arith.constant`s of the *element
        type*, i.e. each is rounded to `precision` (exactly what `FloatAttr`
        does);
      * every `mulf`/`addf`/`subf` rounds its result back to `precision`.

    Unlike `eval_chebyshev` (which sums the double-prime series in f64 and only
    rounds the final result), this reproduces the rounding error introduced at
    every operation, so it measures the error of the code the compiler emits.

    Validated bit-identical to running `expand-polynomial-eval` on the
    generated IR for f16/f32/f64 and degrees 2..12 across [domain_lower,
    domain_upper].
    """
    dtype = PRECISION_NUMPY_DTYPE[precision]
    R = lambda v: dtype(v)  # round a python float to the element type  # noqa: E731
    xt = np.asarray(x, dtype=dtype)
    n = len(coeffs) - 1

    # domain map: t = x * scale + offset (each op in the element type)
    scale = R(2.0 / (domain_upper - domain_lower))
    offset = R(-(domain_upper + domain_lower) / (domain_upper - domain_lower))
    scaled = (xt * scale).astype(dtype)
    t = (scaled + offset).astype(dtype)

    # Clenshaw recurrence, all arithmetic in the element type
    two = R(2.0)
    two_t = (two * t).astype(dtype)
    b_prev2 = np.full_like(xt, R(0.0))  # b_{n+2}
    b_prev1 = np.full_like(xt, R(0.0))  # b_{n+1}
    for k in range(n, 0, -1):
        c_k = R(coeffs[k])
        two_t_b = (two_t * b_prev1).astype(dtype)
        sub = (two_t_b - b_prev2).astype(dtype)
        b_k = (sub + c_k).astype(dtype)
        b_prev2, b_prev1 = b_prev1, b_k

    # final: result = c_0/2 + t * b_1 - b_2
    c0_half = R(coeffs[0] / 2.0)
    t_b1 = (t * b_prev1).astype(dtype)
    add = (c0_half + t_b1).astype(dtype)
    return (add - b_prev2).astype(dtype)


def ulp(values: np.ndarray, precision: str) -> np.ndarray:
    """ULP of each value, evaluated in the given precision (f16/f32/f64)."""
    dtype = PRECISION_NUMPY_DTYPE[precision]
    v = np.asarray(values, dtype=dtype)
    return (np.nextafter(v, np.array(np.inf, dtype=dtype)) - v).astype(np.float64)


def annotate_kernel_df(df: pd.DataFrame) -> pd.DataFrame:
    """Add precision, total_elements, total_input_bytes, cycles_per_byte columns
    derived from the kernel `params` string (e.g. "64xf32").
    """
    parts = df["params"].str.split("x")
    df = df.copy()
    df["precision"] = parts.str[-1]
    df["total_elements"] = parts.apply(
        lambda ps: int(np.prod([int(p) for p in ps[:-1]]))
    )
    df["total_input_bytes"] = df.apply(
        lambda r: r["total_elements"] * PRECISION_BYTES[r["precision"]], axis=1
    )
    df["cycles_per_byte"] = df["cycles"] / df["total_input_bytes"]
    return df


def load_chebyshev_csv(csv_path: str) -> pd.DataFrame:
    """Load exp_polynomial measurements, keep only Chebyshev-degree variants,
    and add a `degree` column."""
    df = pd.read_csv(csv_path)
    df = df[df["impl"].str.match(CHEBYSHEV_DEGREE_RE)].copy()
    df["degree"] = df["impl"].str.extract(CHEBYSHEV_DEGREE_RE).astype(int)
    return annotate_kernel_df(df)


def load_baseline_csv(csv_path: str) -> pd.DataFrame:
    """Load exp_micro measurements and keep only the libm baseline rows."""
    df = pd.read_csv(csv_path)
    df = df[df["impl"] == "baseline"].copy()
    return annotate_kernel_df(df)


def load_vendor_csv(csv_path: str) -> pd.DataFrame:
    """Load exp_macro measurements and keep only the vendor kernel (snrt) rows.

    The vendor kernel is only measured in f64, so the returned frame contains
    f64 rows only.
    """
    df = pd.read_csv(csv_path)
    df = df[df["impl"] == "snrt"].copy()
    return annotate_kernel_df(df)


###########################################################
# Existing project plotting infrastructure
###########################################################

IMPL_COLORS = {
    Impl.OURS.value: dark_green,
    Impl.CLANG.value: light_blue,
    Impl.MLIR.value: dark_blue,
    "Min Cycles": dark_gray,
    "Overhead": dark_red,
    "Performance Roofline": dark_gray,
    "Exp_baseline": light_blue,
    "Exp_snrt": dark_blue
}

IMPL_MARKERS = {
    Impl.OURS.value: 'o',
    Impl.CLANG.value: 's',
    Impl.MLIR.value: 'v',
    "Min Cycles": '^',
    "Overhead": 'x',
    "Performance Roofline": "",
    "Exp_baseline": "o",
    "Exp_snrt": "s",
}

IMPL_LINESTYLES = {
    Impl.OURS.value: '',
    Impl.CLANG.value: '',
    Impl.MLIR.value: '',
    "Min Cycles": '',
    "Overhead": '',
    "Performance Roofline": "--",
    "Exp_baseline": "",
    "Exp_snrt": "",
}


class GridPlotRow(ABC):
    ylabel: ClassVar[str]

    dfs: Sequence[pd.DataFrame]
    hide_xlabel: bool
    hide_xtick_labels: bool

    def __init__(
        self,
        dfs: Sequence[pd.DataFrame],
        *,
        hide_xlabel: bool = False,
        hide_xtick_labels: bool = False,
    ) -> None:
        self.dfs = dfs
        self.hide_xlabel = hide_xlabel
        self.hide_xtick_labels = hide_xtick_labels

    @classmethod
    @abstractmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        raise NotImplementedError

    @classmethod
    @abstractmethod
    def plot_grid_cell(cls, ax: Axes, df: pd.DataFrame, *, hide_xlabel: bool) -> None:
        raise NotImplementedError

    @classmethod
    def get_roofline(cls, df: pd.DataFrame) -> float | None:
        return None

    def plot_grid_row(self, axs: Sequence[Axes]):
        yrange = self.yrange(self.dfs)

        for i, (_ax, _d) in enumerate(zip(axs, self.dfs)):
            self.plot_grid_cell(
                _ax,
                _d,
                hide_xlabel=self.hide_xlabel,
            )

            if (roofline := self.get_roofline(_d)) is not None:
                _ax.axhline(
                    y=roofline,
                    color=IMPL_COLORS["Performance Roofline"],
                    linestyle=IMPL_LINESTYLES["Performance Roofline"],
                )

            _ax.set_yticks(yrange)
            ytick_distance = (yrange[-1] - yrange[0]) / len(yrange)
            # add extra distance for the yaxis to avoid graph truncation and
            # misaligned y-axis ticks in subplots
            _ax.set_ylim(yrange[0], yrange[-1] + ytick_distance / 10)

            _ax.yaxis.grid(True)
            _ax.tick_params(axis="both", which="both", left=True)

            yticks = _ax.yaxis.get_major_ticks()
            for _j, ytick in enumerate(yticks):
                if _j % 2:
                    ytick.label1.set_visible(False)
                    ytick.tick1line.set_visible(False)
                if i:
                    ytick.label1.set_visible(False)

            # Improve readability when we have too many xticks
            # (e.g.: matmul with lots of data points)
            xtick_labels = _ax.get_xticklabels()
            if len(xtick_labels) > 10:
                for label in xtick_labels:
                    label.set_rotation(90)

            sns.despine(top=True, right=True)

            if self.hide_xtick_labels:
                _ax.set_xticklabels([])

        # y axis label on first column only
        axs[0].set_ylabel(self.ylabel)

    @classmethod
    def get_rows(
        cls,
        dfs: Sequence[pd.DataFrame],
        ncols: int,
        *,
        hide_xlabel: bool = False,
        hide_xtick_labels: list[bool] = [],
    ) -> tuple["GridPlotRow", ...]:
        num_plots = len(dfs)
        rng = range(0, num_plots, ncols)

        if hide_xtick_labels == []:
            hide_xtick_labels = [False] * len(rng)

        assert len(rng) == len(hide_xtick_labels)

        return tuple(
            cls(
                dfs[offset : offset + ncols],
                hide_xlabel=hide_xlabel,
                hide_xtick_labels=hide_xtick_labels[i],
            )
            for i, offset in enumerate(rng)
        )


def get_legend_entries(dfs: Sequence[pd.DataFrame]) -> dict[str, tuple[str, str, str]]:
    return {
        col: (IMPL_COLORS[col], IMPL_MARKERS[col], IMPL_LINESTYLES[col])
        for _d in dfs
        for col in cast(Iterable[str], _d)
    }


def despine(fig: Figure):
    """Drop the top and right spines on every axis of `fig`."""
    sns.despine(fig=fig, top=True, right=True)


def savefig(fig: Figure, filename: str):
    fig.savefig(filename)


def subplots(nrows: int, ncols: int, figsize: tuple[float, float]):
    fig, axs = plt.subplots(nrows=nrows, ncols=ncols, figsize=figsize, sharey=False)

    # plt.subplots returns different types depending on nrows and ncols
    # These normalise the type to always be doubly-nested sequence
    if nrows == 1:
        axs = [axs]
    if ncols == 1:
        axs = [[ax] for ax in axs]

    return fig, cast(Sequence[Sequence[Axes]], axs)


def plot_combined(
    rows: Sequence["GridPlotRow"],
    rcparams_cfg_file: str = "",
    *,
    legend_cols: int,
    figsize: tuple[float, float] | None = None,
):
    nrows = len(rows)
    ncols = max(len(row.dfs) for row in rows)
    if os.path.exists(rcparams_cfg_file):
        plt.style.use(rcparams_cfg_file)

    if figsize is None:
        figsize = (ncols * 2.5, nrows * 1.8)
    fig, axs = subplots(nrows, ncols, figsize)

    fig.align_labels()
    fig.subplots_adjust(hspace=0.5, wspace=0.3)

    for plot_row, axs_row in zip(rows, axs):
        plot_row.plot_grid_row(axs_row)

        # Remove empty subplots
        empty_axs = ncols - len(plot_row.dfs)
        if empty_axs:
            for ax in axs_row[-empty_axs:]:
                fig.delaxes(ax)

    # Shared legend
    legend_entries = get_legend_entries(tuple(df for row in rows for df in row.dfs))
    lines = [
        Line2D(
            [],
            [],
            color=color,
            marker=marker,
            label=entry,
            linestyle=linestyle,
            markersize=6,
        )
        for entry, (color, marker, linestyle) in legend_entries.items()
    ]
    labels = list(legend_entries.keys())
    fig.legend(lines, labels, ncols=legend_cols, bbox_to_anchor=(0.5, 1.0))

    fig.tight_layout(pad=2.5)

    return fig
