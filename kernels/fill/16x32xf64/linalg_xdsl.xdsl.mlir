module {
  func.func public @fill(%arg0: f64, %arg1: memref<16x32xf64> {llvm.noalias}) -> memref<16x32xf64> {
    linalg.generic {indexing_maps = [affine_map<(d0, d1) -> ()>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%arg0 : f64) outs(%arg1 : memref<16x32xf64>) {
    ^bb0(%in: f64, %out: f64):
      linalg.yield %in : f64
    }
    return %arg1 : memref<16x32xf64>
  }
}

