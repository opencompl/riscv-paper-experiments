module {
  func.func public @dsum(%arg0: memref<8x16xf64> {llvm.noalias}, %arg1: memref<8x16xf64> {llvm.noalias}, %arg2: memref<8x16xf64> {llvm.noalias}) -> memref<8x16xf64> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c1 = arith.constant 1 : index
    %c16 = arith.constant 16 : index
    %cst = arith.constant 0.000000e+00 : f64
    scf.for %arg3 = %c0 to %c8 step %c1 {
      scf.for %arg4 = %c0 to %c16 step %c1 {
        memref.store %cst, %arg2[%arg3, %arg4] : memref<8x16xf64>
      }
    }
    scf.for %arg3 = %c0 to %c8 step %c1 {
      scf.for %arg4 = %c0 to %c16 step %c1 {
        %0 = memref.load %arg0[%arg3, %arg4] : memref<8x16xf64>
        %1 = memref.load %arg1[%arg3, %arg4] : memref<8x16xf64>
        %2 = arith.addf %0, %1 : f64
        memref.store %2, %arg2[%arg3, %arg4] : memref<8x16xf64>
      }
    }
    return %arg2 : memref<8x16xf64>
  }
}
