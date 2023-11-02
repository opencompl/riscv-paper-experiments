# Script that generated the mlir files in this folder

python test.py > iree.mlir
iree-compile --iree-input-type=torch --compile-to=input iree.mlir > linalg.mlir
