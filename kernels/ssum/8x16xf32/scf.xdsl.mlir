builtin.module {
  func.func public @ssum(%arg1: memref<128xf32>, %arg2: memref<128xf32>, %arg3: memref<128xf32>) {
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 512 : index
    %c1 = arith.constant 1 : index
    scf.for %arg4 = %c0 to %c64 step %c1 {
      %0 = memref.load %arg1[%arg4] : memref<128xf32>
      %1 = memref.load %arg2[%arg4] : memref<128xf32>
      %2 = arith.addf %0, %1 : f32
      memref.store %2, %arg3[%arg4] : memref<128xf32>
      scf.yield
    }
    func.return
  }
}

