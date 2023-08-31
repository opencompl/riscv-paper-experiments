func.func @matmulf_4_4_4(%A: memref<4x4xf32>,
                               %B: memref<4x4xf32>,
                               %C: memref<4x4xf32>) {
  linalg.matmul ins(%A, %B: memref<4x4xf32>, memref<4x4xf32>)
                outs(%C: memref<4x4xf32>)
  return
}
