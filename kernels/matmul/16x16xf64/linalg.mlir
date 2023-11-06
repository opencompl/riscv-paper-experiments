func.func public @matmul(%X: memref<16x16xf64>,
                         %Y: memref<16x16xf64>,
                         %Z: memref<16x16xf64>) {
  linalg.matmul ins(%X, %Y : memref<16x16xf64>, memref<16x16xf64>) outs(%Z : memref<16x16xf64>) -> ()
  func.return
}
