func.func @matmulf_2_2_2(%A: memref<2x2xf32>,
                               %B: memref<2x2xf32>,
                               %C: memref<2x2xf32>) {
  linalg.matmul ins(%A, %B: memref<2x2xf32>, memref<2x2xf32>)
                outs(%C: memref<2x2xf32>)
  return
}
