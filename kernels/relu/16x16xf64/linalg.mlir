#kernel_attributes = {
  indexing_maps = [
    affine_map<(m, n) -> (m, n)>,
    affine_map<(m, n) -> (m, n)>
  ],
  iterator_types = ["parallel", "parallel"]
}

func.func public @relu(%X: tensor<16x16xf64> {"llvm.noalias"}, %Y: tensor<16x16xf64> {"llvm.noalias"}) -> tensor<16x16xf64> {
  %zero = arith.constant 0.0 : f64
  %zeros = linalg.fill ins(%zero : f64) outs(%Y : tensor<16x16xf64>) -> tensor<16x16xf64>
  %c0 = arith.constant 0.0 : f64
  %res = linalg.generic #kernel_attributes
  ins(%X: tensor<16x16xf64>)
  outs(%zeros: tensor<16x16xf64>) {
  ^bb0(%x: f64, %y: f64):
    %r0 = arith.maxf %x, %c0 : f64
    linalg.yield %r0 : f64
  } -> tensor<16x16xf64>
  return %res : tensor<16x16xf64>
}
