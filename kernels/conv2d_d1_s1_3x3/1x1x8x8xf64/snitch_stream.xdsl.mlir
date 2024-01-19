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

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<3>, #builtin.int<3>, #builtin.int<6>, #builtin.int<6>], "strides" = [#builtin.int<8>, #builtin.int<64>, #builtin.int<8>, #builtin.int<64>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type<4>
    %stride_pattern_1 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<3>, #builtin.int<3>, #builtin.int<6>, #builtin.int<6>], "strides" = [#builtin.int<8>, #builtin.int<24>, #builtin.int<0>, #builtin.int<0>], "dm" = #builtin.int<1>} : () -> !snitch_stream.stride_pattern_type<4>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %stride_pattern_0, %stride_pattern_1) <{"operandSegmentSizes" = array<i32: 2, 0, 2>}> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>):
      %c288 = riscv.li 288 : () -> !riscv.reg<>
      riscv_scf.for %z_i : !riscv.reg<> = %c0 to %c288 step %c8 {
        %Z_dest = riscv.add %Z_moved, %z_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
        %c = riscv.fld %Z_dest, 0 : (!riscv.reg<>) -> !riscv.freg<>

        %z = riscv_snitch.frep_outer %c8 iter_args(%acc = %c) -> (!riscv.freg<>) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res = riscv.fmadd.d %x, %y, %acc : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res : !riscv.freg<>
        }

        riscv.fsd %Z_dest, %z, 0 : (!riscv.reg<>, !riscv.freg<>) -> ()

        riscv_scf.yield
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !snitch_stream.stride_pattern_type<4>, !snitch_stream.stride_pattern_type<4>) -> ()

    riscv_func.return
  }
}
