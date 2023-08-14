func.func @matmulf_10_10_10(%A: memref<10x10xf32>,
                               %B: memref<10x10xf32>,
                               %C: memref<10x10xf32>) {
  linalg.matmul ins(%A, %B: memref<10x10xf32>, memref<10x10xf32>)
                outs(%C: memref<10x10xf32>)
  return
}
