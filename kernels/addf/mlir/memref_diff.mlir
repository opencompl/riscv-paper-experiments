func.func @memref_diff(%A: memref<26x13xf32>,
                       %B: memref<26x13xf32>,
                       %eps: f32) -> i32 {
  %i0 = arith.constant 0 : index
  %i1 = arith.constant 1 : index
  %m = memref.dim %A, %i0 : memref<26x13xf32>
  %n = memref.dim %A, %i1 : memref<26x13xf32>
  %0 = arith.constant 0 : i32
  %ndiff =
  scf.for %m_i = %i0 to %m step %i1 
  iter_args(%m_partial = %0) -> (i32) {
    %n_all =
    scf.for %n_i = %i0 to %n step %i1
    iter_args(%n_partial = %0) -> (i32) {
      %va = memref.load %A[%m_i, %n_i] : memref<26x13xf32>
      %vb = memref.load %B[%m_i, %n_i] : memref<26x13xf32>
      %diffs = arith.subf %va, %vb : f32
      %diffu = math.absf %diffs : f32
      %ne = arith.cmpf oge, %diffu, %eps : f32
      %ne_i32 = arith.extui %ne : i1 to i32
      %res = arith.addi %ne_i32, %n_partial : i32
      scf.yield %res : i32
    }
    %res = arith.addi %n_all, %m_partial : i32
    scf.yield %res : i32
  }
  return %ndiff : i32
}
