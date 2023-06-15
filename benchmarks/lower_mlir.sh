#!/bin/bash

polybench_utils_folder=./polybench-c-4.2.1-beta/utilities
# Options for the polybench suite:
# MINI_DATASET -> 32x32 matrices
# DATA_TYPE_IS_FLOAT -> use float everywhere since we don't support doubles on xdsl yet
# POLYBENCH_DUMP_ARRAYS -> outputs the returning arrays of the benchmark into stderr.
poly_bench_flags="-DMINI_DATASET -DDATA_TYPE_IS_FLOAT -DPOLYBENCH_DUMP_ARRAYS"
opt_lvl=-O3
out_dir=./out

clang="$(which clang) || clang="ERROR_NOT_FOUND""
cgeist=$(which cgeist) || cgeist="ERROR_NOT_FOUND"
mlir_opt=$(which mlir-opt) || mlir_opt="ERROR_NOT_FOUND"

if [ ! -d $out_dir ]; then
    mkdir -p $out_dir
fi
rm -rf $out_dir/*

src=$1
src_name=$(basename ${src%.*})
$cgeist -resource-dir=$($clang -print-resource-dir) -I $polybench_utils_folder -I$($clang -print-resource-dir)/include \
    -S --memref-fullrank -O3 $poly_bench_flags $src >$out_dir/$src_name\_affine.mlir

$mlir_opt $out_dir/$src_name\_affine.mlir --eliminate-alloc-tensors \
    --empty-tensor-to-alloc-tensor --buffer-loop-hoisting \
    --convert-vector-to-scf --affine-scalrep --canonicalize \
    --cse -convert-linalg-to-loops -convert-scf-to-cf \
    --simplify-extract-strided-metadata -lower-affine \
    -convert-scf-to-cf --mlir-print-op-generic \
    > $out_dir/$src_name\_base.mlir
