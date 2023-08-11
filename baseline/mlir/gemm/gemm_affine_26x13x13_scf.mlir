"builtin.module"() ({
  "func.func"() ({
  ^bb0(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: memref<?xf64>):
    %0 = "arith.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %1 = "arith.constant"() {value = 0 : index} : () -> index
    %2 = "arith.constant"() {value = 26 : index} : () -> index
    %3 = "arith.constant"() {value = 1 : index} : () -> index
    "scf.for"(%1, %2, %3) ({
    ^bb0(%arg3: index):
      %4 = "arith.constant"() {value = 0 : index} : () -> index
      %5 = "arith.constant"() {value = 26 : index} : () -> index
      %6 = "arith.constant"() {value = 1 : index} : () -> index
      "scf.for"(%4, %5, %6) ({
      ^bb0(%arg4: index):
        %7 = "arith.constant"() {value = 0 : index} : () -> index
        %8 = "arith.constant"() {value = 13 : index} : () -> index
        %9 = "arith.constant"() {value = 1 : index} : () -> index
        %10 = "scf.for"(%7, %8, %9, %0) ({
        ^bb0(%arg5: index, %arg6: f64):
          %14 = "arith.constant"() {value = 13 : index} : () -> index
          %15 = "arith.muli"(%arg3, %14) : (index, index) -> index
          %16 = "arith.addi"(%arg5, %15) : (index, index) -> index
          %17 = "memref.load"(%arg0, %16) : (memref<?xf64>, index) -> f64
          %18 = "arith.constant"() {value = 26 : index} : () -> index
          %19 = "arith.muli"(%arg5, %18) : (index, index) -> index
          %20 = "arith.addi"(%arg4, %19) : (index, index) -> index
          %21 = "memref.load"(%arg1, %20) : (memref<?xf64>, index) -> f64
          %22 = "arith.mulf"(%17, %21) : (f64, f64) -> f64
          %23 = "arith.addf"(%arg6, %22) : (f64, f64) -> f64
          "scf.yield"(%23) : (f64) -> ()
        }) : (index, index, index, f64) -> f64
        %11 = "arith.constant"() {value = 26 : index} : () -> index
        %12 = "arith.muli"(%arg3, %11) : (index, index) -> index
        %13 = "arith.addi"(%arg4, %12) : (index, index) -> index
        "memref.store"(%10, %arg2, %13) : (f64, memref<?xf64>, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {function_type = (memref<?xf64>, memref<?xf64>, memref<?xf64>) -> (), llvm.linkage = #llvm.linkage<external>, sym_name = "gemm"} : () -> ()
}) : () -> ()
