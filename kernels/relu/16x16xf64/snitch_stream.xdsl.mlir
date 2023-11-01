riscv.assembly_section ".text" {
  riscv.directive ".globl" "relu"
  riscv.directive ".p2align" "2"
  riscv_func.func @relu(%X : !riscv.reg<a0>, %Y : !riscv.reg<a1>) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>

    %zero_int = riscv.get_register : () -> !riscv.reg<zero>
    %zero_float = riscv.fcvt.d.w %zero_int : (!riscv.reg<zero>) -> !riscv.freg<ft2>

    %stride_pattern = "snitch_stream.stride_pattern"() {"ub" = [#int<16>, #int<16>], "strides" = [#int<128>, #int<8>], "dm" = #int<31>} : () -> !snitch_stream.stride_pattern_type
    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern) {"dm" = #int<0>, "rank" = #int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %Y_stream = "snitch_stream.strided_write"(%Y_moved, %stride_pattern) {"dm" = #int<1>, "rank" = #int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.writable<!riscv.freg<ft1>>
    %count = riscv.li 256 : () -> !riscv.reg<>
    "snitch_stream.generic"(%count, %X_stream, %Y_stream) <{"operandSegmentSizes" = array<i32: 1, 1, 1>}> ({
    ^0(%x : !riscv.freg<ft0>):
        %res = riscv.fmax.d %x, %zero_float : (!riscv.freg<ft0>, !riscv.freg<ft2>) -> !riscv.freg<ft1>
        snitch_stream.yield %res : !riscv.freg<ft1>
    }) : (!riscv.reg<>, !stream.readable<!riscv.freg<ft0>>, !stream.writable<!riscv.freg<ft1>>) -> ()
    riscv_func.return
  }
}
