#kernel_attributes = {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}

func.func public @ssum(%X: memref<8x16xf32> {"llvm.noalias"},
                       %Y: memref<8x16xf32> {"llvm.noalias"},
                       %Z: memref<8x16xf32> {"llvm.noalias"}) -> () {
  linalg.generic #kernel_attributes
  ins(%X, %Y: memref<8x16xf32>, memref<8x16xf32>)
  outs(%Z: memref<8x16xf32>) {
  ^bb0(%x: f32, %y: f32, %z: f32):
    %r0 = arith.addf %x, %y : f32
    linalg.yield %r0 : f32
  }
  return
}
