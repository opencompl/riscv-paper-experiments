riscv.assembly_section ".text" {
  riscv.directive ".globl" "conv_2d_nchw_fchw_d1_s1_3x3"
  riscv.directive ".p2align" "2"
// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
riscv_func.func public @conv_2d_nchw_fchw_d1_s1_3x3(
    %X: !riscv.reg<a0>,
    %Y: !riscv.reg<a1>,
    %Z: !riscv.reg<a2>
) -> () {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %Z_moved = riscv.mv %Z : (!riscv.reg<a2>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<ft4>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<3>, #builtin.int<3>, #builtin.int<6>, #builtin.int<6>], "strides" = [#builtin.int<8>, #builtin.int<64>, #builtin.int<8>, #builtin.int<64>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type
    %stride_pattern_1 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<3>, #builtin.int<3>, #builtin.int<6>, #builtin.int<6>], "strides" = [#builtin.int<8>, #builtin.int<24>, #builtin.int<0>, #builtin.int<0>], "dm" = #builtin.int<1>} : () -> !snitch_stream.stride_pattern_type

    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern_0) {"dm" = #builtin.int<0>, "rank" = #builtin.int<4>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %Y_stream = "snitch_stream.strided_read"(%Y_moved, %stride_pattern_1) {"dm" = #builtin.int<1>, "rank" = #builtin.int<4>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>

    "snitch.ssr_enable"() : () -> ()

    %c288 = riscv.li 288 : () -> !riscv.reg<>
    riscv_scf.for %z_i : !riscv.reg<> = %c0 to %c288 step %c8 {
      %c = riscv.fmv.d %zero_float : (!riscv.freg<ft4>) -> !riscv.freg<ft3>

      %x = riscv.get_float_register : () -> !riscv.freg<ft0>
      %y = riscv.get_float_register : () -> !riscv.freg<ft1>
      riscv_snitch.frep_outer %c8, 0, 0 ({
        %res = riscv.fmadd.d %x, %y, %c : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<ft3>) -> !riscv.freg<ft3>
        riscv_snitch.frep_yield %res : (!riscv.freg<ft3>) -> ()
      }) : (!riscv.reg<>) -> ()

      %Z_dest = riscv.add %Z_moved, %z_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
      riscv.fsd %Z_dest, %c, 0 : (!riscv.reg<>, !riscv.freg<ft3>) -> ()

      riscv_scf.yield
    }

    "snitch.ssr_disable"() : () -> ()

    riscv_func.return
  }
}
