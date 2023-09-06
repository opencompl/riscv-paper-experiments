// RUN: xdsl-opt -p "convert-func-to-riscv-func,convert-memref-to-riscv,convert-arith-to-riscv,convert-scf-to-riscv-scf,dce,reconcile-unrealized-casts,canonicalize,riscv-allocate-registers{allocation_strategy=BlockNaive},canonicalize,lower-riscv-func{insert_exit_syscall=true},lower-riscv-scf-to-labels" -t riscv-asm %s | filecheck %s

"builtin.module"() ({
  "func.func"() ({
  ^bb0(%arg0: memref<14x26xf32>, %arg1: memref<14x26xf32>, %arg2: memref<14x26xf32>):
    %0 = "arith.constant"() {value = 0 : index} : () -> index
    %1 = "arith.constant"() {value = 14 : index} : () -> index
    %2 = "arith.constant"() {value = 1 : index} : () -> index
    %3 = "arith.constant"() {value = 26 : index} : () -> index
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg3: index):
      "scf.for"(%0, %3, %2) ({
      ^bb0(%arg4: index):
        %4 = "memref.load"(%arg0, %arg3, %arg4) : (memref<14x26xf32>, index, index) -> f32
        %5 = "memref.load"(%arg1, %arg3, %arg4) : (memref<14x26xf32>, index, index) -> f32
        %6 = "arith.addf"(%4, %5) {fastmath = #arith.fastmath<none>} : (f32, f32) -> f32
        "memref.store"(%6, %arg2, %arg3, %arg4) : (f32, memref<14x26xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) {function_type = (memref<14x26xf32>, memref<14x26xf32>, memref<14x26xf32>) -> (), sym_name = "ssum", sym_visibility = "public"} : () -> ()
}) : () -> ()

// CHECK:ssum:
// CHECK-NEXT:    mv s1, a0
// CHECK-NEXT:    mv s2, a1
// CHECK-NEXT:    mv s3, a2
// CHECK-NEXT:    li s4, 14
// CHECK-NEXT:    li s5, 1
// CHECK-NEXT:    li s6, 26
// CHECK-NEXT:    mv t6, zero
// CHECK-NEXT:scf_cond_0_for:
// CHECK-NEXT:    bge t6, s4, scf_body_end_0_for
// CHECK-NEXT:scf_body_0_for:
// CHECK-NEXT:    mv t5, zero
// CHECK-NEXT:scf_cond_1_for:
// CHECK-NEXT:    bge t5, s6, scf_body_end_1_for
// CHECK-NEXT:scf_body_1_for:
// CHECK-NEXT:    li s7, 26
// CHECK-NEXT:    mul s8, s7, t6
// CHECK-NEXT:    add s9, s8, t5
// CHECK-NEXT:    li s10, 4
// CHECK-NEXT:    mul s11, s9, s10                             # multiply by element size
// CHECK-NEXT:    add a0, s1, s11
// CHECK-NEXT:    flw ft9, 0(a0)                               # load value from memref of shape (14, 26)
// CHECK-NEXT:    li a1, 26
// CHECK-NEXT:    mul a2, a1, t6
// CHECK-NEXT:    add a3, a2, t5
// CHECK-NEXT:    li a4, 4
// CHECK-NEXT:    mul a5, a3, a4                               # multiply by element size
// CHECK-NEXT:    add a6, s2, a5
// CHECK-NEXT:    flw ft10, 0(a6)                              # load value from memref of shape (14, 26)
// CHECK-NEXT:    fadd.s ft11, ft9, ft10
// CHECK-NEXT:    li a7, 26
// CHECK-NEXT:    mul t0, a7, t6
// CHECK-NEXT:    add t1, t0, t5
// CHECK-NEXT:    li t2, 4
// CHECK-NEXT:    mul t3, t1, t2                               # multiply by element size
// CHECK-NEXT:    add t4, s3, t3
// CHECK-NEXT:    fsw ft11, 0(t4)                              # store float value to memref of shape (14, 26)
// CHECK-NEXT:    add t5, t5, s5
// CHECK-NEXT:    blt t5, s6, scf_body_1_for
// CHECK-NEXT:scf_body_end_1_for:
// CHECK-NEXT:    add t6, t6, s5
// CHECK-NEXT:    blt t6, s4, scf_body_0_for
// CHECK-NEXT:scf_body_end_0_for:
// CHECK-NEXT:    ret
