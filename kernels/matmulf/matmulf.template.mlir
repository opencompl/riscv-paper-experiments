func.func @matmulf_{M}_{N}_{K}(%A: memref<{M}x{K}xf32>,
                               %B: memref<{K}x{N}xf32>,
                               %C: memref<{M}x{N}xf32>) {
  linalg.matmul ins(%A, %B: memref<{M}x{K}xf32>, memref<{K}x{N}xf32>)
                outs(%C: memref<{M}x{N}xf32>)
  return
}