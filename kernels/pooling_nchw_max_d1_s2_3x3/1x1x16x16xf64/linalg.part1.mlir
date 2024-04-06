builtin.module {
  func.func public @pooling_nchw_max_d1_s2_3x3(%arg0 : memref<1x1x16x16xf64> {"llvm.noalias"}, %arg1 : memref<1x1x7x7xf64> {"llvm.noalias"}) -> memref<1x1x7x7xf64> {
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c7 = arith.constant 7 : index
    %c3 = arith.constant 3 : index
    scf.for %arg2 = %c0 to %c7 step %c1 {
      scf.for %arg3 = %c0 to %c7 step %c1 {
        scf.for %arg4 = %c0 to %c3 step %c1 {
          scf.for %arg5 = %c0 to %c3 step %c1 {
            %0 = arith.muli %arg2, %c2 : index
            %1 = arith.addi %0, %arg4 : index
            %2 = arith.muli %arg3, %c2 : index
            %3 = arith.addi %2, %arg5 : index
            %4 = memref.load %arg0[%c0, %c0, %1, %3] : memref<1x1x16x16xf64>
            %5 = memref.load %arg1[%c0, %c0, %arg2, %arg3] : memref<1x1x7x7xf64>
            %6 = arith.maxf %5, %4 fastmath<fast> : f64
            memref.store %6, %arg1[%c0, %c0, %arg2, %arg3] : memref<1x1x7x7xf64>
          }
        }
      }
    }
    func.return %arg1 : memref<1x1x7x7xf64>
  }
}

