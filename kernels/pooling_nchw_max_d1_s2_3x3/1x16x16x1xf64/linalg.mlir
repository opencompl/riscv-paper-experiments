
func.func public @pooling_nchw_max_d1_s2_3x3(%X: tensor<1x1x16x16xf64>,
                       %Y: tensor<1x1x7x7xf64>) -> () {
  %kernel = tensor.empty() : tensor<3x3xf32>
  %res = linalg.pooling_nchw_max {
    dilations = dense<1> : vector<2xi64>,
    strides = dense<2> : vector<2xi64>
  } ins(%X, %kernel : tensor<1x1x16x16xf64>, tensor<3x3xf32>)
    outs(%Y : tensor<1x1x7x7xf64>) -> tensor<1x1x7x7xf64>
  return
}
