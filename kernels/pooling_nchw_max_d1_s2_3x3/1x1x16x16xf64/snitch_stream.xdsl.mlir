riscv.assembly_section ".data" {
  riscv.label ".min_val"
  riscv.directive ".quad" "0xc0c3880000000000" {"comment" = "double -1.0E+4"}
}
riscv.assembly_section ".text" {
  riscv.directive ".globl" "pooling_nchw_max_d1_s2_3x3"
  riscv.directive ".p2align" "2"
// x[ M x K ]
// y[ K x N ]
// g[ M x N ]
riscv_func.func public @pooling_nchw_max_d1_s2_3x3(
    %X: !riscv.reg<a0>,
    %Y: !riscv.reg<a1>
) -> () {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>
    %c512 = riscv.li 512 : () -> !riscv.reg<>

    %min_val = riscv.fld %c0, ".min_val" : (!riscv.reg<zero>) -> !riscv.freg<>

    %stride_pattern_0 = "snitch_stream.stride_pattern"() {"ub" = [#builtin.int<3>, #builtin.int<3>, #builtin.int<7>, #builtin.int<7>], "strides" = [#builtin.int<8>, #builtin.int<128>, #builtin.int<16>, #builtin.int<256>], "dm" = #builtin.int<0>} : () -> !snitch_stream.stride_pattern_type<4>

    "snitch_stream.streaming_region"(%X_moved, %stride_pattern_0) <{"operandSegmentSizes" = array<i32: 1, 0, 1>}> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>):
      %c392 = riscv.li 392 : () -> !riscv.reg<>
      riscv_scf.for %y_i : !riscv.reg<> = %c0 to %c392 step %c8 {
        %init = riscv.fmv.d %min_val : (!riscv.freg<>) -> !riscv.freg<>

        %y = riscv_snitch.frep_outer %c8 iter_args(%acc = %init) -> (!riscv.freg<>) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res = riscv.fmax.d %x, %acc : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res : !riscv.freg<>
        }

        %Y_dest = riscv.add %Y_moved, %y_i : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
        riscv.fsd %Y_dest, %y, 0 : (!riscv.reg<>, !riscv.freg<>) -> ()

        riscv_scf.yield
      }
    }) : (!riscv.reg<>, !snitch_stream.stride_pattern_type<4>) -> ()

    riscv_func.return
  }
}