riscv.assembly_section ".text" {
  riscv.directive ".globl" "dsum"
  riscv.directive ".p2align" "2"
  riscv_func.func @dsum(%X : !riscv.reg<a0>, %Y : !riscv.reg<a1>, %Z : !riscv.reg<a2>) {
    %0 = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %1 = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %2 = riscv.mv %Z : (!riscv.reg<a2>) -> !riscv.reg<>
    %3 = "snitch_stream.stride_pattern"() {"ub" = [#int<8>, #int<16>], "strides" = [#int<128>, #int<8>], "dm" = #int<31>} : () -> !snitch_stream.stride_pattern_type
    %4 = "snitch_stream.strided_read"(%0, %3) {"dm" = #int<0>, "rank" = #int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %5 = "snitch_stream.strided_read"(%1, %3) {"dm" = #int<1>, "rank" = #int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft1>>
    %6 = "snitch_stream.strided_write"(%2, %3) {"dm" = #int<2>, "rank" = #int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.writable<!riscv.freg<ft2>>
    %7 = riscv.li 128 : () -> !riscv.reg<>
    "snitch_stream.generic"(%7, %4, %5, %6) <{"operandSegmentSizes" = array<i32: 1, 2, 1>}> ({
    ^0(%x : !riscv.freg<ft0>, %y : !riscv.freg<ft1>):
      %r0 = riscv.fadd.d %x, %y : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<ft2>
      snitch_stream.yield %r0 : !riscv.freg<ft2>
    }) : (!riscv.reg<>, !stream.readable<!riscv.freg<ft0>>, !stream.readable<!riscv.freg<ft1>>, !stream.writable<!riscv.freg<ft2>>) -> ()
    riscv_func.return
  }
}
