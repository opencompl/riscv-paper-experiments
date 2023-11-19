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

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<8>, #builtin.int<0>, #builtin.int<64>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type<3>

    %stride_pattern_1 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<8>, #builtin.int<8>, #builtin.int<8>], "strides" = [#builtin.int<64>, #builtin.int<8>, #builtin.int<0>], "dm" = #builtin.int<1>} : () -> !snitch_stream.stride_pattern_type<3>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %stride_pattern_0, %stride_pattern_1) <{"operandSegmentSizes" = array<i32: 2, 0, 2>}> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>):
      %c7 = riscv.li 7 : () -> !riscv.reg<>
      riscv_scf.for %g_i : !riscv.reg<> = %c0 to %c512 step %c8 {
        %init = riscv.fmv.d %zero_float : (!riscv.freg<ft4>) -> !riscv.freg<ft3>

        %g = riscv_snitch.frep_outer %c7 iter_args(%acc = %init) -> (!riscv.freg<ft3>) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res = riscv.fmadd.d %x, %y, %acc : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<ft3>) -> !riscv.freg<ft3>
          riscv_snitch.frep_yield %res : !riscv.freg<ft3>
        }

        %G_dest = riscv.add %G_moved, %g_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
        riscv.fsd %G_dest, %g, 0 : (!riscv.reg<>, !riscv.freg<ft3>) -> ()

        riscv_scf.yield
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !snitch_stream.stride_pattern_type<3>, !snitch_stream.stride_pattern_type<3>) -> ()

    riscv_func.return
  }
}
