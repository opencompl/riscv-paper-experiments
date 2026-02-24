#!/usr/bin/env python3
"""
Plot exp vs relu comparison from kernels.exp.csv.

Usage:
    python plot_exp.py [--input results/kernels.exp.csv] [--output output/exp_plots.pdf]
"""

import argparse
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from data import EXP_FLOPS_F32, EXP_FLOPS_F64


def load_and_prepare(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)

    # Extract total number of elements and precision
    # exp params: "64xf32" -> N=64
    # relu params: "1x64xf32" -> M=1, N=64, total=64
    def get_total_elements(row):
        parts = row["params"].split("x")
        # Last part is like "f32" or "f64"
        dims = [int(p) for p in parts[:-1]]
        return int(np.prod(dims))

    def get_precision(row):
        parts = row["params"].split("x")
        return parts[-1]  # "f32" or "f64"

    df["total_elements"] = df.apply(get_total_elements, axis=1)
    df["precision"] = df.apply(get_precision, axis=1)
    df["bitwidth"] = df["precision"].str.extract(r"f(\d+)").astype(int)

    # Compute FLOPs and throughput
    def get_flops(row):
        if row["test"] == "exp":
            flops_per_elem = EXP_FLOPS_F32 if row["bitwidth"] == 32 else EXP_FLOPS_F64
        else:
            # relu, fill, sum: 1 FP op per element
            flops_per_elem = 1
        return flops_per_elem * row["total_elements"]

    df["flops"] = df.apply(get_flops, axis=1)
    df["throughput"] = df["flops"] / df["cycles"]
    df["max_throughput"] = 64 // df["bitwidth"]  # peak FP ops/cycle (no FMA)

    df = df.sort_values("total_elements")
    return df


def plot_comparison(df: pd.DataFrame, output_path: str):
    precisions = sorted(df["precision"].unique())
    kernels = sorted(df["test"].unique())

    fig, axes = plt.subplots(len(precisions), 3, figsize=(15, 4 * len(precisions)))
    if len(precisions) == 1:
        axes = [axes]

    for row_idx, prec in enumerate(precisions):
        ax_cycles = axes[row_idx][0]
        ax_fpu = axes[row_idx][1]
        ax_throughput = axes[row_idx][2]

        for kernel in kernels:
            subset = df[(df["test"] == kernel) & (df["precision"] == prec)]
            if subset.empty:
                continue

            ax_cycles.plot(
                subset["total_elements"], subset["cycles"],
                marker="o", label=kernel,
            )
            ax_fpu.plot(
                subset["total_elements"], subset["fpss_fpu_occupancy"],
                marker="o", label=kernel,
            )
            ax_throughput.plot(
                subset["total_elements"], subset["throughput"],
                marker="o", label=kernel,
            )

        # Add roofline to throughput plot
        bitwidth = int(prec[1:])
        max_tp = 64 // bitwidth
        ax_throughput.axhline(
            y=max_tp, color="gray", linestyle="--", label="Roofline",
        )

        ax_cycles.set_xlabel("Total Elements")
        ax_cycles.set_ylabel("Cycles")
        ax_cycles.set_title(f"Cycles ({prec})")
        ax_cycles.legend()

        ax_fpu.set_xlabel("Total Elements")
        ax_fpu.set_ylabel("FPU Occupancy")
        ax_fpu.set_title(f"FPU Occupancy ({prec})")
        ax_fpu.legend()

        ax_throughput.set_xlabel("Total Elements")
        ax_throughput.set_ylabel("Throughput (FLOPs/cycle)")
        ax_throughput.set_title(f"Throughput ({prec})")
        ax_throughput.legend()

    plt.tight_layout()
    plt.savefig(output_path)
    print(f"Saved plot to {output_path}")


def main():
    parser = argparse.ArgumentParser(description="Plot exp vs relu comparison")
    parser.add_argument(
        "--input", "-i",
        default="results/kernels.exp.csv",
        help="Input CSV file",
    )
    parser.add_argument(
        "--output", "-o",
        default="output/exp_plots.pdf",
        help="Output plot file",
    )
    args = parser.parse_args()

    Path(args.output).parent.mkdir(exist_ok=True)

    df = load_and_prepare(args.input)
    plot_comparison(df, args.output)


if __name__ == "__main__":
    main()
