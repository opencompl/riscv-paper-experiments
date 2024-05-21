module {
  func.func public @relu(%arg0: memref<8x4xf64> {llvm.noalias}, %arg1: memref<8x4xf64> {llvm.noalias}) -> memref<8x4xf64> {
    %cst = arith.constant 0.000000e+00 : f64
    linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%arg0 : memref<8x4xf64>) outs(%arg1 : memref<8x4xf64>) {
    ^bb0(%in: f64, %out: f64):
      %0 = arith.maxf %in, %cst : f64
      linalg.yield %0 : f64
    }
    return %arg1 : memref<8x4xf64>
  }
}

