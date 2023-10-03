#kernel_attributes = {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}

func.func public @ssum(%X: memref<8x16xf64>,
                       %Y: memref<8x16xf64>,
                       %Z: memref<8x16xf64>) -> () {
  linalg.generic #kernel_attributes
  ins(%X, %Y: memref<8x16xf64>, memref<8x16xf64>)
  outs(%Z: memref<8x16xf64>) {
  ^bb0(%x: f64, %y: f64, %z: f64):
    %r0 = arith.addf %x, %y : f64
    linalg.yield %r0 : f64
  }
  return
}
