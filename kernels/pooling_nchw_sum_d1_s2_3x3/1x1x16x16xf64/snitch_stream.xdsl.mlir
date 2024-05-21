riscv.assembly_section ".text" {
  riscv.directive ".globl" "pooling_nchw_sum_d1_s2_3x3"
  riscv.directive ".p2align" "2"
// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
riscv_func.func public @pooling_nchw_sum_d1_s2_3x3(
    %X: !riscv.reg<a0>,
    %Y: !riscv.reg<a1>
) -> () {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c7 = riscv.li 7 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>
    %c512 = riscv.li 512 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [7, 3, 3, 7], strides = [256, 128, 8, 16]>,
        #snitch_stream.stride_pattern<ub = [49], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 1, 1>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.writable<!riscv.freg<ft1>>):
      riscv_scf.for %y_i : !riscv.reg<> = %c0 to %c7 step %c1 {
        %init0 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init1 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init2 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init3 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init4 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init5 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
        %init6 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>

        %res0, %res1, %res2, %res3, %res4, %res5, %res6 = riscv_snitch.frep_outer %c8 iter_args(%acc0 = %init0, %acc1 = %init1, %acc2 = %init2, %acc3 = %init3, %acc4 = %init4, %acc5 = %init5, %acc6 = %init6) -> (!riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>) {
          %x0 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res0 = riscv.fadd.d %x0, %acc0 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          %x1 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res1 = riscv.fadd.d %x1, %acc1 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          %x2 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res2 = riscv.fadd.d %x2, %acc2 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          %x3 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res3 = riscv.fadd.d %x3, %acc3 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          %x4 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res4 = riscv.fadd.d %x4, %acc4 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          %x5 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res5 = riscv.fadd.d %x5, %acc5 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          %x6 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res6 = riscv.fadd.d %x6, %acc6 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res0, %res1, %res2, %res3, %res4, %res5, %res6 : !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>
        }

        %y0 = riscv.fmv.d %res0 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y0 to %Y_stream : !riscv.freg<ft1>
        %y1 = riscv.fmv.d %res1 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y1 to %Y_stream : !riscv.freg<ft1>
        %y2 = riscv.fmv.d %res2 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y2 to %Y_stream : !riscv.freg<ft1>
        %y3 = riscv.fmv.d %res3 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y3 to %Y_stream : !riscv.freg<ft1>
        %y4 = riscv.fmv.d %res4 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y4 to %Y_stream : !riscv.freg<ft1>
        %y5 = riscv.fmv.d %res5 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y5 to %Y_stream : !riscv.freg<ft1>
        %y6 = riscv.fmv.d %res6 : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y6 to %Y_stream : !riscv.freg<ft1>

        riscv_scf.yield
      }

    }) : (!riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}
