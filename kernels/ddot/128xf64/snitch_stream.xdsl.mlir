riscv.assembly_section ".text" {
  riscv.directive ".globl" "ddot"
  riscv.directive ".p2align" "2"

  riscv_func.func @ddot(
    %X : !riscv.reg<a0>,
    %Y : !riscv.reg<a1>,
    %G : !riscv.reg<a2>
  ) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg
    %G_moved = riscv.mv %G : (!riscv.reg<a2>) -> !riscv.reg

    %c0 = riscv.get_register : !riscv.reg<zero>
    %init0 = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg

    "snitch_stream.streaming_region"(%X_moved, %Y_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [128], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 0>
    }> ({

    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>):
        %init1 = riscv.fmv.d %init0 : (!riscv.freg) -> !riscv.freg
        %init2 = riscv.fmv.d %init0 : (!riscv.freg) -> !riscv.freg
        %init3 = riscv.fmv.d %init0 : (!riscv.freg) -> !riscv.freg

        %c31 = riscv.li 31: !riscv.reg
        %g0, %g1, %g2, %g3 = riscv_snitch.frep_outer %c31 iter_args(%acc0 = %init0, %acc1 = %init1, %acc2 = %init2, %acc3 = %init3) -> (!riscv.freg, !riscv.freg, !riscv.freg, !riscv.freg) {
          %x0 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y0 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res0 = riscv.fmadd.d %x0, %y0, %acc0 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg) -> !riscv.freg
          %x1 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y1 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res1 = riscv.fmadd.d %x1, %y1, %acc1 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg) -> !riscv.freg
          %x2 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y2 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res2 = riscv.fmadd.d %x2, %y2, %acc2 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg) -> !riscv.freg
          %x3 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y3 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res3 = riscv.fmadd.d %x3, %y3, %acc3 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg) -> !riscv.freg
          riscv_snitch.frep_yield %res0, %res1, %res2, %res3 : !riscv.freg, !riscv.freg, !riscv.freg, !riscv.freg
        }

        %g4 = riscv.fadd.d %g0, %g1 : (!riscv.freg, !riscv.freg) -> !riscv.freg
        %g5 = riscv.fadd.d %g4, %g2 : (!riscv.freg, !riscv.freg) -> !riscv.freg
        %g = riscv.fadd.d %g5, %g3 : (!riscv.freg, !riscv.freg) -> !riscv.freg

        riscv.fsd %G_moved, %g, 0 : (!riscv.reg, !riscv.freg) -> ()
    }) : (!riscv.reg, !riscv.reg) -> ()

    riscv_func.return
  }
}
