
func.func public @ddot(%X: tensor<128xf64>,
                         %Y: tensor<128xf64>,
                         %Z: tensor<f64>) -> (tensor<f64>) {
    %res = linalg.dot ins(%X, %Y : tensor<128xf64>, tensor<128xf64>) outs(%Z : tensor<f64>) -> tensor<f64>
    return %res : tensor<f64>
}
