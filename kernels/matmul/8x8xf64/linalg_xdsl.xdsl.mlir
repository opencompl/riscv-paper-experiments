module {
  func.func public @matmul(%arg0: memref<8x8xf64> {llvm.noalias}, %arg1: memref<8x8xf64> {llvm.noalias}, %arg2: memref<8x8xf64> {llvm.noalias}) -> memref<8x8xf64> {
    linalg.generic {indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d2)>, affine_map<(d0, d1, d2) -> (d2, d1)>, affine_map<(d0, d1, d2) -> (d0, d1)>], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0, %arg1 : memref<8x8xf64>, memref<8x8xf64>) outs(%arg2 : memref<8x8xf64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.mulf %in, %in_0 : f64
      %1 = arith.addf %out, %0 : f64
      linalg.yield %1 : f64
    }
    return %arg2 : memref<8x8xf64>
  }
}
