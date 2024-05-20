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

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %Z_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [6, 6, 3, 3], strides = [64, 8, 64, 8]>,
        #snitch_stream.stride_pattern<ub = [36, 3, 3], strides = [0, 24, 8]>,
        #snitch_stream.stride_pattern<ub = [36], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 1>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>, %Z_stream : !stream.writable<!riscv.freg<ft2>>):
      %c288 = riscv.li 288 : () -> !riscv.reg<>
      riscv_scf.for %z_i : !riscv.reg<> = %c0 to %c288 step %c8 {
        %init = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>

        %res = riscv_snitch.frep_outer %c8 iter_args(%acc = %init) -> (!riscv.freg<>) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res = riscv.fmadd.d %x, %y, %acc : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          riscv_snitch.frep_yield %res : !riscv.freg<>
        }

        %z = riscv.fmv.d %res : (!riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %z to %Z_stream : !riscv.freg<ft2>

        riscv_scf.yield
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}
