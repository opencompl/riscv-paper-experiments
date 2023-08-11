"builtin.module"() ({
  "func.func"() ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?xf32>, %arg4: i32, %arg5: memref<?xf32>, %arg6: i32, %arg7: memref<?xf32>, %arg8: i32):
    %0 = "arith.index_cast"(%arg8) : (i32) -> index
    %1 = "arith.index_cast"(%arg4) : (i32) -> index
    %2 = "arith.index_cast"(%arg6) : (i32) -> index
    %3 = "arith.index_cast"(%arg0) : (i32) -> index
    %4 = "arith.index_cast"(%arg1) : (i32) -> index
    %5 = "arith.index_cast"(%arg2) : (i32) -> index
    %6 = "arith.constant"() {value = 0 : index} : () -> index
    %7 = "arith.constant"() {value = 2 : index} : () -> index
    "scf.for"(%6, %3, %7) ({
    ^bb0(%arg9: index):
      %8 = "arith.constant"() {value = 0 : index} : () -> index
      %9 = "arith.constant"() {value = 2 : index} : () -> index
      "scf.for"(%8, %4, %9) ({
      ^bb0(%arg10: index):
        %10 = "arith.constant"() {value = 0 : index} : () -> index
        %11 = "arith.constant"() {value = 2 : index} : () -> index
        "scf.for"(%10, %5, %11) ({
        ^bb0(%arg11: index):
          %12 = "arith.constant"() {value = 0 : index} : () -> index
          %13 = "arith.constant"() {value = 2 : index} : () -> index
          %14 = "arith.constant"() {value = 1 : index} : () -> index
          "scf.for"(%12, %13, %14) ({
          ^bb0(%arg12: index):
            %15 = "arith.constant"() {value = 0 : index} : () -> index
            %16 = "arith.constant"() {value = 2 : index} : () -> index
            %17 = "arith.constant"() {value = 1 : index} : () -> index
            "scf.for"(%15, %16, %17) ({
            ^bb0(%arg13: index):
              %18 = "arith.addi"(%arg10, %arg13) : (index, index) -> index
              %19 = "arith.addi"(%arg9, %arg12) : (index, index) -> index
              %20 = "arith.muli"(%19, %0) : (index, index) -> index
              %21 = "arith.addi"(%18, %20) : (index, index) -> index
              %22 = "memref.load"(%arg7, %21) : (memref<?xf32>, index) -> f32
              %23 = "arith.constant"() {value = 0 : index} : () -> index
              %24 = "arith.constant"() {value = 2 : index} : () -> index
              %25 = "arith.constant"() {value = 1 : index} : () -> index
              %26 = "scf.for"(%23, %24, %25, %22) ({
              ^bb0(%arg14: index, %arg15: f32):
                %31 = "arith.addi"(%arg11, %arg14) : (index, index) -> index
                %32 = "arith.addi"(%arg9, %arg12) : (index, index) -> index
                %33 = "arith.muli"(%32, %1) : (index, index) -> index
                %34 = "arith.addi"(%31, %33) : (index, index) -> index
                %35 = "memref.load"(%arg3, %34) : (memref<?xf32>, index) -> f32
                %36 = "arith.addi"(%arg10, %arg13) : (index, index) -> index
                %37 = "arith.addi"(%arg11, %arg14) : (index, index) -> index
                %38 = "arith.muli"(%37, %2) : (index, index) -> index
                %39 = "arith.addi"(%36, %38) : (index, index) -> index
                %40 = "memref.load"(%arg5, %39) : (memref<?xf32>, index) -> f32
                %41 = "arith.mulf"(%35, %40) : (f32, f32) -> f32
                %42 = "arith.addf"(%arg15, %41) : (f32, f32) -> f32
                "scf.yield"(%42) : (f32) -> ()
              }) : (index, index, index, f32) -> f32
              %27 = "arith.addi"(%arg10, %arg13) : (index, index) -> index
              %28 = "arith.addi"(%arg9, %arg12) : (index, index) -> index
              %29 = "arith.muli"(%28, %0) : (index, index) -> index
              %30 = "arith.addi"(%27, %29) : (index, index) -> index
              "memref.store"(%26, %arg7, %30) : (f32, memref<?xf32>, index) -> ()
              "scf.yield"() : () -> ()
            }) : (index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {function_type = (i32, i32, i32, memref<?xf32>, i32, memref<?xf32>, i32, memref<?xf32>, i32) -> (), llvm.linkage = #llvm.linkage<external>, sym_name = "gemm_seq_baseline"} : () -> ()
}) : () -> ()
