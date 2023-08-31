func.func @diff(%lhs: memref<?x?xf32>,
                %rhs: memref<?x?xf32>,
                %eps: f32) -> i32 {
  %i0 = arith.constant 0 : index
  %i1 = arith.constant 1 : index
  %m = memref.dim %lhs, %i0 : memref<?x?xf32>
  %n = memref.dim %lhs, %i1 : memref<?x?xf32>
  %0 = arith.constant 0 : i32
  %ndiff =
  scf.for %m_i = %i0 to %m step %i1 
  iter_args(%m_partial = %0) -> (i32) {
    %n_all =
    scf.for %n_i = %i0 to %n step %i1
    iter_args(%n_partial = %0) -> (i32) {
      %va = memref.load %lhs[%m_i, %n_i] : memref<?x?xf32>
      %vb = memref.load %rhs[%m_i, %n_i] : memref<?x?xf32>
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