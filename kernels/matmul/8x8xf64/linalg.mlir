
func.func public @matmul(%X: tensor<8x8xf64> {"llvm.noalias"},
                         %Y: tensor<8x8xf64> {"llvm.noalias"},
                         %Z: tensor<8x8xf64> {"llvm.noalias"}) -> (tensor<8x8xf64>) {
    %zero = arith.constant 0.0 : f64
    %zeros = linalg.fill ins(%zero : f64) outs(%Z : tensor<8x8xf64>) -> tensor<8x8xf64>
    %res = linalg.matmul ins(%X, %Y : tensor<8x8xf64>, tensor<8x8xf64>) outs(%zeros : tensor<8x8xf64>) -> tensor<8x8xf64>
    return %res : tensor<8x8xf64>
}
