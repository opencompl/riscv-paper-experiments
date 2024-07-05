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
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg
    %W_moved = riscv.mv %W : (!riscv.reg<a1>) -> !riscv.reg
    %B_moved = riscv.mv %B : (!riscv.reg<a2>) -> !riscv.reg
    %Y_moved = riscv.mv %Y : (!riscv.reg<a3>) -> !riscv.reg

    %c0 = riscv.get_register : !riscv.reg<zero>
    %c1 = riscv.li 1 : !riscv.reg
    %c8 = riscv.li 8 : !riscv.reg
    %c512 = riscv.li 512 : !riscv.reg

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg

    "snitch_stream.streaming_region"(%X_moved, %W_moved, %B_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [8, 8, 8], strides = [64, 0, 8]>,
        #snitch_stream.stride_pattern<ub = [8, 8, 8], strides = [0, 8, 64]>,
        #snitch_stream.stride_pattern<ub = [64], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 3, 0>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %W_stream : !stream.readable<!riscv.freg<ft1>>, %B_stream : !stream.readable<!riscv.freg<ft2>>):
      riscv_scf.for %y_i : !riscv.reg = %c0 to %c512 step %c8 {
        %Y_dest = riscv.add %Y_moved, %y_i : (!riscv.reg, !riscv.reg) -> !riscv.reg
        %c = riscv.fmv.d %zero_float : (!riscv.freg) -> !riscv.freg

        %c7 = riscv.li 7 : !riscv.reg
        %dot = riscv_snitch.frep_outer %c7 iter_args(%acc = %c) -> (!riscv.freg) {
          %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %w = riscv_snitch.read from %W_stream : !riscv.freg<ft1>
          %res = riscv.fmadd.d %x, %w, %acc : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg) -> !riscv.freg
          riscv_snitch.frep_yield %res : !riscv.freg
        }

        %b = riscv.get_float_register : !riscv.freg<ft2>
        %y_0 = riscv.fadd.d %b, %dot : (!riscv.freg<ft2>, !riscv.freg) -> !riscv.freg
        %y_1 = riscv.fmax.d %y_0, %zero_float : (!riscv.freg, !riscv.freg) -> !riscv.freg

        riscv.fsd %Y_dest, %y_1, 0 : (!riscv.reg, !riscv.freg) -> ()

        riscv_scf.yield
      }
    }) : (!riscv.reg, !riscv.reg, !riscv.reg) -> ()

    riscv_func.return
  }
}
