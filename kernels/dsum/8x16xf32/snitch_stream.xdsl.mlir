riscv.assembly_section ".text" {
  riscv.directive ".globl" "dsum"
  riscv.directive ".p2align" "2"
  riscv_func.func @dsum(%X : !riscv.reg<a0>, %Y : !riscv.reg<a1>, %Z : !riscv.reg<a2>) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %Z_moved = riscv.mv %Z : (!riscv.reg<a2>) -> !riscv.reg<>

    %zero_int = riscv.get_register : () -> !riscv.reg<zero>

    %stride_pattern = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<128>], "strides" = [#builtin.int<8>], "dm" = #builtin.int<31>} : () -> !snitch_stream.stride_pattern_type<1>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %Z_moved, %stride_pattern) <{"operandSegmentSizes" = array<i32: 2, 1, 1>}> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>, %Z_stream : !stream.writable<!riscv.freg<ft2>>):

      %c127 = riscv.li 127 : () -> !riscv.reg<>
      riscv_snitch.frep_outer %c127 {
        %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %z = riscv.fadd.d %x, %y : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<ft2>
        riscv_snitch.write %z to %Z_stream : !riscv.freg<ft2>
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !riscv.reg<>, !snitch_stream.stride_pattern_type<1>) -> ()

    riscv_func.return
  }
}
