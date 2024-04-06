func.func public @matmul(%X: memref<8x8xf64>,
                         %Y: memref<8x8xf64>,
                         %Z: memref<8x8xf64>) {
  "linalg.generic"(%X, %Y, %Z) ({
  ^bb0(%x: f64, %y: f64, %z: f64):
    %r0 = arith.mulf %x, %y : f64
    %r1 = arith.addf %z, %r0 : f64
    "linalg.yield"(%r1) : (f64) -> ()
  }) {indexing_maps = [affine_map<(m, n, k) -> (m, k)>, affine_map<(m, n, k) -> (k, n)>, affine_map<(m, n, k) -> (m, n)>], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>} : (memref<8x8xf64>, memref<8x8xf64>, memref<8x8xf64>) -> ()
  func.return
}
