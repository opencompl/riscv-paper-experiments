#map = affine_map<(m, n) -> (m, n)>

#add_attributes = {
  indexing_maps = [#map, #map],
  iterator_types = ["parallel", "parallel"]
}

#relu_attributes = {
  indexing_maps = [#map],
  iterator_types = ["parallel", "parallel"]
}
func.func public @dense(%X: memref<8x8xf64>,
                        %W: memref<8x8xf64>,
                        %B: memref<8x8xf64>,
                        %Y: memref<8x8xf64>) {
  linalg.matmul ins(%X, %W : memref<8x8xf64>, memref<8x8xf64>) outs(%Y : memref<8x8xf64>) -> ()
  linalg.generic #add_attributes
  ins(%B: memref<8x8xf64>)
  outs(%Y: memref<8x8xf64>) {
  ^bb0(%b: f64, %y: f64):
    %r0 = arith.addf %b, %y : f64
    linalg.yield %r0 : f64
  }
  %c0 = arith.constant 0.0 : f64
  linalg.generic #relu_attributes outs(%Y: memref<8x8xf64>) {
  ^bb0(%y: f64):
    %r0 = arith.maxf %y, %c0 : f64
    linalg.yield %r0 : f64
  }
  func.return
}
