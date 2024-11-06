from collections.abc import Iterable
from typing import ClassVar, Sequence, cast
import os
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

# Color palette
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


IMPL_COLORS = {
    Impl.OURS.value: dark_green,
    Impl.CLANG.value: light_blue,
    Impl.MLIR.value: dark_blue,
    "Min Cycles": dark_gray,
    "Overhead": dark_red,
    "Performance Roofline": dark_gray,
}

IMPL_MARKERS = {
    Impl.OURS.value: 'o',
    Impl.CLANG.value: 's',
    Impl.MLIR.value: 'v',
    "Min Cycles": '^',
    "Overhead": 'x',
    "Performance Roofline": "",
}

IMPL_LINESTYLES = {
    Impl.OURS.value: '',
    Impl.CLANG.value: '',
    Impl.MLIR.value: '',
    "Min Cycles": '',
    "Overhead": '',
    "Performance Roofline": "--",
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
    rows: Sequence["GridPlotRow"], rcparams_cfg_file: str = "", *, legend_cols: int
):
    nrows = len(rows)
    ncols = max(len(row.dfs) for row in rows)
    if os.path.exists(rcparams_cfg_file):
        plt.style.use(rcparams_cfg_file)

    fig, axs = subplots(nrows, ncols, (ncols * 2.5, nrows * 1.8))

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
    fig.legend(lines, labels, ncols=legend_cols, bbox_to_anchor=(0.5, 1.03))

    fig.tight_layout()

    return fig
