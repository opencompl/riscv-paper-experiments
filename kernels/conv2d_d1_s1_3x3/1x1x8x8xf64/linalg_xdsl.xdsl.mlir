module {
  func.func public @conv_2d_nchw_fchw_d1_s1_3x3(%arg0: memref<1x1x8x8xf64> {llvm.noalias}, %arg1: memref<1x1x3x3xf64> {llvm.noalias}, %arg2: memref<1x1x6x6xf64> {llvm.noalias}) -> memref<1x1x6x6xf64> {
    linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d4, d2 + d5, d3 + d6)>, affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d1, d4, d5, d6)>, affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction", "reduction"]} ins(%arg0, %arg1 : memref<1x1x8x8xf64>, memref<1x1x3x3xf64>) outs(%arg2 : memref<1x1x6x6xf64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.mulf %in, %in_0 : f64
      %1 = arith.addf %out, %0 : f64
      linalg.yield %1 : f64
    }
    return %arg2 : memref<1x1x6x6xf64>
  }
}
