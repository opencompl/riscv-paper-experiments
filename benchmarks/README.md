# MLIR Benchmarks

## Requirements 

To lower down the set of C benchmarks given here to MLIR, you'll need the [Polygeist](https://github.com/llvm/Polygeist) tool 
which acts as frontend for C/C++ code.

## Usage

Run `./simple_lower_mlir.sh [file] [target_function]?` to get the output MLIR in `out`.

## Suite of Benchmarks

- Polybench (30 kernels with stencils, ...) [Out of scope currently]
- Handwritten kernels (currently gemm implementations with different loop transformations)

## Scope

Feel free to drop any relevant benchmarks.