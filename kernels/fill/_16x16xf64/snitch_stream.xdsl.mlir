riscv.assembly_section ".text" {
  riscv.directive ".globl" "fill"
  riscv.directive ".p2align" "2"

  // y[ 16 x 16 ]
  riscv_func.func @fill(
    %X : !riscv.freg<fa0>,
    %Y : !riscv.reg<a0>
  ) {
    %X_moved = riscv.fmv.d %X : (!riscv.freg<fa0>) -> !riscv.freg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a0>) -> !riscv.reg<>

    %x = riscv.fmv.d %X_moved : (!riscv.freg<>) -> !riscv.freg<>

    "snitch_stream.streaming_region"(%Y_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [256], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 0, 1>
    }> ({
    ^bb0(%Y_stream : !stream.writable<!riscv.freg<ft0>>):
      %c255 = riscv.li 255 : !riscv.reg<>
      riscv_snitch.frep_outer %c255 {
        %y = riscv.fmv.d %x : (!riscv.freg<>) -> !riscv.freg<ft0>
        riscv_snitch.write %y to %Y_stream : !riscv.freg<ft0>
      }
    }) : (!riscv.reg<>) -> ()

    riscv_func.return
  }
}
