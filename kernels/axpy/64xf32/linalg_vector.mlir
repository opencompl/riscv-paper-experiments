#traits = {
  indexing_maps = [
    affine_map<(m) -> (m)>,
    affine_map<(m) -> (m)>,
    affine_map<(m) -> (m)>
  ],
  iterator_types = ["parallel"]
}

func.func @axpy(%a: f32,
                %X: memref<64xf32>,
                %Y: memref<64xf32>,
                %G: memref<64xf32>) {
  %av = vector.broadcast %a : f32 to vector<2xf32>
  %Xv = builtin.unrealized_conversion_cast %X : memref<64xf32> to memref<32 x vector<2xf32>>
  %Yv = builtin.unrealized_conversion_cast %Y : memref<64xf32> to memref<32 x vector<2xf32>>
  %Gv = builtin.unrealized_conversion_cast %G : memref<64xf32> to memref<32 x vector<2xf32>>
  linalg.generic #traits
  ins(%Xv, %Yv : memref<32 x vector<2xf32>>, memref<32 x vector<2xf32>>)
  outs(%Gv : memref<32 x vector<2xf32>>)
  {
  ^bb0(%x: vector<2xf32>, %y: vector<2xf32>, %g: vector<2xf32>) :
    %r0 = arith.mulf %x, %av : vector<2xf32>
    %r1 = arith.addf %r0, %y : vector<2xf32>
    linalg.yield %r1 : vector<2xf32>
  }
  func.return
}
