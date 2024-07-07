  func.func public @pooling_nchw_max_d1_s2_3x3(%X : tensor<1x1x10x10xf64> {"llvm.noalias"}, %Y : tensor<1x1x4x4xf64> {"llvm.noalias"}) -> tensor<1x1x4x4xf64> {
    %zero = arith.constant 0.000000e+00 : f64
    %zeros = linalg.fill ins(%zero : f64) outs(%Y : tensor<1x1x4x4xf64>) -> tensor<1x1x4x4xf64>
    %kernel = tensor.empty() : tensor<3x3xf32>
    %res = linalg.pooling_nchw_max {"dilations" = dense<1> : vector<2xi64>, "strides" = dense<2> : vector<2xi64>} ins(%X, %kernel : tensor<1x1x10x10xf64>, tensor<3x3xf32>) outs(%zeros : tensor<1x1x4x4xf64>) -> tensor<1x1x4x4xf64>
    func.return %res : tensor<1x1x4x4xf64>
  }

