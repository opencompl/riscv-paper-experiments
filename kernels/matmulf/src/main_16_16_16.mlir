memref.global constant @A : memref<16x16xf32>
memref.global constant @B : memref<16x16xf32>
memref.global constant @C : memref<16x16xf32>

func.func private @matmulf_16_16_16(%A: memref<16x16xf32>,
                                       %B: memref<16x16xf32>,
                                       %C: memref<16x16xf32>)

func.func private @diff(%lhs: memref<?x?xf32>,
                        %rhs: memref<?x?xf32>,
                        %eps: f32) -> i32

func.func @main() -> i32 {
    %a = memref.get_global @A : memref<16x16xf32>
    %b = memref.get_global @B : memref<16x16xf32>
    %c = memref.alloc() : memref<16x16xf32>
    func.call @matmulf_16_16_16(%a, %b, %c) : (memref<16x16xf32>, memref<16x16xf32>, memref<16x16xf32>) -> ()
    %c_ref = memref.get_global @C : memref<16x16xf32>
    %c_ref_dyn = memref.cast %c_ref : memref<16x16xf32> to memref<?x?xf32>
    %c_dyn = memref.cast %c : memref<16x16xf32> to memref<?x?xf32>
    %eps = arith.constant 0.0001 : f32 // should be proper eps
    %ndiff = func.call @diff(%c_dyn, %c_ref_dyn, %eps) : (memref<?x?xf32>, memref<?x?xf32>, f32) -> (i32)
    memref.dealloc %c : memref<16x16xf32>
    func.return %ndiff : i32
}
