#map = affine_map<(m, n) -> (m, n)>

#add_attributes = {
  indexing_maps = [#map, #map],
  iterator_types = ["parallel", "parallel"]
}

#relu_attributes = {
  indexing_maps = [#map],
  iterator_types = ["parallel", "parallel"]
}
func.func public @dense(%X: tensor<8x8xf64>,
                        %W: tensor<8x8xf64>,
                        %B: tensor<8x8xf64>,
                        %Y: tensor<8x8xf64>) -> tensor<8x8xf64>
                        attributes {arg_attrs = [{"llvm.noalias"}, {"llvm.noalias"}, {"llvm.noalias"}, {"llvm.noalias"}]} {
  %H0 = linalg.matmul ins(%X, %W : tensor<8x8xf64>, tensor<8x8xf64>) outs(%Y : tensor<8x8xf64>) -> tensor<8x8xf64>
  %H1 = linalg.generic #add_attributes
  ins(%B: tensor<8x8xf64>)
  outs(%H0: tensor<8x8xf64>) {
  ^bb0(%b: f64, %y: f64):
    %r0 = arith.addf %b, %y : f64
    linalg.yield %r0 : f64
  } -> tensor<8x8xf64>
  %c0 = arith.constant 0.0 : f64
  %res = linalg.generic #relu_attributes outs(%H1: tensor<8x8xf64>) {
  ^bb0(%y: f64):
    %r0 = arith.maxf %y, %c0 : f64
    linalg.yield %r0 : f64
  } -> tensor<8x8xf64>
  func.return %res : tensor<8x8xf64>
}
