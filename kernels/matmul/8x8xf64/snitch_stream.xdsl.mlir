riscv.assembly_section ".text" {
  riscv.directive ".globl" "matmul"
  riscv.directive ".p2align" "2"

// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
  riscv_func.func @matmul(
    %X : !riscv.reg<a0>,
    %Y : !riscv.reg<a1>,
    %G : !riscv.reg<a2>
  ) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>
    %G_moved = riscv.mv %G : (!riscv.reg<a2>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>
    %c512 = riscv.li 512 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<ft4>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<8>, #builtin.int<0>, #builtin.int<64>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type

    %stride_pattern_1 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<64>, #builtin.int<8>, #builtin.int<0>], "dm" = #builtin.int<1>} : () -> !snitch_stream.stride_pattern_type

    %X_stream = "snitch_stream.strided_read"(%X_moved, %stride_pattern_0) {"dm" = #builtin.int<0>, "rank" = #builtin.int<3>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft0>>
    %Y_stream = "snitch_stream.strided_read"(%Y_moved, %stride_pattern_1) {"dm" = #builtin.int<1>, "rank" = #builtin.int<3>} : (!riscv.reg<>, !snitch_stream.stride_pattern_type) -> !stream.readable<!riscv.freg<ft1>>


    "snitch.ssr_enable"() : () -> ()

    %c7 = riscv.li 7 : () -> !riscv.reg<>
    riscv_scf.for %g_i : !riscv.reg<> = %c0 to %c512 step %c8 {
      %g = riscv.fmv.d %zero_float : (!riscv.freg<ft4>) -> !riscv.freg<ft3>

      %x = riscv.get_float_register : () -> !riscv.freg<ft0>
      %y = riscv.get_float_register : () -> !riscv.freg<ft1>
      riscv_snitch.frep_outer %c7, 0, 0 ({
        %res = riscv.fmadd.d %x, %y, %g : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<ft3>) -> !riscv.freg<ft3>
        riscv_snitch.frep_yield %res : (!riscv.freg<ft3>) -> ()
      }) : (!riscv.reg<>) -> ()

      %G_dest = riscv.add %G_moved, %g_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
      riscv.fsd %G_dest, %g, 0 : (!riscv.reg<>, !riscv.freg<ft3>) -> ()

      riscv_scf.yield
    }

    "snitch.ssr_disable"() : () -> ()

    riscv_func.return
  }
}
