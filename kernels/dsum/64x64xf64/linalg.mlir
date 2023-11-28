#kernel_attributes = {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}

func.func public @dsum(%X: tensor<64x64xf64>,
                       %Y: tensor<64x64xf64>,
                       %Z: tensor<64x64xf64>) -> tensor<64x64xf64> {
  %res = linalg.generic #kernel_attributes
  ins(%X, %Y: tensor<64x64xf64>, tensor<64x64xf64>)
  outs(%Z: tensor<64x64xf64>) {
  ^bb0(%x: f64, %y: f64, %z: f64):
    %r0 = arith.addf %x, %y : f64
    linalg.yield %r0 : f64
  } -> tensor<64x64xf64>
  return %res : tensor<64x64xf64>
}
