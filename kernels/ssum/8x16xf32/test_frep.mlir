module {
  // Declare external LLVM functions
  llvm.func @snrt_ssr_loop_1d(i32, i32, i32) -> ()
  llvm.func @snrt_ssr_read(!llvm.ptr<f32>, i32, i32, i32, i32) -> ()
  llvm.func @snrt_ssr_write(!llvm.ptr<f32>, i32, i32, i32, i32) -> ()
  llvm.func @snrt_ssr_enable() -> ()
  llvm.func @snrt_ssr_disable() -> ()
  llvm.func @snrt_fpu_fence() -> ()

  llvm.func @ssum(%x: !llvm.ptr<f32>, %y: !llvm.ptr<f32>, %z: !llvm.ptr<f32>) {

    %c0 = arith.constant 0 : i32
    %c1 = arith.constant 1 : i32
    %c2 = arith.constant 2 : i32
    %niter = arith.constant 128 : i32
    %minus_1 = arith.constant -1 : i32
    %niter_minus_1 = arith.addi %niter, %minus_1 : i32

    // External function calls
    %mem_size = arith.constant 512 : i32
    llvm.call @snrt_ssr_loop_1d(%niter, %niter_minus_1, %mem_size) : (i32, i32, i32) -> ()

    llvm.call @snrt_ssr_read(%x, %niter, %c0, %c0, %c0) : (!llvm.ptr<f32>, i32, i32, i32, i32) -> ()
    llvm.call @snrt_ssr_read(%y, %niter, %c1, %c0, %c0) : (!llvm.ptr<f32>, i32, i32, i32, i32) -> ()
    llvm.call @snrt_ssr_write(%z, %niter, %c2, %c0, %c0) : (!llvm.ptr<f32>, i32, i32, i32, i32) -> ()

    llvm.call @snrt_ssr_enable() : () -> ()

    // Inline assembly
    llvm.inline_asm has_side_effects "frep.o $0, 1, 0, 0 \n vfadd.s ft2, ft0, ft1", "r" %niter_minus_1 : (i32) -> ()

    llvm.call @snrt_fpu_fence() : () -> ()
    llvm.call @snrt_ssr_disable() : () -> ()

    llvm.return
  }
}
