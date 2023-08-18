; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@A = external constant [16 x [8 x float]]
@B = external constant [16 x [8 x float]]
@A_PLUS_B = external constant [16 x [8 x float]]

declare i8* @malloc(i64)

declare void @free(i8*)

declare void @_mlir_memref_to_llvm_free(i8*)

declare i8* @_mlir_memref_to_llvm_alloc(i32)

declare void @addf(float*, float*)

declare i32 @memref_diff(float*, float*, float)

declare void @snrt_alloc_init()

declare i32 @snrt_cluster_compute_core_idx()

define i32 @main() {
  call void @snrt_alloc_init()
  %1 = call i32 @snrt_cluster_compute_core_idx()
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %16

3:                                                ; preds = %0
  %4 = call i8* @_mlir_memref_to_llvm_alloc(i32 ptrtoint (float* getelementptr (float, float* null, i32 128) to i32))
  %5 = bitcast i8* %4 to float*
  %6 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } undef, float* %5, 0
  %7 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %6, float* %5, 1
  %8 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %7, i32 0, 2
  %9 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %8, i32 16, 3, 0
  %10 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %9, i32 8, 3, 1
  %11 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %10, i32 8, 4, 0
  %12 = insertvalue { float*, float*, i32, [2 x i32], [2 x i32] } %11, i32 1, 4, 1
  %13 = getelementptr float, float* %5, i32 0
  call void @llvm.memcpy.p0f32.p0f32.i32(float* %13, float* getelementptr inbounds ([16 x [8 x float]], [16 x [8 x float]]* @A, i32 0, i32 0, i32 0), i32 mul (i32 ptrtoint (float* getelementptr (float, float* null, i32 1) to i32), i32 128), i1 false)
  call void @addf(float* %5, float* getelementptr inbounds ([16 x [8 x float]], [16 x [8 x float]]* @B, i32 0, i32 0, i32 0))
  %14 = call i32 @memref_diff(float* %5, float* getelementptr inbounds ([16 x [8 x float]], [16 x [8 x float]]* @A_PLUS_B, i32 0, i32 0, i32 0), float 0x3F1A36E2E0000000)
  %15 = bitcast float* %5 to i8*
  call void @_mlir_memref_to_llvm_free(i8* %15)
  br label %16

16:                                               ; preds = %3, %0
  %17 = phi i32 [ %14, %3 ], [ 0, %0 ]
  ret i32 %17
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0f32.p0f32.i32(float* noalias nocapture writeonly, float* noalias nocapture readonly, i32, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
