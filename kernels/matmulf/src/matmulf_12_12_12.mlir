func.func @matmulf_12_12_12(%A: memref<12x12xf32>,
                               %B: memref<12x12xf32>,
                               %C: memref<12x12xf32>) {
  linalg.matmul ins(%A, %B: memref<12x12xf32>, memref<12x12xf32>)
                outs(%C: memref<12x12xf32>)
  return
}
