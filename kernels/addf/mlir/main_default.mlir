memref.global constant @A : memref<16x8xf32>
memref.global constant @B : memref<16x8xf32>
memref.global constant @A_PLUS_B : memref<16x8xf32>

func.func private @addf(%A: memref<16x8xf32>,
                        %B: memref<16x8xf32>) -> ()

func.func private @memref_diff(%A: memref<16x8xf32>,
                               %B: memref<16x8xf32>,
                               %eps: f32) -> i32

func.func @main() -> i32 {
    %a_const = memref.get_global @A : memref<16x8xf32>
    %b_const = memref.get_global @B : memref<16x8xf32>
    %a = memref.alloc() : memref<16x8xf32>
    memref.copy %a_const, %a : memref<16x8xf32> to memref<16x8xf32>
    func.call @addf(%a, %b_const) : (memref<16x8xf32>, memref<16x8xf32>) -> ()
    %reference_const = memref.get_global @A_PLUS_B : memref<16x8xf32>
    %eps = arith.constant 0.0001 : f32 // should be proper eps
    %ndiff = func.call @memref_diff(%a, %reference_const, %eps) : (memref<16x8xf32>, memref<16x8xf32>, f32) -> (i32)
    memref.dealloc %a : memref<16x8xf32>
    func.return %ndiff : i32
}