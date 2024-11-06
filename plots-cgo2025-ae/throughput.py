from typing import Sequence, cast
import pandas as pd
import numpy as np
import numpy.typing as npt
from plot_utils import IMPL_COLORS, IMPL_MARKERS, plot_combined, GridPlotRow
from matplotlib.axes import Axes

from math import log2, ceil, floor


class ThroughputGridPlotRow(GridPlotRow):
    ylabel = "Throughput"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        max_value = cast(float, max(_df.max().iloc[0] for _df in dfs))
        magnitude: float = 2 ** floor(log2(max_value))
        greater_round_number = ceil(max_value / magnitude) * magnitude
        yrange = np.arange(0, greater_round_number + 1)
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
            if col == "Performance Roofline":
                continue
            ax.scatter(
                x=df.index,
                y=df[col],
                color=IMPL_COLORS[col],
                marker=IMPL_MARKERS[col],
            )
        ax.set_xticks(df.index)
        if not hide_xlabel:
            ax.set_xlabel(df.index.name, fontsize=12)

    @classmethod
    def get_roofline(cls, df: pd.DataFrame) -> float | None:
        max_throughputs = df["Performance Roofline"]
        max_throughput = max_throughputs.max()
        min_throughput = max_throughputs.min()
        assert max_throughput == min_throughput
        return max_throughput


def plot_throughput(throughput_dfs: tuple[pd.DataFrame, ...]):
    return plot_combined(
        ThroughputGridPlotRow.get_rows(throughput_dfs, 4),
        legend_cols=3,
        rcparams_cfg_file="config/gridplot.mplstyle",
    )
