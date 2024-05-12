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

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [7, 7, 3, 3], strides = [256, 16, 128, 8]>,
        #snitch_stream.stride_pattern<ub = [49], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 1, 1>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.writable<!riscv.freg<ft1>>):
      %c392 = riscv.li 392 : () -> !riscv.reg<>
      riscv_scf.for %y_i : !riscv.reg<> = %c0 to %c392 step %c8 {
        %init = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>

        %res = riscv_snitch.frep_outer %c8 iter_args(%acc = %init) -> (!riscv.freg<>) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %res = riscv.fadd.d %x, %acc : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res : !riscv.freg<>
        }

        %y = riscv.fmv.d %res : (!riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y to %Y_stream : !riscv.freg<ft1>

        riscv_scf.yield
      }

    }) : (!riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}
