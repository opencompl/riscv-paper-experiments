memref.global constant @A : memref<{M}x{K}xf32>
memref.global constant @B : memref<{K}x{N}xf32>
memref.global constant @C : memref<{M}x{N}xf32>

func.func private @matmulf_{M}_{N}_{K}(%A: memref<{M}x{K}xf32>,
                                       %B: memref<{K}x{N}xf32>,
                                       %C: memref<{M}x{N}xf32>)

func.func private @diff(%lhs: memref<?x?xf32>,
                        %rhs: memref<?x?xf32>,
                        %eps: f32) -> i32

func.func @main() -> i32 {
    %a = memref.get_global @A : memref<{M}x{K}xf32>
    %b = memref.get_global @B : memref<{K}x{N}xf32>
    %c = memref.alloc() : memref<{M}x{N}xf32>
    func.call @matmulf_{M}_{N}_{K}(%a, %b, %c) : (memref<{M}x{K}xf32>, memref<{K}x{N}xf32>, memref<{M}x{N}xf32>) -> ()
    %c_ref = memref.get_global @C : memref<{M}x{N}xf32>
    %c_ref_dyn = memref.cast %c_ref : memref<{M}x{N}xf32> to memref<?x?xf32>
    %c_dyn = memref.cast %c : memref<{M}x{N}xf32> to memref<?x?xf32>
    %eps = arith.constant 0.0001 : f32 // should be proper eps
    %ndiff = func.call @diff(%c_dyn, %c_ref_dyn, %eps) : (memref<?x?xf32>, memref<?x?xf32>, f32) -> (i32)
    memref.dealloc %c : memref<{M}x{N}xf32>
    func.return %ndiff : i32
}
