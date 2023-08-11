#!/bin/bash

for file in ../../raw/gemm/*.mxm
do
    echo "[libxsmm objdump] dumping $file"
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    objdump -D -b binary -m i386 -M x86-64 $file > $filename.dump
done

