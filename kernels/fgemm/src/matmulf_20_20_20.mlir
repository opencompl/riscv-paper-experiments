func.func @matmulf_20_20_20(%A: memref<20x20xf32>,
                               %B: memref<20x20xf32>,
                               %C: memref<20x20xf32>) {
  linalg.matmul ins(%A, %B: memref<20x20xf32>, memref<20x20xf32>)
                outs(%C: memref<20x20xf32>)
  return
}
