riscv.assembly_section ".text" {
  riscv.directive ".globl" "pooling_nchw_sum_d1_s2_3x3"
  riscv.directive ".p2align" "2"
// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
riscv_func.func public @pooling_nchw_sum_d1_s2_3x3(
    %X: !riscv.reg<a0>,
    %Y: !riscv.reg<a1>
) -> () {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>
    %c512 = riscv.li 512 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<ft4>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<3>, #builtin.int<3>, #builtin.int<7>, #builtin.int<7>], "strides" = [#builtin.int<8>, #builtin.int<128>, #builtin.int<16>, #builtin.int<256>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type

    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern_0) {"dm" = #builtin.int<0>, "rank" = #builtin.int<4>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>

    "snitch.ssr_enable"() : () -> ()

    %c392 = riscv.li 392 : () -> !riscv.reg<>
    riscv_scf.for %y_i : !riscv.reg<> = %c0 to %c392 step %c8 {
      %y = riscv.fmv.d %zero_float : (!riscv.freg<ft4>) -> !riscv.freg<ft3>

      %x = riscv.get_float_register : () -> !riscv.freg<ft0>
      riscv_snitch.frep_outer %c8 {
        %res = riscv.fadd.d %x, %y : (!riscv.freg<ft0>, !riscv.freg<ft3>) -> !riscv.freg<ft3>
        riscv_snitch.frep_yield %res : !riscv.freg<ft3>
      }

      %Y_dest = riscv.add %Y_moved, %y_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
      riscv.fsd %Y_dest, %y, 0 : (!riscv.reg<>, !riscv.freg<ft3>) -> ()

      riscv_scf.yield
    }

    "snitch.ssr_disable"() : () -> ()

    riscv_func.return
  }
}
