#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2 * 2 + d4, d3 * 2 + d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>

func.func public @pooling_nchw_sum_d1_s2_3x3(%X: memref<1x1x16x16xf64>,
                       %Y: memref<1x1x7x7xf64>) -> () {
  // Named op fails to compile
  // %kernel = tensor.empty() : tensor<3x3xf32>
  // %res = linalg.pooling_nchw_sum {
  //   dilations = dense<1> : vector<2xi64>,
  //   strides = dense<2> : vector<2xi64>
  // } ins(%X, %kernel : tensor<1x1x16x16xf64>, tensor<3x3xf32>)
  //   outs(%Y : tensor<1x1x7x7xf64>) -> tensor<1x1x7x7xf64>

  %kernel = memref.alloc() : memref<3x3xf32>
  linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%X, %kernel : memref<1x1x16x16xf64>, memref<3x3xf32>) outs(%Y : memref<1x1x7x7xf64>) {
    ^bb0(%in: f64, %in_0: f32, %out: f64):
      %1 = arith.addf %out, %in : f64
      linalg.yield %1 : f64
    }
  return
}
