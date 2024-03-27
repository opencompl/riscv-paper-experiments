riscv.assembly_section ".text" {
  riscv.directive ".globl" "matmul"
  riscv.directive ".p2align" "2"

// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
  riscv_func.func @matmul(
    %X : !riscv.reg<a0>,
    %Y : !riscv.reg<a1>,
    %G : !riscv.reg<a2>
  ) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %G_moved = riscv.mv %G : (!riscv.reg<a2>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>
    %c63 = riscv.li 63 : () -> !riscv.reg<>

    %zero = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %G_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [8, 8, 8], strides = [64, 0, 8]>,
        #snitch_stream.stride_pattern<ub = [8, 8, 8], strides = [0, 8, 64]>,
        #snitch_stream.stride_pattern<ub = [8, 8], strides = [64, 8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 1>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>, %G_stream : !stream.writable<!riscv.freg<ft2>>):
      riscv_snitch.frep_outer %c63 {
        %init = riscv.fmv.d %zero : (!riscv.freg<>) -> !riscv.freg<>

        %x0 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y0 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc00 = riscv.fmadd.d %x0, %y0, %init : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x1 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y1 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc10 = riscv.fmadd.d %x1, %y1, %init : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x2 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y2 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc20 = riscv.fmadd.d %x2, %y2, %init : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x3 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y3 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc30 = riscv.fmadd.d %x3, %y3, %init : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x4 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y4 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc01 = riscv.fmadd.d %x4, %y4, %acc00 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x5 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y5 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc11 = riscv.fmadd.d %x5, %y5, %acc10 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x6 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y6 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc21 = riscv.fmadd.d %x6, %y6, %acc20 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
        %x7 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y7 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %acc31 = riscv.fmadd.d %x7, %y7, %acc30 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>

        %acc4 = riscv.fadd.d %acc01, %acc11 : (!riscv.freg<>, !riscv.freg<>) -> !riscv.freg<>
        %acc5 = riscv.fadd.d %acc4, %acc21 : (!riscv.freg<>, !riscv.freg<>) -> !riscv.freg<>
        %res = riscv.fadd.d %acc5, %acc31 : (!riscv.freg<>, !riscv.freg<>) -> !riscv.freg<>

        %g_moved = riscv.fmv.d %res : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %g_moved to %G_stream : !riscv.freg<ft2>

        riscv_snitch.frep_yield
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}
