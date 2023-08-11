#map = affine_map<(d0, d1, d2, d3)[s0] -> (d0 + d1 + (d2 + d3) * s0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (2)>
#map3 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?xf32>, %arg4: i32, %arg5: memref<?xf32>, %arg6: i32, %arg7: memref<?xf32>, %arg8: i32):
    %0 = "arith.index_cast"(%arg8) : (i32) -> index
    %1 = "arith.index_cast"(%arg4) : (i32) -> index
    %2 = "arith.index_cast"(%arg6) : (i32) -> index
    %3 = "arith.index_cast"(%arg0) : (i32) -> index
    %4 = "arith.index_cast"(%arg1) : (i32) -> index
    %5 = "arith.index_cast"(%arg2) : (i32) -> index
    "affine.for"(%3) ({
    ^bb0(%arg9: index):
      "affine.for"(%4) ({
      ^bb0(%arg10: index):
        "affine.for"(%5) ({
        ^bb0(%arg11: index):
          "affine.for"() ({
          ^bb0(%arg12: index):
            "affine.for"() ({
            ^bb0(%arg13: index):
              %6 = "affine.load"(%arg7, %arg10, %arg13, %arg9, %arg12, %0) {map = #map} : (memref<?xf32>, index, index, index, index, index) -> f32
              %7 = "affine.for"(%6) ({
              ^bb0(%arg14: index, %arg15: f32):
                %8 = "affine.load"(%arg3, %arg11, %arg14, %arg9, %arg12, %1) {map = #map} : (memref<?xf32>, index, index, index, index, index) -> f32
                %9 = "affine.load"(%arg5, %arg10, %arg13, %arg11, %arg14, %2) {map = #map} : (memref<?xf32>, index, index, index, index, index) -> f32
                %10 = "arith.mulf"(%8, %9) : (f32, f32) -> f32
                %11 = "arith.addf"(%arg15, %10) : (f32, f32) -> f32
                "affine.yield"(%11) : (f32) -> ()
              }) {lower_bound = #map1, step = 1 : index, upper_bound = #map2} : (f32) -> f32
              "affine.store"(%7, %arg7, %arg10, %arg13, %arg9, %arg12, %0) {map = #map} : (f32, memref<?xf32>, index, index, index, index, index) -> ()
              "affine.yield"() : () -> ()
            }) {lower_bound = #map1, step = 1 : index, upper_bound = #map2} : () -> ()
            "affine.yield"() : () -> ()
          }) {lower_bound = #map1, step = 1 : index, upper_bound = #map2} : () -> ()
          "affine.yield"() : () -> ()
        }) {lower_bound = #map1, step = 2 : index, upper_bound = #map3} : (index) -> ()
        "affine.yield"() : () -> ()
      }) {lower_bound = #map1, step = 2 : index, upper_bound = #map3} : (index) -> ()
      "affine.yield"() : () -> ()
    }) {lower_bound = #map1, step = 2 : index, upper_bound = #map3} : (index) -> ()
    "func.return"() : () -> ()
  }) {function_type = (i32, i32, i32, memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32) -> (), llvm.linkage = #llvm.linkage<external>, sym_name = "gemm_seq_baseline"} : () -> ()
}) : () -> ()
