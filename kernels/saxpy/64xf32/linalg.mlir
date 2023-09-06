#axpy_attributes = {
  indexing_maps = [
    affine_map<(n) -> (n)>,
    affine_map<(n) -> (n)>,
    affine_map<(n) -> (n)>
  ],
  iterator_types = ["parallel"]
}

func.func public @saxpy(%a: f32,
                       %X: memref<64xf32>,
                       %Y: memref<64xf32>,
                       %Z: memref<64xf32>) -> () {
  linalg.generic #axpy_attributes
  ins(%X, %Y: memref<64xf32>, memref<64xf32>)
  outs(%Z: memref<64xf32>) {
  ^bb0(%x: f32, %y: f32, %z: f32):
    %r0 = arith.mulf %x, %a : f32
    %r1 = arith.addf %r0, %y : f32
    linalg.yield %r1 : f32
  }
  return
}
