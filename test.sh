!#/bin/bash


#### f64 version ###

# Generate an mlir file for a single test from the mlir template
snakemake --cores 1 kernels/exp_micro/16xf64/linalg.mlir

# Prints out the generated mlir file unchanged
xdsl-opt kernels/exp_micro/16xf64/linalg.mlir 

# Applies the expand-math-to-polynomials mlir-opt pass on the generated mlir file
xdsl-opt kernels/exp_micro/16xf64/linalg.mlir  -p expand-math-to-polynomials

# Run linalg version measurement on the generated mlir file
snakemake --cores 1 --forcerun kernels/exp_micro/16xf64/linalg_xdsl.profile.json


### f32 version ###

snakemake --cores 1 kernels/exp_micro/16xf32/linalg.mlir

xdsl-opt kernels/exp_micro/16xf32/linalg.mlir

xdsl-opt kernels/exp_micro/16xf32/linalg.mlir  -p expand-math-to-polynomials

snakemake --cores 1 --forcerun kernels/exp_micro/16xf32/linalg_xdsl.profile.json



### Step by step execution for f32 ###

# Generate params file
snakemake --cores 1 kernels/exp_micro/16xf32/params.json

# generate xdsl-ready mlir file
snakemake --cores 1 kernels/exp_micro/16xf32/linalg_xdsl.xdsl.mlir

# assembly
snakemake --cores 1 --forceall kernels/exp_micro/16xf32/linalg_xdsl.S

# object file



# testing the chebyshev expansion:
# 1. generate the xdsl mlir file, 2. lower to snitch using the xdsl passes
snakemake --cores 1 kernels/exp_micro/16xf32/linalg_xdsl_c8.xdsl.mlir
xdsl-opt -p test-lower-linalg-to-snitch kernels/exp_micro/16xf32/linalg_xdsl_c8.xdsl.mlir
