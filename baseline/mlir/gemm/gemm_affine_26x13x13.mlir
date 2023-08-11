#map = affine_map<(d0, d1) -> (d0 + d1 * 13)>
#map1 = affine_map<(d0, d1) -> (d0 + d1 * 26)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (13)>
#map4 = affine_map<() -> (26)>
"builtin.module"() ({
  "func.func"() ({
  ^bb0(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: memref<?xf64>):
    %0 = "arith.constant"() {value = 0.000000e+00 : f64} : () -> f64
    "affine.for"() ({
    ^bb0(%arg3: index):
      "affine.for"() ({
      ^bb0(%arg4: index):
        %1 = "affine.for"(%0) ({
        ^bb0(%arg5: index, %arg6: f64):
          %2 = "affine.load"(%arg0, %arg5, %arg3) {map = #map} : (memref<?xf64>, index, index) -> f64
          %3 = "affine.load"(%arg1, %arg4, %arg5) {map = #map1} : (memref<?xf64>, index, index) -> f64
          %4 = "arith.mulf"(%2, %3) : (f64, f64) -> f64
          %5 = "arith.addf"(%arg6, %4) : (f64, f64) -> f64
          "affine.yield"(%5) : (f64) -> ()
        }) {lower_bound = #map2, step = 1 : index, upper_bound = #map3} : (f64) -> f64
        "affine.store"(%1, %arg2, %arg4, %arg3) {map = #map1} : (f64, memref<?xf64>, index, index) -> ()
        "affine.yield"() : () -> ()
      }) {lower_bound = #map2, step = 1 : index, upper_bound = #map4} : () -> ()
      "affine.yield"() : () -> ()
    }) {lower_bound = #map2, step = 1 : index, upper_bound = #map4} : () -> ()
    "func.return"() : () -> ()
  }) {function_type = (memref<?xf64>, memref<?xf64>, memref<?xf64>) -> (), sym_name = "gemm"} : () -> ()
}) : () -> ()