#!/bin/bash

opt_lvl=-O3
out_dir=./out

clang=$(which clang) || clang="ERROR_NOT_FOUND"
cgeist=$(which cgeist) || cgeist="ERROR_NOT_FOUND"
mlir_opt=$(which mlir-opt) || mlir_opt="ERROR_NOT_FOUND"

if [ ! -d $out_dir ]; then
    mkdir -p $out_dir
fi

if [ "$clang" == "ERROR_NOT_FOUND" ] || \
   [ "$cgeist" == "ERROR_NOT_FOUND" ] || \
   [ "$mlir_opt" == "ERROR_NOT_FOUND" ]; then
    printf "Please make sure that you satistfy all the requirements!";
    exit 1;
fi

src=$1
fn=$2

src_name=$(basename ${src%.*})
if [ "$fn" == "" ]; then
$cgeist -resource-dir=$($clang -print-resource-dir)-I$($clang -print-resource-dir)/include \
    -S --memref-fullrank --c-style-memref --raise-scf-to-affine $opt_lvl  $src \
    | $mlir_opt --affine-simplify-structures --mlir-print-op-generic > $out_dir/$src_name\_affine.mlir

else
$cgeist -resource-dir=$($clang -print-resource-dir)-I$($clang -print-resource-dir)/include \
    -S --memref-fullrank --c-style-memref --raise-scf-to-affine --function=$fn $opt_lvl $src \
    | $mlir_opt --affine-simplify-structures --mlir-print-op-generic > $out_dir/$src_name\_affine.mlir
fi

$mlir_opt $out_dir/$src_name\_affine.mlir --eliminate-alloc-tensors \
    --empty-tensor-to-alloc-tensor \
    --convert-vector-to-scf --affine-scalrep --canonicalize \
    --cse -convert-linalg-to-loops \
    --simplify-extract-strided-metadata -lower-affine \
    --mlir-print-op-generic \
    > $out_dir/$src_name\_scf.mlir


# xDSL doesn't support the dlti dialect yet, which add attributes to the module
# so we remove it from the mlir files

module_end="}) : () -> ()"

sed -i '$ d' $out_dir/$src_name\_affine.mlir
sed -i '$ d' $out_dir/$src_name\_scf.mlir
sed -i '$ d' $out_dir/$src_name\_affine.mlir
sed -i '$ d' $out_dir/$src_name\_scf.mlir

echo $module_end >> $out_dir/$src_name\_affine.mlir
echo $module_end >> $out_dir/$src_name\_scf.mlir
