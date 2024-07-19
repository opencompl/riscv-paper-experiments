module {
  func.func public @sum(%arg0: memref<4x4xf32> {llvm.noalias}, %arg1: memref<4x4xf32> {llvm.noalias}, %arg2: memref<4x4xf32> {llvm.noalias}) -> memref<4x4xf32> {
    linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : memref<4x4xf32>, memref<4x4xf32>) outs(%arg2 : memref<4x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %0 = arith.addf %in, %in_0 : f32
      linalg.yield %0 : f32
    }
    return %arg2 : memref<4x4xf32>
  }
}

