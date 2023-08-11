# for every file in the target directory objdump it in the same file


for file in ../../raw/gemm/*.mxm
do
    echo "objdumping $file"
    filename=$(basename -- "$file")
    extension="${filename##*.}"
    filename="${filename%.*}"

    objdump -D -b binary -m i386 -M x86-64 $file > $filename.dump
done

