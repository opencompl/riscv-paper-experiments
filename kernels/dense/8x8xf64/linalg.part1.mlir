builtin.module {
  func.func public @dense(%arg0 : memref<8x8xf64> {"llvm.noalias"}, %arg1 : memref<8x8xf64> {"llvm.noalias"}, %arg2 : memref<8x8xf64> {"llvm.noalias"}, %arg3 : memref<8x8xf64> {"llvm.noalias"}) -> memref<8x8xf64> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    scf.for %arg4 = %c0 to %c8 step %c1 {
      scf.for %arg5 = %c0 to %c8 step %c1 {
        scf.for %arg6 = %c0 to %c8 step %c1 {
          %0 = memref.load %arg0[%arg4, %arg6] : memref<8x8xf64>
          %1 = memref.load %arg1[%arg6, %arg5] : memref<8x8xf64>
          %2 = memref.load %arg3[%arg4, %arg5] : memref<8x8xf64>
          %3 = arith.mulf %0, %1 fastmath<fast> : f64
          %4 = arith.addf %2, %3 fastmath<fast> : f64
          memref.store %4, %arg3[%arg4, %arg5] : memref<8x8xf64>
        }
      }
    }
    scf.for %arg4_1 = %c0 to %c8 step %c1 {
      scf.for %arg5_1 = %c0 to %c8 step %c1 {
        %5 = memref.load %arg2[%arg4_1, %arg5_1] : memref<8x8xf64>
        %6 = memref.load %arg3[%arg4_1, %arg5_1] : memref<8x8xf64>
        %7 = arith.addf %5, %6 fastmath<fast> : f64
        memref.store %7, %arg3[%arg4_1, %arg5_1] : memref<8x8xf64>
      }
    }
    scf.for %arg4_2 = %c0 to %c8 step %c1 {
      scf.for %arg5_2 = %c0 to %c8 step %c1 {
        %8 = memref.load %arg3[%arg4_2, %arg5_2] : memref<8x8xf64>
        %9 = arith.maxf %8, %cst fastmath<fast> : f64
        memref.store %9, %arg3[%arg4_2, %arg5_2] : memref<8x8xf64>
      }
    }
    func.return %arg3 : memref<8x8xf64>
  }
}

