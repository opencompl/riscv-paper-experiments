func.func public @matmul(%X: tensor<16x16xf64> {"llvm.noalias"},
                         %Y: tensor<16x16xf64> {"llvm.noalias"},
                         %Z: tensor<16x16xf64> {"llvm.noalias"}) -> tensor<16x16xf64> {
  %zero = arith.constant 0.0 : f64
  %zeros = linalg.fill ins(%zero : f64) outs(%Z : tensor<16x16xf64>) -> tensor<16x16xf64>
  %res = linalg.matmul ins(%X, %Y : tensor<16x16xf64>, tensor<16x16xf64>) outs(%zeros : tensor<16x16xf64>) -> tensor<16x16xf64>
  func.return %res : tensor<16x16xf64>
}
