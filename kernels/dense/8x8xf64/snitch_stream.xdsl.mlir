riscv.assembly_section ".text" {
  riscv.directive ".globl" "dense"
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
    %c512 = riscv.li 512 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<ft4>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<8>, #builtin.int<0>, #builtin.int<64>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type

    %stride_pattern_1 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<64>, #builtin.int<8>, #builtin.int<0>], "dm" = #builtin.int<1>} : () -> !snitch_stream.stride_pattern_type

    %stride_pattern_2 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<8>, #builtin.int<64>], "dm" = #builtin.int<2>} : () -> !snitch_stream.stride_pattern_type

    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern_0) {"dm" = #builtin.int<0>, "rank" = #builtin.int<3>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %W_stream = "snitch_stream.strided_read"(%W_moved, %stride_pattern_1) {"dm" = #builtin.int<1>, "rank" = #builtin.int<3>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft1>>
    %B_stream = "snitch_stream.strided_read"(%B_moved, %stride_pattern_2) {"dm" = #builtin.int<2>, "rank" = #builtin.int<2>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft2>>

    "snitch.ssr_enable"() : () -> ()

    riscv_scf.for %y_i : !riscv.reg<> = %c0 to %c512 step %c8 {
      %c = riscv.fmv.d %zero_float : (!riscv.freg<ft4>) -> !riscv.freg<ft3>

      %x = riscv.get_float_register : () -> !riscv.freg<ft0>
      %w = riscv.get_float_register : () -> !riscv.freg<ft1>

      %c7 = riscv.li 7 : () -> !riscv.reg<>
      riscv_snitch.frep_outer %c7, 0, 0 ({
        %res = riscv.fmadd.d %x, %w, %c : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<ft3>) -> !riscv.freg<ft3>
        riscv_snitch.frep_yield %res : (!riscv.freg<ft3>) -> ()
      }) : (!riscv.reg<>) -> ()

      %b = riscv.get_float_register : () -> !riscv.freg<ft2>
      %y_0 = riscv.fadd.d %b, %c : (!riscv.freg<ft2>, !riscv.freg<ft3>) -> !riscv.freg<ft3>
      %y_1 = riscv.fmax.d %y_0, %zero_float : (!riscv.freg<ft3>, !riscv.freg<ft4>) -> !riscv.freg<ft3>

      %Y_dest = riscv.add %Y_moved, %y_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
      riscv.fsd %Y_dest, %y_1, 0 : (!riscv.reg<>, !riscv.freg<ft3>) -> ()

      riscv_scf.yield
    }

    "snitch.ssr_disable"() : () -> ()

    riscv_func.return
  }
}
