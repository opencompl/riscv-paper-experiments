riscv.assembly_section ".text" {
  riscv.directive ".globl" "pooling_nchw_max_d1_s2_3x3"
  riscv.directive ".p2align" "2"
riscv_func.func public @pooling_nchw_max_d1_s2_3x3(
    %X: !riscv.reg<a0>,
    %Y: !riscv.reg<a1>
) -> () {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>

    %c0 = riscv.get_register : () -> !riscv.reg<zero>
    %c1 = riscv.li 1 : () -> !riscv.reg<>
    %c8 = riscv.li 8 : () -> !riscv.reg<>
    %c16 = riscv.li 16 : () -> !riscv.reg<>

    %h = riscv.li 10 : () -> !riscv.reg<>
    %w = riscv.li 10 : () -> !riscv.reg<>
    %new_h = riscv.li 4 : () -> !riscv.reg<>
    %new_w = riscv.li 4 : () -> !riscv.reg<>
    %x_stride = riscv.mul %w, %c16 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %y_stride = riscv.mul %new_w, %c8 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %tile_count = riscv.li 1 : () -> !riscv.reg<>

    %min_val_int = riscv.li -10000 : () -> !riscv.reg<>
    %min_val = fcvt.d.w %min_val_int : (!riscv.reg<>) -> !riscv.freg<>

    %last_x, %last_y = riscv_scf.for %row : !riscv.reg<> = %c0 to %new_h step %c1 iter_args(%x_row = %X_moved, %y_row = %Y_moved) -> (!riscv.reg<>, !riscv.reg<>) {
      "snitch_stream.streaming_region"(%x_row, %y_row) <{
        "stride_patterns" = [
          #snitch_stream.stride_pattern<ub = [1, 3, 3, 4], strides = [64, 80, 8, 16]>,
          #snitch_stream.stride_pattern<ub = [4], strides = [8]>
        ],
        "operandSegmentSizes" = array<i32: 1, 1>
      }> ({
      ^bb0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.writable<!riscv.freg<ft1>>):
        riscv_scf.for %y_i : !riscv.reg<> = %c0 to %tile_count step %c1 {
          %init0 = riscv.fmv.d %min_val : (!riscv.freg<>) -> !riscv.freg<>
          %init1 = riscv.fmv.d %min_val : (!riscv.freg<>) -> !riscv.freg<>
          %init2 = riscv.fmv.d %min_val : (!riscv.freg<>) -> !riscv.freg<>
          %init3 = riscv.fmv.d %min_val : (!riscv.freg<>) -> !riscv.freg<>

          %res0, %res1, %res2, %res3 = riscv_snitch.frep_outer %c8 iter_args(%acc0 = %init0, %acc1 = %init1, %acc2 = %init2, %acc3 = %init3) -> (!riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>) {
            %x0 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res0 = riscv.fmax.d %x0, %acc0 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            %x1 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res1 = riscv.fmax.d %x1, %acc1 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            %x2 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res2 = riscv.fmax.d %x2, %acc2 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            %x3 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res3 = riscv.fmax.d %x3, %acc3 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            riscv_snitch.frep_yield %res0, %res1, %res2, %res3 : !riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>
          }

          %y0 = riscv.fmv.d %res0 : (!riscv.freg<>) -> !riscv.freg<ft1>
          riscv_snitch.write %y0 to %Y_stream : !riscv.freg<ft1>
          %y1 = riscv.fmv.d %res1 : (!riscv.freg<>) -> !riscv.freg<ft1>
          riscv_snitch.write %y1 to %Y_stream : !riscv.freg<ft1>
          %y2 = riscv.fmv.d %res2 : (!riscv.freg<>) -> !riscv.freg<ft1>
          riscv_snitch.write %y2 to %Y_stream : !riscv.freg<ft1>
          %y3 = riscv.fmv.d %res3 : (!riscv.freg<>) -> !riscv.freg<ft1>
          riscv_snitch.write %y3 to %Y_stream : !riscv.freg<ft1>
        }
      }) : (!riscv.reg<>, !riscv.reg<>) -> ()

      %x_next = riscv.add %x_row, %x_stride : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
      %y_next = riscv.add %y_row, %y_stride : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>

      riscv_scf.yield %x_next, %y_next : !riscv.reg<>, !riscv.reg<>
    }

    riscv_func.return
  }
}

