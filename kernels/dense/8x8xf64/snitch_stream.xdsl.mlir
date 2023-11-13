riscv.assembly_section ".text" {
  riscv.directive ".globl" "relu"
  riscv.directive ".p2align" "2"

  // * Inputs:  x[ M x K ]
  // * Weights: w[ K x N ]
  // * Biases:  b[ M x N ]
  // * Outputs: y[ M x N ]
  riscv_func.func @dense(
    %X : !riscv.reg<a0>,
    %W : !riscv.reg<a1>,
    %B : !riscv.reg<a2>,
    %Y : !riscv.reg<a3>
  ) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %W_moved = riscv.mv %W : (!riscv.reg<a1>) -> !riscv.reg<>
    %B_moved = riscv.mv %B : (!riscv.reg<a2>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a3>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<ft4>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<8>, #builtin.int<0>, #builtin.int<64>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type

    %stride_pattern_1 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<64>, #builtin.int<8>, #builtin.int<0>], "dm" = #builtin.int<1>} : () -> !snitch_stream.stride_pattern_type

    %stride_pattern_2 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<8>, #builtin.int<64>], "dm" = #builtin.int<2>} : () -> !snitch_stream.stride_pattern_type

    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern_0) {"dm" = #builtin.int<0>, "rank" = #builtin.int<3>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %W_stream = "snitch_stream.strided_read"(%W_moved, %stride_pattern_1) {"dm" = #builtin.int<1>, "rank" = #builtin.int<3>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %B_stream = "snitch_stream.strided_read"(%B_moved, %stride_pattern_2) {"dm" = #builtin.int<2>, "rank" = #builtin.int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.writable<!riscv.freg<ft1>>


    // for (uint32_t m = 0; m < M; ++m) {
        // for (uint32_t n = 0; n < N; ++n) {

    riscv_scf.for %m = %c0 to %c8 step %c1 {
      riscv_scf.for %n = %c0 to %c8 step %c1 {
        %c = riscv.fmv.d %zero_float : !riscv.freg<ft3> -> !riscv.freg<ft4>

        "snitch_stream.generic"(%c8, %X_stream, %W_stream, %B_stream) <{"operandSegmentSizes" = array<i32: 1, 3, 0>}> ({
        ^0(%x : !riscv.freg<ft0>, %w : !riscv.freg<ft1>, %b : !riscv.freg<ft2>):
          %y = riscv.fmadd.d %x, %zero_float : (!riscv.freg<ft0>, !riscv.freg<ft3>) -> !riscv.freg<ft1>
          snitch_stream.yield %res : !riscv.freg<ft1>
        }) : (!riscv.reg<>, !stream.readable<!riscv.freg<ft0>>, !stream.writable<!riscv.freg<ft1>>) -> ()

        riscv_scf.yield
      }
      riscv_scf.yield
    }
    riscv_func.return
  }
}
