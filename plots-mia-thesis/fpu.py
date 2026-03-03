from typing import Sequence
from matplotlib.axes import Axes
import pandas as pd
import numpy as np
import numpy.typing as npt
from plot_utils import IMPL_COLORS, IMPL_MARKERS, GridPlotRow


class FPUGridPlotRow(GridPlotRow):
    ylabel = "FPU Utilization"

    @classmethod
    def yrange(cls, dfs: Sequence[pd.DataFrame]) -> npt.NDArray[np.float64]:
        return np.arange(0.0, 1.1, 0.1)

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
            ax.set_xlabel(df.index.name)

    @classmethod
    def get_roofline(cls, df: pd.DataFrame) -> float | None:
        df['Performance Roofline'] = 1.0
        return 1.0
