#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map4 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2 * 2 + d4, d3 * 2 + d5)>
#map5 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d4, d5)>
#map6 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3)>
module {
  func.func public @dsum(%arg0: memref<8x16xf64>, %arg1: memref<8x16xf64>, %arg2: memref<8x16xf64>) {
    linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : memref<8x16xf64>, memref<8x16xf64>) outs(%arg2 : memref<8x16xf64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.addf %in, %in_0 : f64
      linalg.yield %0 : f64
    }
    return
  }
  func.func public @matmul(%arg0: memref<8x8xf64>, %arg1: memref<8x8xf64>, %arg2: memref<8x8xf64>) {
    linalg.generic {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0, %arg1 : memref<8x8xf64>, memref<8x8xf64>) outs(%arg2 : memref<8x8xf64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.mulf %in, %in_0 : f64
      %1 = arith.addf %out, %0 : f64
      linalg.yield %1 : f64
    }
    return
  }
  func.func public @relu(%arg0: memref<16x16xf64>, %arg1: memref<16x16xf64>) {
    %cst = arith.constant 0.000000e+00 : f64
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<16x16xf64>) outs(%arg1 : memref<16x16xf64>) {
    ^bb0(%in: f64, %out: f64):
      %0 = arith.maxf %in, %cst : f64
      linalg.yield %0 : f64
    }
    return
  }
  func.func public @conv_2d_nchw_fchw_d1_s1_3x3(%arg0: memref<1x1x8x8xf64>, %arg1: memref<1x1x3x3xf64>, %arg2: memref<1x1x6x6xf64>) {
    linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %arg1 : memref<1x1x8x8xf64>, memref<1x1x3x3xf64>) outs(%arg2 : memref<1x1x6x6xf64>)
    return
  }
  func.func public @pooling_nchw_max_d1_s2_3x3(%arg0: memref<1x1x16x16xf64>, %arg1: memref<1x1x7x7xf64>) {
    %alloc = memref.alloc() : memref<3x3xf32>
    linalg.generic {indexing_maps = [#map4, #map5, #map6], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction"]} ins(%arg0, %alloc : memref<1x1x16x16xf64>, memref<3x3xf32>) outs(%arg1 : memref<1x1x7x7xf64>) {
    ^bb0(%in: f64, %in_0: f32, %out: f64):
      %0 = arith.maxf %out, %in : f64
      linalg.yield %0 : f64
    }
    return
  }
}

