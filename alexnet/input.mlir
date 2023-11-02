module @AlexNet {
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
  util.global private @_params.features.10.bias {noinline} = dense_resource<__elided__> : tensor<256xf32>
  util.global private @_params.classifier.1.weight {noinline} = dense_resource<__elided__> : tensor<4096x9216xf32>
  util.global private @_params.classifier.1.bias {noinline} = dense_resource<__elided__> : tensor<4096xf32>
  util.global private @_params.classifier.4.weight {noinline} = dense_resource<__elided__> : tensor<4096x4096xf32>
  util.global private @_params.classifier.4.bias {noinline} = dense_resource<__elided__> : tensor<4096xf32>
  util.global private @_params.classifier.6.weight {noinline} = dense_resource<__elided__> : tensor<1000x4096xf32>
  util.global private @_params.classifier.6.bias {noinline} = dense_resource<__elided__> : tensor<1000xf32>
  func.func @main(%arg0: tensor<64x3x224x224xf32>) -> tensor<64x1000xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = call @forward(%arg0) : (tensor<64x3x224x224xf32>) -> tensor<64x1000xf32>
    return %0 : tensor<64x1000xf32>
  }
  func.func private @forward(%arg0: tensor<64x3x224x224xf32>) -> tensor<64x1000xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0xFF800000 : f32
    %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
    %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
    %c32_i64 = arith.constant 32 : i64
    %cst_1 = arith.constant 5.4210107999999998E-20 : f64
    %cst_2 = arith.constant 5.000000e-01 : f64
    %cst_3 = arith.constant 0.000000e+00 : f64
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c9216_i64 = arith.constant 9216 : i64
    %cst_4 = arith.constant 5.000000e-01 : f32
    %c4096_i64 = arith.constant 4096 : i64
    %_params.features.0.weight = util.global.load @_params.features.0.weight : tensor<64x3x11x11xf32>
    %_params.features.0.bias = util.global.load @_params.features.0.bias : tensor<64xf32>
    %padded = tensor.pad %arg0 low[0, 0, 2, 2] high[0, 0, 2, 2] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<64x3x224x224xf32> to tensor<64x3x228x228xf32>
    %0 = tensor.empty() : tensor<64x64x55x55xf32>
    %1 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%_params.features.0.bias : tensor<64xf32>) outs(%0 : tensor<64x64x55x55xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<64x64x55x55xf32>
    %2 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<4> : vector<2xi64>} ins(%padded, %_params.features.0.weight : tensor<64x3x228x228xf32>, tensor<64x3x11x11xf32>) outs(%1 : tensor<64x64x55x55xf32>) -> tensor<64x64x55x55xf32>
    %3 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<64x64x55x55xf32>) outs(%0 : tensor<64x64x55x55xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x64x55x55xf32>
    %4 = tensor.empty() : tensor<64x64x27x27xf32>
    %5 = linalg.fill ins(%cst_0 : f32) outs(%4 : tensor<64x64x27x27xf32>) -> tensor<64x64x27x27xf32>
    %6 = tensor.empty() : tensor<3x3xf32>
    %7 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%3, %6 : tensor<64x64x55x55xf32>, tensor<3x3xf32>) outs(%5 : tensor<64x64x27x27xf32>) -> tensor<64x64x27x27xf32>
    %_params.features.3.weight = util.global.load @_params.features.3.weight : tensor<192x64x5x5xf32>
    %_params.features.3.bias = util.global.load @_params.features.3.bias : tensor<192xf32>
    %padded_5 = tensor.pad %7 low[0, 0, 2, 2] high[0, 0, 2, 2] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<64x64x27x27xf32> to tensor<64x64x31x31xf32>
    %8 = tensor.empty() : tensor<64x192x27x27xf32>
    %9 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%_params.features.3.bias : tensor<192xf32>) outs(%8 : tensor<64x192x27x27xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<64x192x27x27xf32>
    %10 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded_5, %_params.features.3.weight : tensor<64x64x31x31xf32>, tensor<192x64x5x5xf32>) outs(%9 : tensor<64x192x27x27xf32>) -> tensor<64x192x27x27xf32>
    %11 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%10 : tensor<64x192x27x27xf32>) outs(%8 : tensor<64x192x27x27xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x192x27x27xf32>
    %12 = tensor.empty() : tensor<64x192x13x13xf32>
    %13 = linalg.fill ins(%cst_0 : f32) outs(%12 : tensor<64x192x13x13xf32>) -> tensor<64x192x13x13xf32>
    %14 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%11, %6 : tensor<64x192x27x27xf32>, tensor<3x3xf32>) outs(%13 : tensor<64x192x13x13xf32>) -> tensor<64x192x13x13xf32>
    %_params.features.6.weight = util.global.load @_params.features.6.weight : tensor<384x192x3x3xf32>
    %_params.features.6.bias = util.global.load @_params.features.6.bias : tensor<384xf32>
    %padded_6 = tensor.pad %14 low[0, 0, 1, 1] high[0, 0, 1, 1] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<64x192x13x13xf32> to tensor<64x192x15x15xf32>
    %15 = tensor.empty() : tensor<64x384x13x13xf32>
    %16 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%_params.features.6.bias : tensor<384xf32>) outs(%15 : tensor<64x384x13x13xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<64x384x13x13xf32>
    %17 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded_6, %_params.features.6.weight : tensor<64x192x15x15xf32>, tensor<384x192x3x3xf32>) outs(%16 : tensor<64x384x13x13xf32>) -> tensor<64x384x13x13xf32>
    %18 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%17 : tensor<64x384x13x13xf32>) outs(%15 : tensor<64x384x13x13xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x384x13x13xf32>
    %_params.features.8.weight = util.global.load @_params.features.8.weight : tensor<256x384x3x3xf32>
    %_params.features.8.bias = util.global.load @_params.features.8.bias : tensor<256xf32>
    %padded_7 = tensor.pad %18 low[0, 0, 1, 1] high[0, 0, 1, 1] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<64x384x13x13xf32> to tensor<64x384x15x15xf32>
    %19 = tensor.empty() : tensor<64x256x13x13xf32>
    %20 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%_params.features.8.bias : tensor<256xf32>) outs(%19 : tensor<64x256x13x13xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<64x256x13x13xf32>
    %21 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded_7, %_params.features.8.weight : tensor<64x384x15x15xf32>, tensor<256x384x3x3xf32>) outs(%20 : tensor<64x256x13x13xf32>) -> tensor<64x256x13x13xf32>
    %22 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%21 : tensor<64x256x13x13xf32>) outs(%19 : tensor<64x256x13x13xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x256x13x13xf32>
    %_params.features.10.weight = util.global.load @_params.features.10.weight : tensor<256x256x3x3xf32>
    %_params.features.10.bias = util.global.load @_params.features.10.bias : tensor<256xf32>
    %padded_8 = tensor.pad %22 low[0, 0, 1, 1] high[0, 0, 1, 1] {
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index):
      tensor.yield %cst : f32
    } : tensor<64x256x13x13xf32> to tensor<64x256x15x15xf32>
    %23 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d1)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%_params.features.10.bias : tensor<256xf32>) outs(%19 : tensor<64x256x13x13xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<64x256x13x13xf32>
    %24 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%padded_8, %_params.features.10.weight : tensor<64x256x15x15xf32>, tensor<256x256x3x3xf32>) outs(%23 : tensor<64x256x13x13xf32>) -> tensor<64x256x13x13xf32>
    %25 = linalg.generic {indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>, affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%24 : tensor<64x256x13x13xf32>) outs(%19 : tensor<64x256x13x13xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x256x13x13xf32>
    %26 = tensor.empty() : tensor<64x256x6x6xf32>
    %27 = linalg.fill ins(%cst_0 : f32) outs(%26 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
    %28 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%25, %6 : tensor<64x256x13x13xf32>, tensor<3x3xf32>) outs(%27 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
    %29 = linalg.fill ins(%cst : f32) outs(%26 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
    %30 = tensor.empty() : tensor<1x1xf32>
    %31 = linalg.pooling_nchw_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%28, %30 : tensor<64x256x6x6xf32>, tensor<1x1xf32>) outs(%29 : tensor<64x256x6x6xf32>) -> tensor<64x256x6x6xf32>
    %collapsed = tensor.collapse_shape %31 [[0], [1, 2, 3]] : tensor<64x256x6x6xf32> into tensor<64x9216xf32>
    %32 = tensor.empty() : tensor<f64>
    %33 = linalg.fill ins(%cst_2 : f64) outs(%32 : tensor<f64>) -> tensor<f64>
    %global_seed = util.global.load @global_seed : tensor<i64>
    %extracted = tensor.extract %global_seed[] : tensor<i64>
    %34 = arith.muli %extracted, %c6364136223846793005_i64 : i64
    %35 = arith.addi %34, %c1442695040888963407_i64 : i64
    %inserted = tensor.insert %35 into %global_seed[] : tensor<i64>
    util.global.store %inserted, @global_seed : tensor<i64>
    %36 = tensor.empty() : tensor<64x9216xf64>
    %37 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} outs(%36 : tensor<64x9216xf64>) {
    ^bb0(%out: f64):
      %71 = linalg.index 0 : index
      %72 = arith.index_cast %71 : index to i64
      %73 = linalg.index 1 : index
      %74 = arith.index_cast %73 : index to i64
      %75 = arith.muli %72, %c9216_i64 : i64
      %76 = arith.addi %75, %74 : i64
      %77 = arith.muli %76, %35 : i64
      %78 = arith.addi %77, %35 : i64
      %79 = arith.muli %77, %77 : i64
      %80 = arith.addi %79, %77 : i64
      %81 = arith.shli %80, %c32_i64 : i64
      %82 = arith.shrui %80, %c32_i64 : i64
      %83 = arith.ori %81, %82 : i64
      %84 = arith.muli %83, %83 : i64
      %85 = arith.addi %84, %78 : i64
      %86 = arith.shli %85, %c32_i64 : i64
      %87 = arith.shrui %85, %c32_i64 : i64
      %88 = arith.ori %86, %87 : i64
      %89 = arith.muli %88, %88 : i64
      %90 = arith.addi %89, %77 : i64
      %91 = arith.shli %90, %c32_i64 : i64
      %92 = arith.shrui %90, %c32_i64 : i64
      %93 = arith.ori %91, %92 : i64
      %94 = arith.muli %93, %93 : i64
      %95 = arith.addi %94, %78 : i64
      %96 = arith.shli %95, %c32_i64 : i64
      %97 = arith.shrui %95, %c32_i64 : i64
      %98 = arith.ori %96, %97 : i64
      %99 = arith.muli %98, %98 : i64
      %100 = arith.addi %99, %77 : i64
      %101 = arith.shrui %100, %c32_i64 : i64
      %102 = arith.xori %95, %101 : i64
      %103 = arith.uitofp %102 : i64 to f64
      %104 = arith.mulf %103, %cst_1 : f64
      %105 = arith.addf %104, %cst_3 : f64
      linalg.yield %105 : f64
    } -> tensor<64x9216xf64>
    %38 = tensor.empty() : tensor<64x9216xi1>
    %39 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> ()>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%37, %33 : tensor<64x9216xf64>, tensor<f64>) outs(%38 : tensor<64x9216xi1>) {
    ^bb0(%in: f64, %in_12: f64, %out: i1):
      %71 = arith.cmpf ult, %in, %in_12 : f64
      linalg.yield %71 : i1
    } -> tensor<64x9216xi1>
    %40 = tensor.empty() : tensor<64x9216xf32>
    %41 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%39 : tensor<64x9216xi1>) outs(%40 : tensor<64x9216xf32>) {
    ^bb0(%in: i1, %out: f32):
      %71 = arith.uitofp %in : i1 to f32
      linalg.yield %71 : f32
    } -> tensor<64x9216xf32>
    %42 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%41, %collapsed : tensor<64x9216xf32>, tensor<64x9216xf32>) outs(%40 : tensor<64x9216xf32>) {
    ^bb0(%in: f32, %in_12: f32, %out: f32):
      %71 = arith.mulf %in, %in_12 : f32
      linalg.yield %71 : f32
    } -> tensor<64x9216xf32>
    %43 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%42 : tensor<64x9216xf32>) outs(%40 : tensor<64x9216xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.divf %in, %cst_4 : f32
      linalg.yield %71 : f32
    } -> tensor<64x9216xf32>
    %_params.classifier.1.weight = util.global.load @_params.classifier.1.weight : tensor<4096x9216xf32>
    %44 = tensor.empty() : tensor<9216x4096xf32>
    %45 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1, d0)>], iterator_types = ["parallel", "parallel"]} ins(%_params.classifier.1.weight : tensor<4096x9216xf32>) outs(%44 : tensor<9216x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<9216x4096xf32>
    %46 = tensor.empty() : tensor<64x4096xf32>
    %47 = linalg.fill ins(%cst : f32) outs(%46 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
    %48 = linalg.matmul ins(%43, %45 : tensor<64x9216xf32>, tensor<9216x4096xf32>) outs(%47 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
    %_params.classifier.1.bias = util.global.load @_params.classifier.1.bias : tensor<4096xf32>
    %49 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%48, %_params.classifier.1.bias : tensor<64x4096xf32>, tensor<4096xf32>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: f32, %in_12: f32, %out: f32):
      %71 = arith.addf %in, %in_12 : f32
      linalg.yield %71 : f32
    } -> tensor<64x4096xf32>
    %50 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%49 : tensor<64x4096xf32>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x4096xf32>
    %global_seed_9 = util.global.load @global_seed : tensor<i64>
    %extracted_10 = tensor.extract %global_seed_9[] : tensor<i64>
    %51 = arith.muli %extracted_10, %c6364136223846793005_i64 : i64
    %52 = arith.addi %51, %c1442695040888963407_i64 : i64
    %inserted_11 = tensor.insert %52 into %global_seed_9[] : tensor<i64>
    util.global.store %inserted_11, @global_seed : tensor<i64>
    %53 = tensor.empty() : tensor<64x4096xf64>
    %54 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} outs(%53 : tensor<64x4096xf64>) {
    ^bb0(%out: f64):
      %71 = linalg.index 0 : index
      %72 = arith.index_cast %71 : index to i64
      %73 = linalg.index 1 : index
      %74 = arith.index_cast %73 : index to i64
      %75 = arith.muli %72, %c4096_i64 : i64
      %76 = arith.addi %75, %74 : i64
      %77 = arith.muli %76, %52 : i64
      %78 = arith.addi %77, %52 : i64
      %79 = arith.muli %77, %77 : i64
      %80 = arith.addi %79, %77 : i64
      %81 = arith.shli %80, %c32_i64 : i64
      %82 = arith.shrui %80, %c32_i64 : i64
      %83 = arith.ori %81, %82 : i64
      %84 = arith.muli %83, %83 : i64
      %85 = arith.addi %84, %78 : i64
      %86 = arith.shli %85, %c32_i64 : i64
      %87 = arith.shrui %85, %c32_i64 : i64
      %88 = arith.ori %86, %87 : i64
      %89 = arith.muli %88, %88 : i64
      %90 = arith.addi %89, %77 : i64
      %91 = arith.shli %90, %c32_i64 : i64
      %92 = arith.shrui %90, %c32_i64 : i64
      %93 = arith.ori %91, %92 : i64
      %94 = arith.muli %93, %93 : i64
      %95 = arith.addi %94, %78 : i64
      %96 = arith.shli %95, %c32_i64 : i64
      %97 = arith.shrui %95, %c32_i64 : i64
      %98 = arith.ori %96, %97 : i64
      %99 = arith.muli %98, %98 : i64
      %100 = arith.addi %99, %77 : i64
      %101 = arith.shrui %100, %c32_i64 : i64
      %102 = arith.xori %95, %101 : i64
      %103 = arith.uitofp %102 : i64 to f64
      %104 = arith.mulf %103, %cst_1 : f64
      %105 = arith.addf %104, %cst_3 : f64
      linalg.yield %105 : f64
    } -> tensor<64x4096xf64>
    %55 = tensor.empty() : tensor<64x4096xi1>
    %56 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> ()>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%54, %33 : tensor<64x4096xf64>, tensor<f64>) outs(%55 : tensor<64x4096xi1>) {
    ^bb0(%in: f64, %in_12: f64, %out: i1):
      %71 = arith.cmpf ult, %in, %in_12 : f64
      linalg.yield %71 : i1
    } -> tensor<64x4096xi1>
    %57 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%56 : tensor<64x4096xi1>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: i1, %out: f32):
      %71 = arith.uitofp %in : i1 to f32
      linalg.yield %71 : f32
    } -> tensor<64x4096xf32>
    %58 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%57, %50 : tensor<64x4096xf32>, tensor<64x4096xf32>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: f32, %in_12: f32, %out: f32):
      %71 = arith.mulf %in, %in_12 : f32
      linalg.yield %71 : f32
    } -> tensor<64x4096xf32>
    %59 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%58 : tensor<64x4096xf32>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.divf %in, %cst_4 : f32
      linalg.yield %71 : f32
    } -> tensor<64x4096xf32>
    %_params.classifier.4.weight = util.global.load @_params.classifier.4.weight : tensor<4096x4096xf32>
    %60 = tensor.empty() : tensor<4096x4096xf32>
    %61 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1, d0)>], iterator_types = ["parallel", "parallel"]} ins(%_params.classifier.4.weight : tensor<4096x4096xf32>) outs(%60 : tensor<4096x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<4096x4096xf32>
    %62 = linalg.matmul ins(%59, %61 : tensor<64x4096xf32>, tensor<4096x4096xf32>) outs(%47 : tensor<64x4096xf32>) -> tensor<64x4096xf32>
    %_params.classifier.4.bias = util.global.load @_params.classifier.4.bias : tensor<4096xf32>
    %63 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%62, %_params.classifier.4.bias : tensor<64x4096xf32>, tensor<4096xf32>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: f32, %in_12: f32, %out: f32):
      %71 = arith.addf %in, %in_12 : f32
      linalg.yield %71 : f32
    } -> tensor<64x4096xf32>
    %64 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%63 : tensor<64x4096xf32>) outs(%46 : tensor<64x4096xf32>) {
    ^bb0(%in: f32, %out: f32):
      %71 = arith.cmpf ugt, %in, %cst : f32
      %72 = arith.select %71, %in, %cst : f32
      linalg.yield %72 : f32
    } -> tensor<64x4096xf32>
    %_params.classifier.6.weight = util.global.load @_params.classifier.6.weight : tensor<1000x4096xf32>
    %65 = tensor.empty() : tensor<4096x1000xf32>
    %66 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1, d0)>], iterator_types = ["parallel", "parallel"]} ins(%_params.classifier.6.weight : tensor<1000x4096xf32>) outs(%65 : tensor<4096x1000xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<4096x1000xf32>
    %67 = tensor.empty() : tensor<64x1000xf32>
    %68 = linalg.fill ins(%cst : f32) outs(%67 : tensor<64x1000xf32>) -> tensor<64x1000xf32>
    %69 = linalg.matmul ins(%64, %66 : tensor<64x4096xf32>, tensor<4096x1000xf32>) outs(%68 : tensor<64x1000xf32>) -> tensor<64x1000xf32>
    %_params.classifier.6.bias = util.global.load @_params.classifier.6.bias : tensor<1000xf32>
    %70 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%69, %_params.classifier.6.bias : tensor<64x1000xf32>, tensor<1000xf32>) outs(%67 : tensor<64x1000xf32>) {
    ^bb0(%in: f32, %in_12: f32, %out: f32):
      %71 = arith.addf %in, %in_12 : f32
      linalg.yield %71 : f32
    } -> tensor<64x1000xf32>
    return %70 : tensor<64x1000xf32>
  }
}