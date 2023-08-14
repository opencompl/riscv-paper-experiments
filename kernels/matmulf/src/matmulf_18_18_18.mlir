func.func @matmulf_18_18_18(%A: memref<18x18xf32>,
                               %B: memref<18x18xf32>,
                               %C: memref<18x18xf32>) {
  linalg.matmul ins(%A, %B: memref<18x18xf32>, memref<18x18xf32>)
                outs(%C: memref<18x18xf32>)
  return
}
