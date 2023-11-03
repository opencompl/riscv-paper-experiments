module @AlexNet {
  util.global private @hoisted_2 = dense<0.000000e+00> : tensor<4096x1000xf32>
  util.global private @hoisted_1 = dense<0.000000e+00> : tensor<4096x4096xf32>
  util.global private @hoisted_0 = dense<0.000000e+00> : tensor<9216x4096xf32>
  util.global private @hoisted = dense<5.000000e-01> : tensor<f32>
  util.global private mutable @global_seed = dense<0> : tensor<i64>
  util.global private @_params.features.0.weight {noinline} = dense_resource<__elided__> : tensor<64x3x11x11xf32>
  util.global private @_params.features.0.bias {noinline} = dense_resource<__elided__> : tensor<64xf32>
  util.global private @_params.features.3.weight {noinline} = dense_resource<__elided__> : tensor<192x64x5x5xf32>
  util.global private @_params.features.3.bias {noinline} = dense_resource<__elided__> : tensor<192xf32>
  util.global private @_params.features.6.weight {noinline} = dense_resource<__elided__> : tensor<384x192x3x3xf32>
  util.global private @_params.features.6.bias {noinline} = dense_resource<__elided__> : tensor<384xf32>
  util.global private @_params.features.8.weight {noinline} = dense_resource<__elided__> : tensor<256x384x3x3xf32>
  util.global private @_params.features.8.bias {noinline} = dense_resource<__elided__> : tensor<256xf32>
  util.global private @_params.features.10.weight {noinline} = dense_resource<__elided__> : tensor<256x256x3x3xf32>
  util.global private @_params.classifier.1.bias {noinline} = dense_resource<__elided__> : tensor<4096xf32>
  util.global private @_params.classifier.6.bias {noinline} = dense_resource<__elided__> : tensor<1000xf32>
  flow.executable private @main_dispatch_0 {
    flow.executable.export public @main_dispatch_0 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0(%arg0: !flow.dispatch.tensor<readonly:tensor<64x3x224x224xf32>>, %arg1: !flow.dispatch.tensor<readwrite:tensor<64x3x228x228xf32>>) {
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 3, 224, 224], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x3x224x224xf32>> -> tensor<64x3x224x224xf32>
        flow.dispatch.tensor.store %0, %arg1, offsets = [0, 0, 2, 2], sizes = [64, 3, 224, 224], strides = [1, 1, 1, 1] : tensor<64x3x224x224xf32> -> !flow.dispatch.tensor<readwrite:tensor<64x3x228x228xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_1 {
    flow.executable.export public @main_dispatch_1_conv_2d_nchw_fchw_64x64x55x55x3x11x11_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_1_conv_2d_nchw_fchw_64x64x55x55x3x11x11_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x3x228x228xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<64x3x11x11xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<64xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x64x55x55xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 3, 228, 228], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x3x228x228xf32>> -> tensor<64x3x228x228xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0, 0, 0], sizes = [64, 3, 11, 11], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x3x11x11xf32>> -> tensor<64x3x11x11xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [64], strides = [1] : !flow.dispatch.tensor<readonly:tensor<64xf32>> -> tensor<64xf32>
        %3 = tensor.empty() : tensor<64x64x55x55xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x64x55x55xf32>) -> tensor<64x64x55x55xf32>
        %5 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<4> : vector<2xi64>} ins(%0, %1 : tensor<64x3x228x228xf32>, tensor<64x3x11x11xf32>) outs(%4 : tensor<64x64x55x55xf32>) -> tensor<64x64x55x55xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %2 : tensor<64x64x55x55xf32>, tensor<64xf32>) outs(%3 : tensor<64x64x55x55xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          %8 = arith.cmpf ugt, %7, %cst : f32
          %9 = arith.select %8, %7, %cst : f32
          linalg.yield %9 : f32
        } -> tensor<64x64x55x55xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0, 0, 0], sizes = [64, 64, 55, 55], strides = [1, 1, 1, 1] : tensor<64x64x55x55xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x64x55x55xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_2 {
    flow.executable.export public @main_dispatch_2_pooling_nchw_max_64x64x27x27x3x3_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_2_pooling_nchw_max_64x64x27x27x3x3_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x64x55x55xf32>>, %arg1: !flow.dispatch.tensor<writeonly:tensor<64x64x27x27xf32>>) {
        %cst = arith.constant 0xFF800000 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 64, 55, 55], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x64x55x55xf32>> -> tensor<64x64x55x55xf32>
        %1 = tensor.empty() : tensor<64x64x27x27xf32>
        %2 = tensor.empty() : tensor<3x3xf32>
        %3 = linalg.fill ins(%cst : f32) outs(%1 : tensor<64x64x27x27xf32>) -> tensor<64x64x27x27xf32>
        %4 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%0, %2 : tensor<64x64x55x55xf32>, tensor<3x3xf32>) outs(%3 : tensor<64x64x27x27xf32>) -> tensor<64x64x27x27xf32>
        flow.dispatch.tensor.store %4, %arg1, offsets = [0, 0, 0, 0], sizes = [64, 64, 27, 27], strides = [1, 1, 1, 1] : tensor<64x64x27x27xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x64x27x27xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_3 {
    flow.executable.export public @main_dispatch_3 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_3(%arg0: !flow.dispatch.tensor<readonly:tensor<64x64x27x27xf32>>, %arg1: !flow.dispatch.tensor<readwrite:tensor<64x64x31x31xf32>>) {
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 64, 27, 27], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x64x27x27xf32>> -> tensor<64x64x27x27xf32>
        flow.dispatch.tensor.store %0, %arg1, offsets = [0, 0, 2, 2], sizes = [64, 64, 27, 27], strides = [1, 1, 1, 1] : tensor<64x64x27x27xf32> -> !flow.dispatch.tensor<readwrite:tensor<64x64x31x31xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_4 {
    flow.executable.export public @main_dispatch_4_conv_2d_nchw_fchw_64x192x27x27x64x5x5_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_4_conv_2d_nchw_fchw_64x192x27x27x64x5x5_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x64x31x31xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<192x64x5x5xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<192xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x192x27x27xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 64, 31, 31], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x64x31x31xf32>> -> tensor<64x64x31x31xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0, 0, 0], sizes = [192, 64, 5, 5], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<192x64x5x5xf32>> -> tensor<192x64x5x5xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [192], strides = [1] : !flow.dispatch.tensor<readonly:tensor<192xf32>> -> tensor<192xf32>
        %3 = tensor.empty() : tensor<64x192x27x27xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x192x27x27xf32>) -> tensor<64x192x27x27xf32>
        %5 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%0, %1 : tensor<64x64x31x31xf32>, tensor<192x64x5x5xf32>) outs(%4 : tensor<64x192x27x27xf32>) -> tensor<64x192x27x27xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %2 : tensor<64x192x27x27xf32>, tensor<192xf32>) outs(%3 : tensor<64x192x27x27xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          %8 = arith.cmpf ugt, %7, %cst : f32
          %9 = arith.select %8, %7, %cst : f32
          linalg.yield %9 : f32
        } -> tensor<64x192x27x27xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0, 0, 0], sizes = [64, 192, 27, 27], strides = [1, 1, 1, 1] : tensor<64x192x27x27xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x192x27x27xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_5 {
    flow.executable.export public @main_dispatch_5_pooling_nchw_max_64x192x13x13x3x3_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_5_pooling_nchw_max_64x192x13x13x3x3_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x192x27x27xf32>>, %arg1: !flow.dispatch.tensor<writeonly:tensor<64x192x13x13xf32>>) {
        %cst = arith.constant 0xFF800000 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 192, 27, 27], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x192x27x27xf32>> -> tensor<64x192x27x27xf32>
        %1 = tensor.empty() : tensor<64x192x13x13xf32>
        %2 = tensor.empty() : tensor<3x3xf32>
        %3 = linalg.fill ins(%cst : f32) outs(%1 : tensor<64x192x13x13xf32>) -> tensor<64x192x13x13xf32>
        %4 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%0, %2 : tensor<64x192x27x27xf32>, tensor<3x3xf32>) outs(%3 : tensor<64x192x13x13xf32>) -> tensor<64x192x13x13xf32>
        flow.dispatch.tensor.store %4, %arg1, offsets = [0, 0, 0, 0], sizes = [64, 192, 13, 13], strides = [1, 1, 1, 1] : tensor<64x192x13x13xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x192x13x13xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_6 {
    flow.executable.export public @main_dispatch_6 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_6(%arg0: !flow.dispatch.tensor<readonly:tensor<64x192x13x13xf32>>, %arg1: !flow.dispatch.tensor<readwrite:tensor<64x192x15x15xf32>>) {
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 192, 13, 13], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x192x13x13xf32>> -> tensor<64x192x13x13xf32>
        flow.dispatch.tensor.store %0, %arg1, offsets = [0, 0, 1, 1], sizes = [64, 192, 13, 13], strides = [1, 1, 1, 1] : tensor<64x192x13x13xf32> -> !flow.dispatch.tensor<readwrite:tensor<64x192x15x15xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_7 {
    flow.executable.export public @main_dispatch_7_conv_2d_nchw_fchw_64x384x13x13x192x3x3_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_7_conv_2d_nchw_fchw_64x384x13x13x192x3x3_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x192x15x15xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<384x192x3x3xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<384xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x384x13x13xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 192, 15, 15], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x192x15x15xf32>> -> tensor<64x192x15x15xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0, 0, 0], sizes = [384, 192, 3, 3], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<384x192x3x3xf32>> -> tensor<384x192x3x3xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [384], strides = [1] : !flow.dispatch.tensor<readonly:tensor<384xf32>> -> tensor<384xf32>
        %3 = tensor.empty() : tensor<64x384x13x13xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x384x13x13xf32>) -> tensor<64x384x13x13xf32>
        %5 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%0, %1 : tensor<64x192x15x15xf32>, tensor<384x192x3x3xf32>) outs(%4 : tensor<64x384x13x13xf32>) -> tensor<64x384x13x13xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %2 : tensor<64x384x13x13xf32>, tensor<384xf32>) outs(%3 : tensor<64x384x13x13xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          %8 = arith.cmpf ugt, %7, %cst : f32
          %9 = arith.select %8, %7, %cst : f32
          linalg.yield %9 : f32
        } -> tensor<64x384x13x13xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0, 0, 0], sizes = [64, 384, 13, 13], strides = [1, 1, 1, 1] : tensor<64x384x13x13xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x384x13x13xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_8 {
    flow.executable.export public @main_dispatch_8 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_8(%arg0: !flow.dispatch.tensor<readonly:tensor<64x384x13x13xf32>>, %arg1: !flow.dispatch.tensor<readwrite:tensor<64x384x15x15xf32>>) {
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 384, 13, 13], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x384x13x13xf32>> -> tensor<64x384x13x13xf32>
        flow.dispatch.tensor.store %0, %arg1, offsets = [0, 0, 1, 1], sizes = [64, 384, 13, 13], strides = [1, 1, 1, 1] : tensor<64x384x13x13xf32> -> !flow.dispatch.tensor<readwrite:tensor<64x384x15x15xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_9 {
    flow.executable.export public @main_dispatch_9_conv_2d_nchw_fchw_64x256x13x13x384x3x3_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_9_conv_2d_nchw_fchw_64x256x13x13x384x3x3_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x384x15x15xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<256x384x3x3xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<256xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x256x13x13xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 384, 15, 15], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x384x15x15xf32>> -> tensor<64x384x15x15xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0, 0, 0], sizes = [256, 384, 3, 3], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<256x384x3x3xf32>> -> tensor<256x384x3x3xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [256], strides = [1] : !flow.dispatch.tensor<readonly:tensor<256xf32>> -> tensor<256xf32>
        %3 = tensor.empty() : tensor<64x256x13x13xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x256x13x13xf32>) -> tensor<64x256x13x13xf32>
        %5 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%0, %1 : tensor<64x384x15x15xf32>, tensor<256x384x3x3xf32>) outs(%4 : tensor<64x256x13x13xf32>) -> tensor<64x256x13x13xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %2 : tensor<64x256x13x13xf32>, tensor<256xf32>) outs(%3 : tensor<64x256x13x13xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          %8 = arith.cmpf ugt, %7, %cst : f32
          %9 = arith.select %8, %7, %cst : f32
          linalg.yield %9 : f32
        } -> tensor<64x256x13x13xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0, 0, 0], sizes = [64, 256, 13, 13], strides = [1, 1, 1, 1] : tensor<64x256x13x13xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x256x13x13xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_10 {
    flow.executable.export public @main_dispatch_10 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_10(%arg0: !flow.dispatch.tensor<readonly:tensor<64x256x13x13xf32>>, %arg1: !flow.dispatch.tensor<readwrite:tensor<64x256x15x15xf32>>) {
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 256, 13, 13], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x256x13x13xf32>> -> tensor<64x256x13x13xf32>
        flow.dispatch.tensor.store %0, %arg1, offsets = [0, 0, 1, 1], sizes = [64, 256, 13, 13], strides = [1, 1, 1, 1] : tensor<64x256x13x13xf32> -> !flow.dispatch.tensor<readwrite:tensor<64x256x15x15xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_11 {
    flow.executable.export public @main_dispatch_11_conv_2d_nchw_fchw_64x256x13x13x256x3x3_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_11_conv_2d_nchw_fchw_64x256x13x13x256x3x3_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x256x15x15xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<256x256x3x3xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<256xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x256x13x13xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 256, 15, 15], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x256x15x15xf32>> -> tensor<64x256x15x15xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0, 0, 0], sizes = [256, 256, 3, 3], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<256x256x3x3xf32>> -> tensor<256x256x3x3xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [256], strides = [1] : !flow.dispatch.tensor<readonly:tensor<256xf32>> -> tensor<256xf32>
        %3 = tensor.empty() : tensor<64x256x13x13xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x256x13x13xf32>) -> tensor<64x256x13x13xf32>
        %5 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%0, %1 : tensor<64x256x15x15xf32>, tensor<256x256x3x3xf32>) outs(%4 : tensor<64x256x13x13xf32>) -> tensor<64x256x13x13xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %2 : tensor<64x256x13x13xf32>, tensor<256xf32>) outs(%3 : tensor<64x256x13x13xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          %8 = arith.cmpf ugt, %7, %cst : f32
          %9 = arith.select %8, %7, %cst : f32
          linalg.yield %9 : f32
        } -> tensor<64x256x13x13xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0, 0, 0], sizes = [64, 256, 13, 13], strides = [1, 1, 1, 1] : tensor<64x256x13x13xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x256x13x13xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_12 {
    flow.executable.export public @main_dispatch_12_pooling_nchw_max_64x256x6x6x3x3_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_12_pooling_nchw_max_64x256x6x6x3x3_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x256x13x13xf32>>, %arg1: !flow.dispatch.tensor<writeonly:tensor<64x256x6x6xf32>>) {
        %cst = arith.constant 0xFF800000 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0, 0, 0], sizes = [64, 256, 13, 13], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x256x13x13xf32>> -> tensor<64x256x13x13xf32>
        %1 = tensor.empty() : tensor<64x256x6x6xf32>
        %2 = tensor.empty() : tensor<3x3xf32>
        %3 = linalg.fill ins(%cst : f32) outs(%1 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
        %4 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%0, %2 : tensor<64x256x13x13xf32>, tensor<3x3xf32>) outs(%3 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
        flow.dispatch.tensor.store %4, %arg1, offsets = [0, 0, 0, 0], sizes = [64, 256, 6, 6], strides = [1, 1, 1, 1] : tensor<64x256x6x6xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x256x6x6xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_13 {
    flow.executable.export public @main_dispatch_13 workgroups() -> (index, index, index) {
      %c1 = arith.constant 1 : index
      flow.return %c1, %c1, %c1 : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_13(%arg0: !flow.dispatch.tensor<readonly:tensor<i64>>, %arg1: !flow.dispatch.tensor<writeonly:tensor<i64>>) {
        %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
        %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
        %0 = flow.dispatch.tensor.load %arg0, offsets = [], sizes = [], strides = [] : !flow.dispatch.tensor<readonly:tensor<i64>> -> tensor<i64>
        %extracted = tensor.extract %0[] : tensor<i64>
        %1 = arith.muli %extracted, %c6364136223846793005_i64 : i64
        %2 = arith.addi %1, %c1442695040888963407_i64 : i64
        %inserted = tensor.insert %2 into %0[] : tensor<i64>
        flow.dispatch.tensor.store %inserted, %arg1, offsets = [], sizes = [], strides = [] : tensor<i64> -> !flow.dispatch.tensor<writeonly:tensor<i64>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_14 {
    flow.executable.export public @main_dispatch_14_generic_64x256x6x6_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_14_generic_64x256x6x6_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<i64>>, %arg1: !flow.dispatch.tensor<readonly:tensor<64x256x6x6xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<f32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x256x6x6xf32>>) {
        %c9216_i64 = arith.constant 9216 : i64
        %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
        %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
        %c32_i64 = arith.constant 32 : i64
        %cst = arith.constant 5.42101054E-20 : f32
        %cst_0 = arith.constant 0.000000e+00 : f32
        %cst_1 = arith.constant 5.000000e-01 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [], sizes = [], strides = [] : !flow.dispatch.tensor<readonly:tensor<i64>> -> tensor<i64>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0, 0, 0], sizes = [64, 256, 6, 6], strides = [1, 1, 1, 1] : !flow.dispatch.tensor<readonly:tensor<64x256x6x6xf32>> -> tensor<64x256x6x6xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [], sizes = [], strides = [] : !flow.dispatch.tensor<readonly:tensor<f32>> -> tensor<f32>
        %3 = tensor.empty() : tensor<64x256x6x6xf32>
        %extracted = tensor.extract %0[] : tensor<i64>
        %4 = linalg.fill ins(%cst_0 : f32) outs(%3 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
        %5 = tensor.empty() : tensor<1x1xf32>
        %6 = arith.muli %extracted, %c6364136223846793005_i64 : i64
        %7 = arith.addi %6, %c1442695040888963407_i64 : i64
        %8 = linalg.pooling_nchw_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%1, %5 : tensor<64x256x6x6xf32>, tensor<1x1xf32>) outs(%4 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
        %9 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> ()>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%2, %8 : tensor<f32>, tensor<64x256x6x6xf32>) outs(%3 : tensor<64x256x6x6xf32>) {
        ^bb0(%in: f32, %in_2: f32, %out: f32):
          %10 = linalg.index 0 : index
          %11 = linalg.index 1 : index
          %12 = linalg.index 2 : index
          %13 = linalg.index 3 : index
          %14 = arith.index_cast %10 : index to i64
          %15 = affine.apply affine_map<(d0, d1, d2) -> (d0 + d1 * 6 + d2 * 36)>(%13, %12, %11)
          %16 = arith.index_cast %15 : index to i64
          %17 = arith.muli %14, %c9216_i64 : i64
          %18 = arith.addi %17, %16 : i64
          %19 = arith.muli %18, %7 : i64
          %20 = arith.addi %19, %7 : i64
          %21 = arith.muli %19, %19 : i64
          %22 = arith.addi %21, %19 : i64
          %23 = arith.shli %22, %c32_i64 : i64
          %24 = arith.shrui %22, %c32_i64 : i64
          %25 = arith.ori %23, %24 : i64
          %26 = arith.muli %25, %25 : i64
          %27 = arith.addi %26, %20 : i64
          %28 = arith.shli %27, %c32_i64 : i64
          %29 = arith.shrui %27, %c32_i64 : i64
          %30 = arith.ori %28, %29 : i64
          %31 = arith.muli %30, %30 : i64
          %32 = arith.addi %31, %19 : i64
          %33 = arith.shli %32, %c32_i64 : i64
          %34 = arith.shrui %32, %c32_i64 : i64
          %35 = arith.ori %33, %34 : i64
          %36 = arith.muli %35, %35 : i64
          %37 = arith.addi %36, %20 : i64
          %38 = arith.shli %37, %c32_i64 : i64
          %39 = arith.shrui %37, %c32_i64 : i64
          %40 = arith.ori %38, %39 : i64
          %41 = arith.muli %40, %40 : i64
          %42 = arith.addi %41, %19 : i64
          %43 = arith.shrui %42, %c32_i64 : i64
          %44 = arith.xori %37, %43 : i64
          %45 = arith.uitofp %44 : i64 to f32
          %46 = arith.mulf %45, %cst : f32
          %47 = arith.addf %46, %cst_0 : f32
          %48 = arith.cmpf ult, %47, %in : f32
          %49 = arith.uitofp %48 : i1 to f32
          %50 = arith.mulf %49, %in_2 : f32
          %51 = arith.divf %50, %cst_1 : f32
          linalg.yield %51 : f32
        } -> tensor<64x256x6x6xf32>
        flow.dispatch.tensor.store %9, %arg3, offsets = [0, 0, 0, 0], sizes = [64, 256, 6, 6], strides = [1, 1, 1, 1] : tensor<64x256x6x6xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x256x6x6xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_15 {
    flow.executable.export public @main_dispatch_15_matmul_64x4096x9216_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_15_matmul_64x4096x9216_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<i64>>, %arg1: !flow.dispatch.tensor<readonly:tensor<64x9216xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<9216x4096xf32>>, %arg3: !flow.dispatch.tensor<readonly:tensor<f32>>, %arg4: !flow.dispatch.tensor<readonly:tensor<4096xf32>>, %arg5: !flow.dispatch.tensor<writeonly:tensor<64x4096xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %c4096_i64 = arith.constant 4096 : i64
        %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
        %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
        %c32_i64 = arith.constant 32 : i64
        %cst_0 = arith.constant 5.42101054E-20 : f32
        %cst_1 = arith.constant 5.000000e-01 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [], sizes = [], strides = [] : !flow.dispatch.tensor<readonly:tensor<i64>> -> tensor<i64>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [64, 9216], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<64x9216xf32>> -> tensor<64x9216xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0, 0], sizes = [9216, 4096], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<9216x4096xf32>> -> tensor<9216x4096xf32>
        %3 = flow.dispatch.tensor.load %arg3, offsets = [], sizes = [], strides = [] : !flow.dispatch.tensor<readonly:tensor<f32>> -> tensor<f32>
        %4 = flow.dispatch.tensor.load %arg4, offsets = [0], sizes = [4096], strides = [1] : !flow.dispatch.tensor<readonly:tensor<4096xf32>> -> tensor<4096xf32>
        %5 = tensor.empty() : tensor<64x4096xf32>
        %extracted = tensor.extract %0[] : tensor<i64>
        %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
        %7 = arith.muli %extracted, %c6364136223846793005_i64 : i64
        %8 = arith.addi %7, %c1442695040888963407_i64 : i64
        %9 = linalg.matmul ins(%1, %2 : tensor<64x9216xf32>, tensor<9216x4096xf32>) outs(%6 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
        %10 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> ()>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%3, %9, %4 : tensor<f32>, tensor<64x4096xf32>, tensor<4096xf32>) outs(%5 : tensor<64x4096xf32>) {
        ^bb0(%in: f32, %in_2: f32, %in_3: f32, %out: f32):
          %11 = arith.addf %in_2, %in_3 : f32
          %12 = arith.cmpf ugt, %11, %cst : f32
          %13 = arith.select %12, %11, %cst : f32
          %14 = linalg.index 0 : index
          %15 = linalg.index 1 : index
          %16 = arith.index_cast %14 : index to i64
          %17 = arith.index_cast %15 : index to i64
          %18 = arith.muli %16, %c4096_i64 : i64
          %19 = arith.addi %18, %17 : i64
          %20 = arith.muli %19, %8 : i64
          %21 = arith.addi %20, %8 : i64
          %22 = arith.muli %20, %20 : i64
          %23 = arith.addi %22, %20 : i64
          %24 = arith.shli %23, %c32_i64 : i64
          %25 = arith.shrui %23, %c32_i64 : i64
          %26 = arith.ori %24, %25 : i64
          %27 = arith.muli %26, %26 : i64
          %28 = arith.addi %27, %21 : i64
          %29 = arith.shli %28, %c32_i64 : i64
          %30 = arith.shrui %28, %c32_i64 : i64
          %31 = arith.ori %29, %30 : i64
          %32 = arith.muli %31, %31 : i64
          %33 = arith.addi %32, %20 : i64
          %34 = arith.shli %33, %c32_i64 : i64
          %35 = arith.shrui %33, %c32_i64 : i64
          %36 = arith.ori %34, %35 : i64
          %37 = arith.muli %36, %36 : i64
          %38 = arith.addi %37, %21 : i64
          %39 = arith.shli %38, %c32_i64 : i64
          %40 = arith.shrui %38, %c32_i64 : i64
          %41 = arith.ori %39, %40 : i64
          %42 = arith.muli %41, %41 : i64
          %43 = arith.addi %42, %20 : i64
          %44 = arith.shrui %43, %c32_i64 : i64
          %45 = arith.xori %38, %44 : i64
          %46 = arith.uitofp %45 : i64 to f32
          %47 = arith.mulf %46, %cst_0 : f32
          %48 = arith.addf %47, %cst : f32
          %49 = arith.cmpf ult, %48, %in : f32
          %50 = arith.uitofp %49 : i1 to f32
          %51 = arith.mulf %50, %13 : f32
          %52 = arith.divf %51, %cst_1 : f32
          linalg.yield %52 : f32
        } -> tensor<64x4096xf32>
        flow.dispatch.tensor.store %10, %arg5, offsets = [0, 0], sizes = [64, 4096], strides = [1, 1] : tensor<64x4096xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x4096xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_16 {
    flow.executable.export public @main_dispatch_16_matmul_64x4096x4096_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_16_matmul_64x4096x4096_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x4096xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<4096x4096xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<4096xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x4096xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0], sizes = [64, 4096], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<64x4096xf32>> -> tensor<64x4096xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [4096, 4096], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4096x4096xf32>> -> tensor<4096x4096xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [4096], strides = [1] : !flow.dispatch.tensor<readonly:tensor<4096xf32>> -> tensor<4096xf32>
        %3 = tensor.empty() : tensor<64x4096xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
        %5 = linalg.matmul ins(%0, %1 : tensor<64x4096xf32>, tensor<4096x4096xf32>) outs(%4 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%5, %2 : tensor<64x4096xf32>, tensor<4096xf32>) outs(%3 : tensor<64x4096xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          %8 = arith.cmpf ugt, %7, %cst : f32
          %9 = arith.select %8, %7, %cst : f32
          linalg.yield %9 : f32
        } -> tensor<64x4096xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0], sizes = [64, 4096], strides = [1, 1] : tensor<64x4096xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x4096xf32>>
        return
      }
    }
  }
  flow.executable private @main_dispatch_17 {
    flow.executable.export public @main_dispatch_17_matmul_64x1000x4096_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_17_matmul_64x1000x4096_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<64x4096xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<4096x1000xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<1000xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<64x1000xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0], sizes = [64, 4096], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<64x4096xf32>> -> tensor<64x4096xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [4096, 1000], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4096x1000xf32>> -> tensor<4096x1000xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0], sizes = [1000], strides = [1] : !flow.dispatch.tensor<readonly:tensor<1000xf32>> -> tensor<1000xf32>
        %3 = tensor.empty() : tensor<64x1000xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<64x1000xf32>) -> tensor<64x1000xf32>
        %5 = linalg.matmul ins(%0, %1 : tensor<64x4096xf32>, tensor<4096x1000xf32>) outs(%4 : tensor<64x1000xf32>) -> tensor<64x1000xf32>
        %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%5, %2 : tensor<64x1000xf32>, tensor<1000xf32>) outs(%3 : tensor<64x1000xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = arith.addf %in, %in_0 : f32
          linalg.yield %7 : f32
        } -> tensor<64x1000xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0], sizes = [64, 1000], strides = [1, 1] : tensor<64x1000xf32> -> !flow.dispatch.tensor<writeonly:tensor<64x1000xf32>>
        return
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %cst = arith.constant 0.000000e+00 : f32
    %global_seed = util.global.load @global_seed : tensor<i64>
    %_params.features.0.weight = util.global.load @_params.features.0.weight : tensor<64x3x11x11xf32>
    %_params.features.0.bias = util.global.load @_params.features.0.bias : tensor<64xf32>
    %_params.features.3.weight = util.global.load @_params.features.3.weight : tensor<192x64x5x5xf32>
    %_params.features.3.bias = util.global.load @_params.features.3.bias : tensor<192xf32>
    %_params.features.6.weight = util.global.load @_params.features.6.weight : tensor<384x192x3x3xf32>
    %_params.features.6.bias = util.global.load @_params.features.6.bias : tensor<384xf32>
    %_params.features.8.weight = util.global.load @_params.features.8.weight : tensor<256x384x3x3xf32>
    %_params.features.8.bias = util.global.load @_params.features.8.bias : tensor<256xf32>
    %_params.features.10.weight = util.global.load @_params.features.10.weight : tensor<256x256x3x3xf32>
    %_params.classifier.1.bias = util.global.load @_params.classifier.1.bias : tensor<4096xf32>
    %_params.classifier.6.bias = util.global.load @_params.classifier.6.bias : tensor<1000xf32>
    %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<64x3x224x224xf32>
    %1 = flow.tensor.splat %cst : tensor<64x3x228x228xf32>
    %2 = flow.dispatch @main_dispatch_0::@main_dispatch_0(%0, %1) : (tensor<64x3x224x224xf32>, tensor<64x3x228x228xf32>) -> %1
    %3 = flow.dispatch @main_dispatch_1::@main_dispatch_1_conv_2d_nchw_fchw_64x64x55x55x3x11x11_f32(%2, %_params.features.0.weight, %_params.features.0.bias) : (tensor<64x3x228x228xf32>, tensor<64x3x11x11xf32>, tensor<64xf32>) -> tensor<64x64x55x55xf32>
    %4 = flow.dispatch @main_dispatch_2::@main_dispatch_2_pooling_nchw_max_64x64x27x27x3x3_f32(%3) : (tensor<64x64x55x55xf32>) -> tensor<64x64x27x27xf32>
    %5 = flow.tensor.splat %cst : tensor<64x64x31x31xf32>
    %6 = flow.dispatch @main_dispatch_3::@main_dispatch_3(%4, %5) : (tensor<64x64x27x27xf32>, tensor<64x64x31x31xf32>) -> %5
    %7 = flow.dispatch @main_dispatch_4::@main_dispatch_4_conv_2d_nchw_fchw_64x192x27x27x64x5x5_f32(%6, %_params.features.3.weight, %_params.features.3.bias) : (tensor<64x64x31x31xf32>, tensor<192x64x5x5xf32>, tensor<192xf32>) -> tensor<64x192x27x27xf32>
    %8 = flow.dispatch @main_dispatch_5::@main_dispatch_5_pooling_nchw_max_64x192x13x13x3x3_f32(%7) : (tensor<64x192x27x27xf32>) -> tensor<64x192x13x13xf32>
    %9 = flow.tensor.splat %cst : tensor<64x192x15x15xf32>
    %10 = flow.dispatch @main_dispatch_6::@main_dispatch_6(%8, %9) : (tensor<64x192x13x13xf32>, tensor<64x192x15x15xf32>) -> %9
    %11 = flow.dispatch @main_dispatch_7::@main_dispatch_7_conv_2d_nchw_fchw_64x384x13x13x192x3x3_f32(%10, %_params.features.6.weight, %_params.features.6.bias) : (tensor<64x192x15x15xf32>, tensor<384x192x3x3xf32>, tensor<384xf32>) -> tensor<64x384x13x13xf32>
    %12 = flow.tensor.splat %cst : tensor<64x384x15x15xf32>
    %13 = flow.dispatch @main_dispatch_8::@main_dispatch_8(%11, %12) : (tensor<64x384x13x13xf32>, tensor<64x384x15x15xf32>) -> %12
    %14 = flow.dispatch @main_dispatch_9::@main_dispatch_9_conv_2d_nchw_fchw_64x256x13x13x384x3x3_f32(%13, %_params.features.8.weight, %_params.features.8.bias) : (tensor<64x384x15x15xf32>, tensor<256x384x3x3xf32>, tensor<256xf32>) -> tensor<64x256x13x13xf32>
    %15 = flow.tensor.splat %cst : tensor<64x256x15x15xf32>
    %16 = flow.dispatch @main_dispatch_10::@main_dispatch_10(%14, %15) : (tensor<64x256x13x13xf32>, tensor<64x256x15x15xf32>) -> %15
    %17 = flow.dispatch @main_dispatch_11::@main_dispatch_11_conv_2d_nchw_fchw_64x256x13x13x256x3x3_f32(%16, %_params.features.10.weight, %_params.features.8.bias) : (tensor<64x256x15x15xf32>, tensor<256x256x3x3xf32>, tensor<256xf32>) -> tensor<64x256x13x13xf32>
    %18 = flow.dispatch @main_dispatch_12::@main_dispatch_12_pooling_nchw_max_64x256x6x6x3x3_f32(%17) : (tensor<64x256x13x13xf32>) -> tensor<64x256x6x6xf32>
    %hoisted = util.global.load @hoisted : tensor<f32>
    %19 = flow.dispatch @main_dispatch_13::@main_dispatch_13(%global_seed) : (tensor<i64>) -> tensor<i64>
    %20 = flow.dispatch @main_dispatch_14::@main_dispatch_14_generic_64x256x6x6_f32(%global_seed, %18, %hoisted) : (tensor<i64>, tensor<64x256x6x6xf32>, tensor<f32>) -> tensor<64x256x6x6xf32>
    %21 = flow.tensor.reshape %20 : tensor<64x256x6x6xf32> -> tensor<64x9216xf32>
    %hoisted_0 = util.global.load @hoisted_0 : tensor<9216x4096xf32>
    %22 = flow.dispatch @main_dispatch_15::@main_dispatch_15_matmul_64x4096x9216_f32(%global_seed, %21, %hoisted_0, %hoisted, %_params.classifier.1.bias) : (tensor<i64>, tensor<64x9216xf32>, tensor<9216x4096xf32>, tensor<f32>, tensor<4096xf32>) -> tensor<64x4096xf32>
    %hoisted_1 = util.global.load @hoisted_1 : tensor<4096x4096xf32>
    %23 = flow.dispatch @main_dispatch_16::@main_dispatch_16_matmul_64x4096x4096_f32(%22, %hoisted_1, %_params.classifier.1.bias) : (tensor<64x4096xf32>, tensor<4096x4096xf32>, tensor<4096xf32>) -> tensor<64x4096xf32>
    %hoisted_2 = util.global.load @hoisted_2 : tensor<4096x1000xf32>
    %24 = flow.dispatch @main_dispatch_17::@main_dispatch_17_matmul_64x1000x4096_f32(%23, %hoisted_2, %_params.classifier.6.bias) : (tensor<64x4096xf32>, tensor<4096x1000xf32>, tensor<1000xf32>) -> tensor<64x1000xf32>
    %25 = hal.tensor.export %24 "output 0" : tensor<64x1000xf32> -> !hal.buffer_view
    util.global.store %19, @global_seed : tensor<i64>
    util.global.store %19, @global_seed : tensor<i64>
    return %25 : !hal.buffer_view
  }
}