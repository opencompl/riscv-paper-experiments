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

    %stride_pattern = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<256>], "strides" = [#builtin.int<8>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type<1>

    "snitch_stream.streaming_region"(%Y_moved, %stride_pattern) <{"operandSegmentSizes" = array<i32: 0, 1, 1>}> ({
    ^bb0(%Y_stream : !stream.writable<!riscv.freg<ft0>>):
      %c255 = riscv.li 255 : () -> !riscv.reg<>
      riscv_snitch.frep_outer %c255 {
        %y = riscv.fmv.d %x : (!riscv.freg<>) -> !riscv.freg<ft0>
        riscv_snitch.write %y to %Y_stream : !riscv.freg<ft0>
      }
    }) : (!riscv.reg<>, !snitch_stream.stride_pattern_type<1>) -> ()

    riscv_func.return
  }
}
