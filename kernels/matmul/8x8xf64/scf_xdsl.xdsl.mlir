module {
  func.func public @matmul(%arg0: memref<8x8xf64> {llvm.noalias}, %arg1: memref<8x8xf64> {llvm.noalias}, %arg2: memref<8x8xf64> {llvm.noalias}) -> memref<8x8xf64> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c8 step %c1 {
      scf.for %arg4 = %c0 to %c8 step %c1 {
        scf.for %arg5 = %c0 to %c8 step %c1 {
          %0 = memref.load %arg0[%arg3, %arg5] : memref<8x8xf64>
          %1 = memref.load %arg1[%arg5, %arg4] : memref<8x8xf64>
          %2 = memref.load %arg2[%arg3, %arg4] : memref<8x8xf64>
          %3 = arith.mulf %0, %1 : f64
          %4 = arith.addf %2, %3 : f64
          memref.store %4, %arg2[%arg3, %arg4] : memref<8x8xf64>
        }
      }
    }
    return %arg2 : memref<8x8xf64>
  }
}
