#!/usr/bin/env python3

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import argparse
import numpy as np

LABELS = {
    "conv2d_d1_s1_3x3": "2D Convolution",
    "ddot": "Inner Product",
    "dense": "Dense ReLU Layer",
    "dsum": "Vector\nElement-wise Add",
    "matmul": "Matrix Multiplication",
    "pooling_nchw_max_d1_s2_3x3": "Max Pooling Layer",
    "pooling_nchw_sum_d1_s2_3x3": "Sum Pooling Layer",
}

def add_metrics(data: pd.DataFrame) -> pd.DataFrame:
    if "fp_inst_throughput" not in data:
        data["fp_inst_throughput"] = data["fpss_fpu_issues"] / data["cycles"]
    if "fp_flop_throughput" not in data:
        data["fp_flop_throughput"] = (
            data["fpss_fpu_issues"] + data["fpss_fpu_fmadd_issues"]
        ) / data["cycles"]
    return data

def generate_throughput(data):
    df = data[data["impl"].isin(["snitch_stream", "linalg_xdsl"])]
    # If multiple rows (experiments) are present for a single 'test',
    # just pick the best one:
    df = df.loc[df.groupby("test")["fp_flop_throughput"].idxmax()]
    # Use meaningful labels:
    df["test"] = df["test"].map(LABELS)
    fig, ax = plt.subplots(figsize=(8, 9))
    sns.histplot(
        ax=ax,
        data=df,
        x="test",
        weights="fp_flop_throughput",
        legend=False,
        edgecolor=None,
        shrink=0.9,
    )
    plt.axhline(y=2, color="grey", linestyle="--", linewidth=1)
    plt.axhline(y=1, color="grey", linestyle="--", linewidth=0.5)
    plt.xticks(rotation=45, fontsize=8)
    ax.set_title("Kernels FP sustained throughput @ f64")
    ax.set_xlabel("")
    ax.set_ylabel("FLOP/cycle")
    ax.set_yticks(np.arange(0, 2.1, 0.1))
    return fig


def main():
    parser = argparse.ArgumentParser(
        description="Generate kernels FP throughput from CSV data."
    )
    parser.add_argument("csv_file", help="Path to the CSV file")
    args = parser.parse_args()
    data = pd.read_csv(args.csv_file)
    data = add_metrics(data)
    fig = generate_throughput(data)
    fig.savefig(f"fp_throughput.pdf", format="pdf")


if __name__ == "__main__":
    main()
