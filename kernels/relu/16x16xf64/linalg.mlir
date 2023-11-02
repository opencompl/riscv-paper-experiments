#kernel_attributes = {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}

func.func public @relu(%X: memref<16x16xf64>,
                       %Y: memref<16x16xf64>) -> () {
  %c0 = arith.constant 0.0 : f64
  linalg.generic #kernel_attributes
  ins(%X: memref<16x16xf64>)
  outs(%Y: memref<16x16xf64>) {
  ^bb0(%x: f64, %y: f64):
    %r0 = arith.maxf %x, %c0 : f64
    linalg.yield %r0 : f64
  }
  return
}
