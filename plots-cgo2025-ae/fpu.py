from typing import Sequence
from matplotlib.axes import Axes
import pandas as pd
import numpy as np
import numpy.typing as npt
from data import Impl, Operator, get_operator_df, get_params_dfs
from plot_utils import IMPL_COLORS, IMPL_MARKERS, GridPlotRow, plot_combined


def all_plot_dfs(
    pivoted_df: pd.DataFrame, operators: tuple[Operator, ...]
) -> tuple[pd.DataFrame, ...]:
    return tuple(
        param_df
        for operator in operators
        for param_df in get_params_dfs(
            get_operator_df(pivoted_df, operator, bitwidth=64)
        )
    )


def get_fpu(pivoted_fpu_df: pd.DataFrame) -> tuple[pd.DataFrame, ...]:
    return all_plot_dfs(
        pivoted_fpu_df.filter([Impl.OURS, Impl.CLANG, Impl.MLIR]),
        (
            Operator.SUM,
            Operator.FILL,
            Operator.RELU,
            Operator.CONV,
            Operator.MAX_POOL,
            Operator.SUM_POOL,
            # Operator.MATMUL, # Matmul included in other plot
        ),
    )


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


def plot_fpu(fpu_dfs: tuple[pd.DataFrame, ...]):
    return plot_combined(
        FPUGridPlotRow.get_rows(fpu_dfs, 6, hide_xtick_labels=[True, False]),
        legend_cols=4,
        rcparams_cfg_file="config/gridplot.mplstyle",
    )
