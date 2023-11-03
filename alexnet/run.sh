# Script that generated the mlir files in this folder

python test.py > iree.mlir
iree-compile --iree-input-type=torch --compile-to=input iree.mlir > input.mlir
iree-compile --iree-input-type=torch --compile-to=flow --iree-util-zero-fill-elided-attrs iree.mlir > flow.mlir
