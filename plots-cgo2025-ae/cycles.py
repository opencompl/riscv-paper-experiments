from typing import Iterable, Sequence, cast
import pandas as pd
import numpy as np
import numpy.typing as npt
from plot_utils import IMPL_COLORS, IMPL_MARKERS, plot_combined, GridPlotRow
from matplotlib.axes import Axes

from math import log10, ceil, floor


class CyclesGridPlotRow(GridPlotRow):
    ylabel = "Cycles"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        max_value = cast(float, max(_df.max().iloc[0] for _df in dfs))
        magnitude: float = 10 ** floor(log10(max_value))
        greater_round_number = ceil(max_value / magnitude) * magnitude
        yrange = np.arange(0, greater_round_number + 1, greater_round_number // 10)
        return yrange

    @classmethod
    def plot_grid_cell(
        cls,
        ax: Axes,
        df: pd.DataFrame,
        *,
        hide_xlabel: bool,
    ) -> None:
        for col in df:
            ax.scatter(
                x=df.index,
                y=df[col],
                color=IMPL_COLORS[col],
                marker=IMPL_MARKERS[col],
            )
        ax.set_xticks(df.index)
        if not hide_xlabel:
            ax.set_xlabel(df.index.name, fontsize=12)


def plot_cycles(cycles_dfs: tuple[pd.DataFrame, ...]):
    return plot_combined(
        CyclesGridPlotRow.get_rows(cycles_dfs, 4),
        legend_cols=3,
        rcparams_cfg_file="config/gridplot.mplstyle",
    )
