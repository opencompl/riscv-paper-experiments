builtin.module {
  func.func public @fill(%arg0 : f64, %arg1 : memref<16x16xf64> {"llvm.noalias"}) -> memref<16x16xf64> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    scf.for %arg2 = %c0 to %c16 step %c1 {
      scf.for %arg3 = %c0 to %c16 step %c1 {
        memref.store %arg0, %arg1[%arg2, %arg3] : memref<16x16xf64>
      }
    }
    func.return %arg1 : memref<16x16xf64>
  }
}

