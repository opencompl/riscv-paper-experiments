#!/usr/bin/env python3

import matplotlib.pyplot as plt
import numpy as np
import argparse
import pandas as pd


def generate_stacked_bars(labels, passes, values):

    n_bars = values.shape[0]
    n_values = values.shape[1]

    cmap = plt.get_cmap("viridis", n_values)
    colors = [cmap(i) for i in range(n_values)]

    # Create the stacked bar plot
    fig, ax = plt.subplots(figsize=(10, 6))

    bar_width = 0.1
    bar_tick = 0.15
    x = np.array([bar_tick * v for v in range(n_bars)])
    bottom = np.zeros(n_bars)

    for i in range(n_values):
        segments = ax.bar(
            x,
            values[:, i],
            bottom=bottom,
            width=bar_width,
            color=colors[i],
            label=passes[i],
        )
        bottom += values[:, i]

        # Add segment values inside each segment
        if i == 0 or i == n_values - 1:
            continue
        for bar in segments:
            height = bar.get_height()
            # Calculate vertical position for the text within each segment
            text_y = bar.get_y() + height / 2.0
            ax.text(
                bar.get_x() + bar.get_width() / 2,
                text_y,
                f"{height:.2f}",
                ha="center",
                va="center",
                color="white",
                fontsize=10,
                fontweight="bold",
            )

    # Add much thicker white zigzag line with 3 less sloped segments across the full width of each bar
    zigzag_height = (
        values[:, -1] * 0.1
    )  # Reduced to 30% of the top segment height for less slope

    for i in range(n_bars):
        bar_top = np.sum(values[i])
        zigzag_center = bar_top - values[i, -1] / 2  # Center of the top segment
        zigzag_top = zigzag_center + zigzag_height[i] / 2
        zigzag_bottom = zigzag_center - zigzag_height[i] / 2

        # Create 4 points for 3 straight segments with less slope
        zigzag_x = [
            x[i] - bar_width / 2,
            x[i] - bar_width / 4,
            x[i] + bar_width / 4,
            x[i] + bar_width / 2,
        ]
        zigzag_y = [zigzag_bottom, zigzag_top, zigzag_bottom, zigzag_top]

        ax.plot(
            zigzag_x, zigzag_y, color="white", linewidth=16, solid_capstyle="round"
        )  # Doubled linewidth to 16

    ax.axhline(y=100, color="black", linewidth=2, zorder=3)

    ax.set_xlim(-0.1, n_bars * bar_tick)

    # Add labels to the right of the last bar
    fontdict = {"family": "Arial", "size": 12, "weight": "bold"}
    for i in range(1, n_values - 1):
        y_position = sum(values[0, :i]) + values[0, i] / 2
        ax.text(
            x[-1] + bar_width / 2 + 0.01,
            y_position,
            passes[i],
            va="center",
            color=colors[i],
            fontdict=fontdict,
        )

    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    ax.get_yaxis().set_visible(False)
    for key, spine in ax.spines.items():
        spine.set_visible(False)

    plt.tight_layout()
    return fig


def main():
    parser = argparse.ArgumentParser(
        description="Generate pass improvements stacked bars plot from pass improvements CSV table."
    )
    parser.add_argument("csv_file", help="Path to the input pass improvements CSV file")
    args = parser.parse_args()
    df = pd.read_csv(args.csv_file)
    df["label"] = df["test"] + " " + df["params"]
    df.set_index("label", inplace=True)
    df.drop(["test", "params"], axis=1, inplace=True)
    df *= 100.0
    print(df)
    column_to_pass = {
        "linalg_0_xdsl": "baseline",
        "linalg_1_xdsl": "memref-stream-tile-outer-loops",
        "linalg_2_xdsl": "memref-stream-unnest-out-parameters",
        "linalg_3_xdsl": "memref-stream-interleave",
        "linalg_4_xdsl": "memref-streamify",
        "linalg_full_xdsl": "convert-riscv-scf-for-to-frep",
    }
    passes = [column_to_pass[column] for column in df.columns]
    df["remainder"] = 40.0
    passes.append("remainder")
    fig = generate_stacked_bars(df.index, passes=passes, values=df.values)
    fig.savefig(f"pass_improvements.pdf", format="pdf", bbox_inches="tight")


if __name__ == "__main__":
    main()
