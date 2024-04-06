builtin.module {
  func.func public @ddot(%arg0 : memref<128xf64>, %arg1 : memref<128xf64>, %arg2 : memref<f64>) -> memref<f64> {
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c1 = arith.constant 1 : index
    %0 = memref.load %arg2[] : memref<f64>
    %1 = scf.for %arg3 = %c0 to %c128 step %c1 iter_args(%arg4 = %0) -> (f64) {
      %2 = memref.load %arg0[%arg3] : memref<128xf64>
      %3 = memref.load %arg1[%arg3] : memref<128xf64>
      %4 = arith.mulf %2, %3 fastmath<fast> : f64
      %5 = arith.addf %arg4, %4 fastmath<fast> : f64
      scf.yield %5 : f64
    }
    memref.store %1, %arg2[] : memref<f64>
    func.return %arg2 : memref<f64>
  }
}

