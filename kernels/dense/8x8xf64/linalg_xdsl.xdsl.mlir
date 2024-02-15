module {
  func.func public @dense(%arg0: memref<8x8xf64> {llvm.noalias}, %arg1: memref<8x8xf64> {llvm.noalias}, %arg2: memref<8x8xf64> {llvm.noalias}, %arg3: memref<8x8xf64> {llvm.noalias}) -> memref<8x8xf64> {
    %cst = arith.constant 0.000000e+00 : f64
    linalg.generic {indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d2)>, affine_map<(d0, d1, d2) -> (d2, d1)>, affine_map<(d0, d1, d2) -> (d0, d1)>], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0, %arg1 : memref<8x8xf64>, memref<8x8xf64>) outs(%arg3 : memref<8x8xf64>) {
    ^bb0(%in: f64, %in_0: f64, %out: f64):
      %0 = arith.mulf %in, %in_0 : f64
      %1 = arith.addf %out, %0 : f64
      linalg.yield %1 : f64
    }
    linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%arg2 : memref<8x8xf64>) outs(%arg3 : memref<8x8xf64>) {
    ^bb0(%in: f64, %out: f64):
      %0 = arith.addf %in, %out : f64
      linalg.yield %0 : f64
    }
    linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} outs(%arg3 : memref<8x8xf64>) {
    ^bb0(%out: f64):
      %0 = arith.maxf %out, %cst : f64
      linalg.yield %0 : f64
    }
    return %arg3 : memref<8x8xf64>
  }
}
