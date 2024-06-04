riscv.assembly_section ".text" {
  riscv.directive ".globl" "conv_2d_nchw_fchw_d1_s1_3x3"
  riscv.directive ".p2align" "2"
// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
riscv_func.func public @conv_2d_nchw_fchw_d1_s1_3x3(
    %X: !riscv.reg<a0>,
    %Y: !riscv.reg<a1>,
    %Z: !riscv.reg<a2>
) -> () {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %Z_moved = riscv.mv %Z : (!riscv.reg<a2>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c6 = riscv.li 6 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %Z_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [6, 3, 3, 6], strides = [64, 64, 8, 8]>,
        #snitch_stream.stride_pattern<ub = [6, 3, 3, 6], strides = [0, 24, 8, 0]>,
        #snitch_stream.stride_pattern<ub = [36], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 1>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>, %Z_stream : !stream.writable<!riscv.freg<ft2>>):
      riscv_scf.for %z_i : !riscv.reg<> = %c0 to %c6 step %c1 {
        %init0 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init1 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init2 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init3 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init4 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init5 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>

        %res0, %res1, %res2, %res3, %res4, %res5 = riscv_snitch.frep_outer %c8 iter_args(%acc0 = %init0, %acc1 = %init1, %acc2 = %init2, %acc3 = %init3, %acc4 = %init4, %acc5 = %init5) -> (!riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>) {
          %x0 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y0 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res0 = riscv.fmadd.d %x0, %y0, %acc0 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x1 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y1 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res1 = riscv.fmadd.d %x1, %y1, %acc1 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x2 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y2 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res2 = riscv.fmadd.d %x2, %y2, %acc2 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x3 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y3 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res3 = riscv.fmadd.d %x3, %y3, %acc3 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x4 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y4 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res4 = riscv.fmadd.d %x4, %y4, %acc4 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x5 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y5 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res5 = riscv.fmadd.d %x5, %y5, %acc5 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res0, %res1, %res2, %res3, %res4, %res5 : !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>
        }

        %z0 = riscv.fmv.d %res0 : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z0 to %Z_stream : !riscv.freg<ft2>
        %z1 = riscv.fmv.d %res1 : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z1 to %Z_stream : !riscv.freg<ft2>
        %z2 = riscv.fmv.d %res2 : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z2 to %Z_stream : !riscv.freg<ft2>
        %z3 = riscv.fmv.d %res3 : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z3 to %Z_stream : !riscv.freg<ft2>
        %z4 = riscv.fmv.d %res4 : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z4 to %Z_stream : !riscv.freg<ft2>
        %z5 = riscv.fmv.d %res5 : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z5 to %Z_stream : !riscv.freg<ft2>

        riscv_scf.yield
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}