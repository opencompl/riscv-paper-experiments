; ModuleID = 'main.ll'
source_filename = "main.ll"

declare i32 @snrt_global_core_idx()

declare i32 @snrt_global_core_num()

declare void @snrt_global_barrier()

declare void @echo_from_mlir()

define dso_local i32 @main() {
  call void @echo_from_mlir()
  %1 = call i32 @snrt_global_core_idx()
  %2 = call i32 @snrt_global_core_num()
  %3 = add i32 %1, %2
  call void @snrt_global_barrier()
  ret i32 0
}
