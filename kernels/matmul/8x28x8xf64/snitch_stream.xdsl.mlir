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
    %c4 = riscv.li 4 : () -> !riscv.reg<>
    %frep_count_minus_one = riscv.li 25 : () -> !riscv.reg<>
    %target_count = riscv.li 64 : () -> !riscv.reg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved, %G_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [8, 2, 28, 4], strides = [224, 0, 8, 0]>,
        #snitch_stream.stride_pattern<ub = [8, 2, 28, 4], strides = [0, 32, 64, 8]>,
        #snitch_stream.stride_pattern<ub = [64], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 1>
    }> ({
    ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.readable<!riscv.freg<ft1>>, %G_stream : !stream.writable<!riscv.freg<ft2>>):
      riscv_scf.for %g_i : !riscv.reg<> = %c0 to %target_count step %c4 {
        %x00 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y00 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %init0 = riscv.fmul.d %x00, %y00 : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<>
        %x01 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y01 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %init1 = riscv.fmul.d %x01, %y01 : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<>
        %x02 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y02 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %init2 = riscv.fmul.d %x02, %y02 : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<>
        %x03 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y03 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %init3 = riscv.fmul.d %x03, %y03 : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<>

        %g00, %g01, %g02, %g03 = riscv_snitch.frep_outer %frep_count_minus_one iter_args(%acc0 = %init0, %acc1 = %init1, %acc2 = %init2, %acc3 = %init3) -> (!riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>) {
          %x10 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y10 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res0 = riscv.fmadd.d %x10, %y10, %acc0 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x11 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y11 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res1 = riscv.fmadd.d %x11, %y11, %acc1 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x12 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y12 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res2 = riscv.fmadd.d %x12, %y12, %acc2 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>
          %x13 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
          %y13 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
          %res3 = riscv.fmadd.d %x13, %y13, %acc3 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<>

          riscv_snitch.frep_yield %res0, %res1, %res2, %res3 : !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>
        }

        %x20 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y20 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %g10 = riscv.fmadd.d %x20, %y20, %g00 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %g10 to %G_stream : !riscv.freg<ft2>
        %x21 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y21 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %g11 = riscv.fmadd.d %x21, %y21, %g01 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %g11 to %G_stream : !riscv.freg<ft2>
        %x22 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y22 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %g12 = riscv.fmadd.d %x22, %y22, %g02 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %g12 to %G_stream : !riscv.freg<ft2>
        %x23 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y23 = riscv_snitch.read from %Y_stream : !riscv.freg<ft1>
        %g13 = riscv.fmadd.d %x23, %y23, %g03 : (!riscv.freg<ft0>, !riscv.freg<ft1>, !riscv.freg<>) -> !riscv.freg<ft2>
        riscv_snitch.write %g13 to %G_stream : !riscv.freg<ft2>

        riscv_scf.yield
      }
    }) : (!riscv.reg<>, !riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}

