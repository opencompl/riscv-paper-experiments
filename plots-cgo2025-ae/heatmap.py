#!/usr/bin/env python3

from pathlib import Path

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import argparse
import os

SCRIPT_DIR = Path(os.path.dirname(os.path.abspath(__file__)))
RESULTS_DIR = SCRIPT_DIR / "results"


def add_metrics(data: pd.DataFrame) -> pd.DataFrame:
    if "fp_inst_throughput" not in data:
        data["fp_inst_throughput"] = data["fpss_fpu_issues"] / data["cycles"]
    if "fp_flop_throughput" not in data:
        data["fp_flop_throughput"] = (
            data["fpss_fpu_issues"] + data["fpss_fpu_fmadd_issues"]
        ) / data["cycles"]
    return data


def highlight_1_8_cells(ax: plt.axes, df: pd.DataFrame):
    Ks = df["K"].unique()
    Ns = df["N"].unique()
    threshold = 1.8

    # Find the first index in every row with a value above 90
    for i, k in enumerate(Ks):
        row = df[df["K"] == k]
        left_index = row[row["fp_flop_throughput"] >= threshold]["N"].min()
        if pd.notna(left_index):
            ax.axvline(
                x=(left_index - 4) / 4,
                ymin=(k - 4) / 64,
                ymax=k / 64,
                color='white',
                linewidth=1,
                alpha=1,
            )

    # Find the last index in every column with a value above 90
    for j, n in enumerate(Ns):
        col = df[df["N"] == n]
        bottom_index = col[col["fp_flop_throughput"] >= threshold]["K"].min()
        if pd.notna(bottom_index):
            ax.axhline(
                xmin=(n - 4) / 64,
                xmax=n / 64,
                y=(bottom_index - 4) / 4,
                color='white',
                linewidth=1,
                alpha=1,
            )


def generate_heatmaps(data: pd.DataFrame):
    data[["M", "K", "N", "bitwidth"]] = data["params"].str.extract(
        r"(\d+)x(\d+)x(\d+)xf(\d+)"
    )
    data[["M", "K", "N", "bitwidth"]] = data[["M", "K", "N", "bitwidth"]].astype(int)

    # filter out K values unrelated to the heatmap experimental runs
    data = data[(data["K"] <= 65)]

    # sns.set(rc={'text.usetex': True})

    for m_value, m_group in data.groupby("M"):
        selection = m_group[["K", "N", "fp_flop_throughput"]]
        pivot = (
            selection.pivot(index="K", columns="N", values="fp_flop_throughput")
            / 2
            * 100
        ).apply(np.floor)

        # find the min value to use in colorbar
        min_val = (pivot.agg('min').agg('min') // 10) * 10

        fig, ax = plt.subplots(figsize=(5, 4))
        sns.heatmap(
            pivot,
            ax=ax,
            annot=True,
            fmt=".0f",
            cmap="YlGnBu",
            vmin=min_val,
            vmax=100,
            annot_kws={"fontsize": 9},
            cbar_kws={
                "orientation": "horizontal",
                "aspect": 35,
                "shrink": 0.85,
                "pad": 0.07,
            },
        )
        # ax.set_title(
        #     "Matrix multiplication, $C_{{M \\times N}} = A_{{M \\times K}} B_{{K \\times N}}$ with $M={}$ @ f64".format(
        #         m_value
        #     )
        # )
        ax.tick_params(
            axis="both",
            which="major",
            labelbottom=True,
            bottom=False,
            top=False,
            labeltop=False,
            pad=0.0,
            length=4,
        )
        ax.invert_yaxis()  # make sure bottom-left corner is origin for both dimensions
        ax.set_xlabel("$N$")
        ax.set_ylabel("$K$", rotation=0)
        plt.yticks(rotation=0)
        ax.yaxis.set_label_coords(-0.05, 0.95, transform=None)
        ax.xaxis.set_label_coords(1, -0.05, transform=None)

        # Skip every second x-axis label
        for label in ax.xaxis.get_ticklabels()[1::2]:
            label.set_visible(False)

        cbar = ax.collections[0].colorbar
        cbar.set_label("% of FLOP/cycle Roofline", labelpad=2, fontsize=10)
        cbar.ax.tick_params(size=0)

        plt.tight_layout()
        highlight_1_8_cells(ax, selection)
        yield m_value, fig


def main():
    output_dir = SCRIPT_DIR / "output"
    output_dir.mkdir(exist_ok=True)

    parser = argparse.ArgumentParser(description="Generate heatmaps from CSV data.")
    parser.add_argument("csv_file", help="Path to the CSV file")
    args = parser.parse_args()

    csv_path = Path(args.csv_file)

    if not csv_path.is_absolute():
        csv_path = SCRIPT_DIR / csv_path

    data = pd.read_csv(csv_path)
    data = add_metrics(data)
    # FIXME we are able to generate snitch_stream matmul only at the moment
    data = data.loc[(data["test"] == "matmul") & (data["impl"] == "linalg_xdsl")]
    for m, fig in generate_heatmaps(data):
        if m == 1:
            fig.savefig(
                output_dir / f"figure9_matmul_heatmap_M_{m}.pdf",
                format="pdf",
                bbox_inches="tight",
            )


if __name__ == "__main__":
    main()
