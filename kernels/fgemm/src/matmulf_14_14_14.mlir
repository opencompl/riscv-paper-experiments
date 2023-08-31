func.func @matmulf_14_14_14(%A: memref<14x14xf32>,
                               %B: memref<14x14xf32>,
                               %C: memref<14x14xf32>) {
  linalg.matmul ins(%A, %B: memref<14x14xf32>, memref<14x14xf32>)
                outs(%C: memref<14x14xf32>)
  return
}
