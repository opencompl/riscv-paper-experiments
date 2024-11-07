#!/usr/bin/env python3
from data import (
    get_low_level_representation,
    get_opt_pipeline,
    get_pivoted_all,
    get_pivoted_fpu,
    get_kernels,
)
from fpu import get_fpu, plot_fpu
from low_level_representation import get_llr_dfs, plot_llr
from max_util import get_max_util
from regalloc import get_regalloc, print_regalloc
from plot_utils import savefig
from opt_pipeline import get_opt_pipeline_table

from pathlib import Path

import os

SCRIPT_DIR = Path(os.path.dirname(os.path.abspath(__file__)))
RESULTS_DIR = SCRIPT_DIR / "results"


def main():
    output_dir = SCRIPT_DIR / "output"
    output_dir.mkdir(exist_ok=True)

    kernels_df = get_kernels(RESULTS_DIR)
    pivoted_all_df = get_pivoted_all(kernels_df)
    pivoted_fpu_df = get_pivoted_fpu(pivoted_all_df)

    # Plot FPU utilization
    fpu_dfs = get_fpu(pivoted_fpu_df)
    fpu_fig = plot_fpu(fpu_dfs)
    savefig(fpu_fig, output_dir / "fpu.pdf")

    # Print the regalloc stats
    regalloc_df = get_regalloc(RESULTS_DIR)
    print_regalloc(regalloc_df, filename=output_dir / "regalloc.csv")

    # Plot low-level representation
    llr_kernels_df = get_low_level_representation(RESULTS_DIR)
    llr_dfs = get_llr_dfs(llr_kernels_df)
    llr_fig = plot_llr(llr_dfs)
    savefig(llr_fig, output_dir / "low_level_representation.pdf")

    # Print opt pipeline table
    opt_pipeline_df = get_opt_pipeline(RESULTS_DIR)
    opt_pipeline_table = get_opt_pipeline_table(opt_pipeline_df)
    with open(output_dir / "opt_pipeline.csv", "w") as f:
        f.write(opt_pipeline_table)

    # Print max utilization stats
    max_util_macros = get_max_util(llr_kernels_df, fpu_dfs)
    with open(output_dir / "max_util.csv", "w") as f:
        f.write(max_util_macros)


if __name__ == "__main__":
    main()
