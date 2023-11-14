func.func public @dsum(%X: memref<8x16xf64>,
                       %Y: memref<8x16xf64>,
                       %Z: memref<8x16xf64>) -> () {
  linalg.generic {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}
  ins(%X, %Y: memref<8x16xf64>, memref<8x16xf64>)
  outs(%Z: memref<8x16xf64>) {
  ^bb0(%x: f64, %y: f64, %z: f64):
    %r0 = arith.addf %x, %y : f64
    linalg.yield %r0 : f64
  }
  return
}

func.func public @matmul(%X: memref<8x8xf64>,
                         %Y: memref<8x8xf64>,
                         %Z: memref<8x8xf64>) {
    linalg.generic {indexing_maps = [affine_map<(m, n, k) -> (m, k)>, affine_map<(m, n, k) -> (k, n)>, affine_map<(m, n, k) -> (m,
  n)>], iterator_types = ["parallel", "parallel", "reduction"]} ins(%X, %Y : memref<8x8xf64>, memref<8x8xf64>) outs(%Z : memref<8x8xf64>) {
    ^bb0(%x: f64, %y: f64, %acc_0: f64):
      %prod = arith.mulf %x, %y : f64
      %acc_1 = arith.addf %acc_0, %prod : f64
      linalg.yield %acc_1 : f64
    }
  func.return
}

func.func public @relu(%X: memref<16x16xf64>,
                       %Y: memref<16x16xf64>) -> () {
  %c0 = arith.constant 0.0 : f64
  linalg.generic {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}
  ins(%X: memref<16x16xf64>)
  outs(%Y: memref<16x16xf64>) {
  ^bb0(%x: f64, %y: f64):
    %r0 = arith.maxf %x, %c0 : f64
    linalg.yield %r0 : f64
  }
  return
}

func.func public @conv_2d_nchw_fchw_d1_s1_3x3(
  %X: memref<1x1x8x8xf64>,
  %Y: memref<1x1x3x3xf64>,
  %Z: memref<1x1x6x6xf64>) -> () {
  linalg.conv_2d_nchw_fchw {
    dilations = dense<1> : vector<2xi64>,
    strides = dense<1> : vector<2xi64>
  } ins(%X, %Y : memref<1x1x8x8xf64>, memref<1x1x3x3xf64>)
    outs(%Z : memref<1x1x6x6xf64>) -> ()
  return
}

#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2 * 2 + d4, d3 * 2 + d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>

func.func public @pooling_nchw_max_d1_s2_3x3(%X: memref<1x1x16x16xf64>,
                       %Y: memref<1x1x7x7xf64>) -> () {
  // Named op fails to compile
  // %kernel = tensor.empty() : tensor<3x3xf32>
  // %res = linalg.pooling_nchw_max {
  //   dilations = dense<1> : vector<2xi64>,
  //   strides = dense<2> : vector<2xi64>
  // } ins(%X, %kernel : tensor<1x1x16x16xf64>, tensor<3x3xf32>)
  //   outs(%Y : tensor<1x1x7x7xf64>) -> tensor<1x1x7x7xf64>

  %kernel = memref.alloc() : memref<3x3xf32>
  linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%X, %kernel : memref<1x1x16x16xf64>, memref<3x3xf32>) outs(%Y : memref<1x1x7x7xf64>) {
    ^bb0(%in: f64, %in_0: f32, %out: f64):
      %1 = arith.maxf %out, %in : f64
      linalg.yield %1 : f64
    }
  return
}
