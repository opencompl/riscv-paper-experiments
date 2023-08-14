memref.global constant @A : memref<10x10xf32>
memref.global constant @B : memref<10x10xf32>
memref.global constant @C : memref<10x10xf32>

func.func private @matmulf_10_10_10(%A: memref<10x10xf32>,
                                       %B: memref<10x10xf32>,
                                       %C: memref<10x10xf32>)

func.func private @diff(%lhs: memref<?x?xf32>,
                        %rhs: memref<?x?xf32>,
                        %eps: f32) -> i32

func.func @main() -> i32 {
    %a = memref.get_global @A : memref<10x10xf32>
    %b = memref.get_global @B : memref<10x10xf32>
    %c = memref.alloc() : memref<10x10xf32>
    func.call @matmulf_10_10_10(%a, %b, %c) : (memref<10x10xf32>, memref<10x10xf32>, memref<10x10xf32>) -> ()
    %c_ref = memref.get_global @C : memref<10x10xf32>
    %c_ref_dyn = memref.cast %c_ref : memref<10x10xf32> to memref<?x?xf32>
    %c_dyn = memref.cast %c : memref<10x10xf32> to memref<?x?xf32>
    %eps = arith.constant 0.0001 : f32 // should be proper eps
    %ndiff = func.call @diff(%c_dyn, %c_ref_dyn, %eps) : (memref<?x?xf32>, memref<?x?xf32>, f32) -> (i32)
    memref.dealloc %c : memref<10x10xf32>
    func.return %ndiff : i32
}

