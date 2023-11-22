
func.func public @matmul(%X: tensor<8x8xf64>,
                         %Y: tensor<8x8xf64>,
                         %Z: tensor<8x8xf64>) -> (tensor<8x8xf64>) {
    %res = linalg.matmul ins(%X, %Y : tensor<8x8xf64>, tensor<8x8xf64>) outs(%Z : tensor<8x8xf64>) -> tensor<8x8xf64>
    return %res : tensor<8x8xf64>
}
