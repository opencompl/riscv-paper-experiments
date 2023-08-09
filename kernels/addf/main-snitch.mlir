memref.global constant @A : memref<16x8xf32>
memref.global constant @B : memref<16x8xf32>
memref.global constant @A_PLUS_B : memref<16x8xf32>

func.func private @addf(%A: memref<16x8xf32>,
                        %B: memref<16x8xf32>) -> ()

func.func private @memref_diff(%A: memref<16x8xf32>,
                               %B: memref<16x8xf32>,
                               %eps: f32) -> i32

func.func private @snrt_alloc_init() -> ()
func.func private @snrt_cluster_compute_core_idx() -> (i32)

func.func @main() -> i32 {
    %test_core_id = arith.constant 0 : i32
    // FIXME this should be either emitted by xDSL or
    // made implicit via start.S
    func.call @snrt_alloc_init() : () -> ()
    // FIXME this should be either emitted by xDSL
    %core_id = func.call @snrt_cluster_compute_core_idx() : () -> (i32)
    %is_test_core = arith.cmpi eq, %core_id, %test_core_id : i32
    %ndiff = scf.if %is_test_core -> (i32) {
        %a_const = memref.get_global @A : memref<16x8xf32>
        %b_const = memref.get_global @B : memref<16x8xf32>
        %a = memref.alloc() : memref<16x8xf32>
        memref.copy %a_const, %a : memref<16x8xf32> to memref<16x8xf32>
        func.call @addf(%a, %b_const) : (memref<16x8xf32>, memref<16x8xf32>) -> ()
        %eps = arith.constant 0.0001 : f32 // should be proper eps
        %reference_const = memref.get_global @A_PLUS_B : memref<16x8xf32>
        %ndiff = func.call @memref_diff(%a, %reference_const, %eps) : (memref<16x8xf32>, memref<16x8xf32>, f32) -> (i32)
        memref.dealloc %a : memref<16x8xf32>
        scf.yield %ndiff : i32
    } else {
        %0 = arith.constant 0 : i32
        scf.yield %0 : i32
    }
    func.return %ndiff : i32
}