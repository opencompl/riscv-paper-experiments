
func.func public @ddot(%X: tensor<128xf64> {"llvm.noalias"},
                       %Y: tensor<128xf64> {"llvm.noalias"},
                       %Z: tensor<f64> {"llvm.noalias"}) -> (tensor<f64>) {
    %res = linalg.dot ins(%X, %Y : tensor<128xf64>, tensor<128xf64>) outs(%Z : tensor<f64>) -> tensor<f64>
    return %res : tensor<f64>
}
