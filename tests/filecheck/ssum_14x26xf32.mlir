// RUN: xdsl-opt -p "convert-func-to-riscv-func,convert-memref-to-riscv,convert-arith-to-riscv,convert-scf-to-riscv-scf,dce,reconcile-unrealized-casts,canonicalize,riscv-allocate-registers{allocation_strategy=LivenessBlockNaive},canonicalize,lower-riscv-func{insert_exit_syscall=true},lower-riscv-scf-to-labels" -t riscv-asm %s | filecheck %s

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

// CHECK: .text
// CHECK-NEXT: .globl ssum
// CHECK-NEXT: .p2align 2
// CHECK-NEXT: ssum:
// CHECK-NEXT:     mv t5, a0
// CHECK-NEXT:     mv t4, a1
// CHECK-NEXT:     mv t3, a2
// CHECK-NEXT:     li t0, 0
// CHECK-NEXT:     li t2, 1
// CHECK-NEXT:     li t1, 26
// CHECK-NEXT:     li a3, 0
// CHECK-NEXT:     li a4, 364
// CHECK-NEXT:     li a5, 26
// CHECK-NEXT:     mv t6, a3
// CHECK-NEXT: scf_cond_0_for:
// CHECK-NEXT:     bge t6, a4, scf_body_end_0_for
// CHECK-NEXT: scf_body_0_for:
// CHECK-NEXT:     mv a6, t0
// CHECK-NEXT: scf_cond_1_for:
// CHECK-NEXT:     bge a6, t1, scf_body_end_1_for
// CHECK-NEXT: scf_body_1_for:
// CHECK-NEXT:     add a7, t6, a6
// CHECK-NEXT:     li j0, 4
// CHECK-NEXT:     mul a7, a7, j0                               # multiply by element size
// CHECK-NEXT:     add a7, t5, a7
// CHECK-NEXT:     flw ft0, 0(a7)                               # load value from memref of shape (14, 26)
// CHECK-NEXT:     add a7, t6, a6
// CHECK-NEXT:     li j0, 4
// CHECK-NEXT:     mul a7, a7, j0                               # multiply by element size
// CHECK-NEXT:     add a7, t4, a7
// CHECK-NEXT:     flw ft1, 0(a7)                               # load value from memref of shape (14, 26)
// CHECK-NEXT:     fadd.s ft0, ft0, ft1
// CHECK-NEXT:     add a7, t6, a6
// CHECK-NEXT:     li j0, 4
// CHECK-NEXT:     mul a7, a7, j0                               # multiply by element size
// CHECK-NEXT:     add a7, t3, a7
// CHECK-NEXT:     fsw ft0, 0(a7)                               # store float value to memref of shape (14, 26)
// CHECK-NEXT:     add a6, a6, t2
// CHECK-NEXT:     blt a6, t1, scf_body_1_for
// CHECK-NEXT: scf_body_end_1_for:
// CHECK-NEXT:     add t6, t6, a5
// CHECK-NEXT:     blt t6, a4, scf_body_0_for
// CHECK-NEXT: scf_body_end_0_for:
// CHECK-NEXT:     ret
