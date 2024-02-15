riscv.assembly_section ".text" {
  riscv.directive ".globl" "ddot"
  riscv.directive ".p2align" "2"

  riscv_func.func @ddot(
    %X : !riscv.reg<a0>,
    %Y : !riscv.reg<a1>,
    %G : !riscv.reg<a2>
  ) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %G_moved = riscv.mv %G : (!riscv.reg<a2>) -> !riscv.reg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [128], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 0>
    }> ({

    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>):
        %init = riscv.fld %G_moved, 0 : (!riscv.reg<>) -> !riscv.freg<>

        %c127 = riscv.li 127: () -> !riscv.reg<>
        %g = riscv_snitch.frep_outer %c127 iter_args(%acc = %init) -> (!riscv.freg<>) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res = riscv.fmadd.d %x, %y, %acc : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res : !riscv.freg<>
        }

        riscv.fsd %G_moved, %g, 0 : (!riscv.reg<>, !riscv.freg<>) -> ()
    }) : (!riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}
