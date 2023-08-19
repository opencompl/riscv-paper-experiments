memref.global constant @A : memref<13x26xf32>
memref.global constant @B : memref<13x26xf32>
memref.global constant @A_PLUS_B : memref<13x26xf32>

func.func private @addf(%A: memref<13x26xf32>{llvm.noalias},
                        %B: memref<13x26xf32>{llvm.noalias}) -> ()

func.func private @memref_diff(%A: memref<13x26xf32>{llvm.noalias},
                               %B: memref<13x26xf32>{llvm.noalias},
                               %eps: f32) -> i32

func.func private @snrt_cluster_compute_core_idx() -> (i32)

func.func @main() -> i32 {
    %test_core_id = arith.constant 0 : i32
    %core_id = func.call @snrt_cluster_compute_core_idx() : () -> (i32)
    %is_test_core = arith.cmpi eq, %core_id, %test_core_id : i32
    %ndiff = scf.if %is_test_core -> (i32) {
        %a_const = memref.get_global @A : memref<13x26xf32>
        %b_const = memref.get_global @B : memref<13x26xf32>
        %a = memref.alloc() : memref<13x26xf32>
        memref.copy %a_const, %a : memref<13x26xf32> to memref<13x26xf32>
        func.call @addf(%a, %b_const) : (memref<13x26xf32>, memref<13x26xf32>) -> ()
        %eps = arith.constant 0.001 : f32 // should be proper eps
        %reference_const = memref.get_global @A_PLUS_B : memref<13x26xf32>
        %ndiff = func.call @memref_diff(%a, %reference_const, %eps) : (memref<13x26xf32>, memref<13x26xf32>, f32) -> (i32)
        memref.dealloc %a : memref<13x26xf32>
        scf.yield %ndiff : i32
    } else {
        %0 = arith.constant 0 : i32
        scf.yield %0 : i32
    }
    func.return %ndiff : i32
}
