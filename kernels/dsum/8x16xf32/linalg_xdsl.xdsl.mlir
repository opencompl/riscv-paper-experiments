func.func public @ssum(%X: memref<8x16xf64>,
                       %Y: memref<8x16xf64>,
                       %Z: memref<8x16xf64>) -> () {
  "linalg.generic"(%X, %Y, %Z) <{
    "indexing_maps" = [
      affine_map<(d0, d1) -> (d0, d1)>,
      affine_map<(d0, d1) -> (d0, d1)>,
      affine_map<(d0, d1) -> (d0, d1)>
    ], "iterator_types" = [
      #linalg.iterator_type<parallel>,
      #linalg.iterator_type<parallel>,
      #linalg.iterator_type<parallel>
    ],
    "operandSegmentSizes" = array<i32: 2, 1>
  }> ({
    ^bb0(%x : f64, %y : f64, %z : f64):
      %r0 = arith.addf %x, %y : f64
      "linalg.yield"(%r0) : (f64) -> ()
    }) : (memref<8x16xf64>, memref<8x16xf64>, memref<8x16xf64>) -> ()
  func.return
}
