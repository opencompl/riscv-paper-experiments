riscv.assembly_section ".text" {
  riscv.directive ".globl" "dsum"
  riscv.directive ".p2align" "2"
  riscv_func.func @dsum(%X : !riscv.reg<a0>, %Y : !riscv.reg<a1>, %Z : !riscv.reg<a2>) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %Z_moved = riscv.mv %Z : (!riscv.reg<a2>) -> !riscv.reg<>

    %zero_int = riscv.get_register : () -> !riscv.reg<zero>

    %stride_pattern = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<128>], "strides" = [#builtin.int<8>], "dm" = #builtin.int<31>} : () -> !snitch_stream.stride_pattern_type
    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern) {"dm" = #builtin.int<0>, "rank" = #builtin.int<1>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %Y_stream = "snitch_stream.strided_read"(%Y_moved, %stride_pattern) {"dm" = #builtin.int<1>, "rank" = #builtin.int<1>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft1>>
    %Z_stream = "snitch_stream.strided_write"(%Z_moved, %stride_pattern) {"dm" = #builtin.int<2>, "rank" = #builtin.int<1>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.writable<!riscv.freg<ft2>>

    %count = riscv.li 128 : () -> !riscv.reg<>
    "snitch_stream.generic"(%count, %X_stream, %Y_stream, %Z_stream) <{"operandSegmentSizes" = array<i32: 1, 2, 1>}> ({
    ^0(%x : !riscv.freg<ft0>, %y : !riscv.freg<ft1>):
        %res = riscv.fadd.d %x, %y : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<ft2>
        snitch_stream.yield %res : !riscv.freg<ft2>
    }) : (!riscv.reg<>, !stream.readable<!riscv.freg<ft0>>, !stream.readable<!riscv.freg<ft1>>, !stream.writable<!riscv.freg<ft2>>) -> ()
    riscv_func.return
  }
}
