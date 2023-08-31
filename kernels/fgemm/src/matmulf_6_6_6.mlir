func.func @matmulf_6_6_6(%A: memref<6x6xf32>,
                               %B: memref<6x6xf32>,
                               %C: memref<6x6xf32>) {
  linalg.matmul ins(%A, %B: memref<6x6xf32>, memref<6x6xf32>)
                outs(%C: memref<6x6xf32>)
  return
}
