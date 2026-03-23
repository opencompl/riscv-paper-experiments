!#/bin/bash

# Generate an mlir file for a single test from the mlir template
snakemake --cores 1 kernels/exp_micro/16xf64/linalg.mlir

# Prints out the generated mlir file unchanged
xdsl-opt kernels/exp_micro/16xf64/linalg.mlir 

# Applies the expand-math-to-polynomials mlir-opt pass on the generated mlir file
xdsl-opt kernels/exp_micro/16xf64/linalg.mlir  -p expand-math-to-polynomials

# Run linalg version measurement on the generated mlir file
snakemake --cores 1 --forcerun kernels/exp_micro/16xf64/linalg_xdsl.profile.json