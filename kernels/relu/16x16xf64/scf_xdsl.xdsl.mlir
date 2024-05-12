module {
  func.func public @relu(%arg0: memref<16x16xf64> {llvm.noalias}, %arg1: memref<16x16xf64> {llvm.noalias}) -> memref<16x16xf64> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    scf.for %arg2 = %c0 to %c16 step %c1 {
      scf.for %arg3 = %c0 to %c16 step %c1 {
        memref.store %cst, %arg1[%arg2, %arg3] : memref<16x16xf64>
      }
    }
    scf.for %arg2 = %c0 to %c16 step %c1 {
      scf.for %arg3 = %c0 to %c16 step %c1 {
        %0 = memref.load %arg0[%arg2, %arg3] : memref<16x16xf64>
        %1 = arith.maxf %0, %cst : f64
        memref.store %1, %arg1[%arg2, %arg3] : memref<16x16xf64>
      }
    }
    return %arg1 : memref<16x16xf64>
  }
}
