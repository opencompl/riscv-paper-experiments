#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2 * 2 + d4, d3 * 2 + d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>

func.func public @pooling_nchw_sum_d1_s2_3x3(%X: tensor<1x1x16x16xf64>,
                       %Y: tensor<1x1x7x7xf64>) -> tensor<1x1x7x7xf64> {
  %kernel = tensor.empty() : tensor<3x3xf32>
  %res = linalg.pooling_nchw_sum {
    dilations = dense<1> : vector<2xi64>,
    strides = dense<2> : vector<2xi64>
  } ins(%X, %kernel : tensor<1x1x16x16xf64>, tensor<3x3xf32>)
    outs(%Y : tensor<1x1x7x7xf64>) -> tensor<1x1x7x7xf64>
  return %res : tensor<1x1x7x7xf64>
}
