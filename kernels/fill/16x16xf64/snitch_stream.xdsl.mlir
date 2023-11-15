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

    %x = riscv.fmv.d %X_moved : (!riscv.freg<>) -> !riscv.freg<ft3>

    %stride_pattern = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<256>], "strides" = [#builtin.int<8>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type

    %Y_stream = "snitch_stream.strided_write"(%Y_moved, %stride_pattern) {"dm" = #builtin.int<0>, "rank" = #builtin.int<1>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.writable<!riscv.freg<ft0>>

    %count = riscv.li 256 : () -> !riscv.reg<>
    "snitch_stream.generic"(%count, %Y_stream) <{"operandSegmentSizes" = array<i32: 1, 0, 1>}> ({
    ^0():
        %res = riscv.fmv.d %x : (!riscv.freg<ft3>) -> !riscv.freg<ft0>
        snitch_stream.yield %res : !riscv.freg<ft0>
    }) : (!riscv.reg<>, !stream.writable<!riscv.freg<ft0>>) -> ()

    riscv_func.return
  }
}
