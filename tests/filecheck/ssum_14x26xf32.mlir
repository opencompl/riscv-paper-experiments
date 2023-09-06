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
// CHECK-NEXT:     mv s10, a0
// CHECK-NEXT:     mv s11, a1
// CHECK-NEXT:     mv t3, a2
// CHECK-NEXT:     li t6, 0
// CHECK-NEXT:     li s8, 14
// CHECK-NEXT:     li t4, 1
// CHECK-NEXT:     li t5, 26
// CHECK-NEXT:     mv s9, t6
// CHECK-NEXT: scf_cond_0_for:
// CHECK-NEXT:     bge s9, s8, scf_body_end_0_for
// CHECK-NEXT: scf_body_0_for:
// CHECK-NEXT:     mv s7, t6
// CHECK-NEXT: scf_cond_1_for:
// CHECK-NEXT:     bge s7, t5, scf_body_end_1_for
// CHECK-NEXT: scf_body_1_for:
// CHECK-NEXT:     li s6, 26
// CHECK-NEXT:     mul s6, s6, s9
// CHECK-NEXT:     add s6, s6, s7
// CHECK-NEXT:     li s5, 4
// CHECK-NEXT:     mul s6, s6, s5                               # multiply by element size
// CHECK-NEXT:     add s6, s10, s6
// CHECK-NEXT:     flw ft11, 0(s6)                              # load value from memref of shape (14, 26)
// CHECK-NEXT:     li s6, 26
// CHECK-NEXT:     mul s6, s6, s9
// CHECK-NEXT:     add s6, s6, s7
// CHECK-NEXT:     li s5, 4
// CHECK-NEXT:     mul s6, s6, s5                               # multiply by element size
// CHECK-NEXT:     add s6, s11, s6
// CHECK-NEXT:     flw ft10, 0(s6)                              # load value from memref of shape (14, 26)
// CHECK-NEXT:     fadd.s ft11, ft11, ft10
// CHECK-NEXT:     li s6, 26
// CHECK-NEXT:     mul s6, s6, s9
// CHECK-NEXT:     add s6, s6, s7
// CHECK-NEXT:     li s5, 4
// CHECK-NEXT:     mul s6, s6, s5                               # multiply by element size
// CHECK-NEXT:     add s6, t3, s6
// CHECK-NEXT:     fsw ft11, 0(s6)                              # store float value to memref of shape (14, 26)
// CHECK-NEXT:     add s7, s7, t4
// CHECK-NEXT:     blt s7, t5, scf_body_1_for
// CHECK-NEXT: scf_body_end_1_for:
// CHECK-NEXT:     add s9, s9, t4
// CHECK-NEXT:     blt s9, s8, scf_body_0_for
// CHECK-NEXT: scf_body_end_0_for:
// CHECK-NEXT:     ret
