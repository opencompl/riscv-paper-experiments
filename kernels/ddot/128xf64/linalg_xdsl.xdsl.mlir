module {
  func.func public @ddot(%arg0: memref<128xf64> {llvm.noalias}, %arg1: memref<128xf64> {llvm.noalias}, %arg2: memref<f64> {llvm.noalias}) -> memref<f64> {
    linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> ()>], iterator_types = ["reduction"]} ins(%arg0, %arg1 : memref<128xf64>, memref<128xf64>) outs(%arg2 : memref<f64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.mulf %in, %in_0 : f64
      %1 = arith.addf %out, %0 : f64
      linalg.yield %1 : f64
    }
    return %arg2 : memref<f64>
  }
}
