module {
  func.func public @ddot(%arg0: memref<128xf64> {llvm.noalias}, %arg1: memref<128xf64> {llvm.noalias}, %arg2: memref<f64> {llvm.noalias}) -> memref<f64> {
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    memref.store %cst, %arg2[] : memref<f64>
    scf.for %arg3 = %c0 to %c128 step %c1 {
      %0 = memref.load %arg0[%arg3] : memref<128xf64>
      %1 = memref.load %arg1[%arg3] : memref<128xf64>
      %2 = memref.load %arg2[] : memref<f64>
      %3 = arith.mulf %0, %1 : f64
      %4 = arith.addf %2, %3 : f64
      memref.store %4, %arg2[] : memref<f64>
    }
    return %arg2 : memref<f64>
  }
}
