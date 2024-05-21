module {
  func.func public @dsum(%arg0: memref<8x4xf64> {llvm.noalias}, %arg1: memref<8x4xf64> {llvm.noalias}, %arg2: memref<8x4xf64> {llvm.noalias}) -> memref<8x4xf64> {
    linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : memref<8x4xf64>, memref<8x4xf64>) outs(%arg2 : memref<8x4xf64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.addf %in, %in_0 : f64
      linalg.yield %0 : f64
    }
    return %arg2 : memref<8x4xf64>
  }
}

