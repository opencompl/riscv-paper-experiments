riscv.assembly_section ".text" {
  riscv.directive ".globl" "pooling_nchw_sum_d1_s2_3x3"
  riscv.directive ".p2align" "2"
riscv_func.func public @pooling_nchw_sum_d1_s2_3x3(
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
    %w = riscv.li 34 : () -> !riscv.reg<>
    %new_h = riscv.li 4 : () -> !riscv.reg<>
    %new_w = riscv.li 16 : () -> !riscv.reg<>
    %x_stride = riscv.mul %w, %c16 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %y_stride = riscv.mul %new_w, %c8 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %tile_count = riscv.li 4 : () -> !riscv.reg<>

    %zero_float = riscv.fcvt.d.w %c0 : (!riscv.reg<zero>) -> !riscv.freg<>
    %0 = riscv.li 4 : () -> !riscv.reg<>
    %1 = riscv.li 3 : () -> !riscv.reg<>
    %2 = riscv.li 3 : () -> !riscv.reg<>
    %3 = riscv.li 4 : () -> !riscv.reg<>
    %4 = riscv.addi %0, -1 : (!riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_bound"(%4) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<0>} : (!riscv.reg<>) -> ()
    %5 = riscv.addi %1, -1 : (!riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_bound"(%5) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<1>} : (!riscv.reg<>) -> ()
    %6 = riscv.addi %2, -1 : (!riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_bound"(%6) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<2>} : (!riscv.reg<>) -> ()
    %7 = riscv.addi %3, -1 : (!riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_bound"(%7) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<3>} : (!riscv.reg<>) -> ()
    %8 = riscv.li 16 : () -> !riscv.reg<>
    %9 = riscv.li 8 : () -> !riscv.reg<>
    %10 = riscv.li 272 : () -> !riscv.reg<>
    %11 = riscv.li 64 : () -> !riscv.reg<>
    "snitch.ssr_set_dimension_stride"(%8) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<0>} : (!riscv.reg<>) -> ()
    %12 = riscv.li 0 : () -> !riscv.reg<>
    %13 = riscv.mul %4, %8 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %14 = riscv.add %12, %13 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %15 = riscv.sub %9, %14 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_stride"(%15) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<1>} : (!riscv.reg<>) -> ()
    %16 = riscv.mul %5, %9 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %17 = riscv.add %14, %16 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %18 = riscv.sub %10, %17 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_stride"(%18) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<2>} : (!riscv.reg<>) -> ()
    %19 = riscv.mul %6, %10 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %20 = riscv.add %17, %19 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    %21 = riscv.sub %11, %20 : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_stride"(%21) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<3>} : (!riscv.reg<>) -> ()
    %22 = riscv.li 16 : () -> !riscv.reg<>
    %23 = riscv.addi %22, -1 : (!riscv.reg<>) -> !riscv.reg<>
    "snitch.ssr_set_dimension_bound"(%23) {"dm" = #builtin.int<1>, "dimension" = #builtin.int<0>} : (!riscv.reg<>) -> ()
    %24 = riscv.li 8 : () -> !riscv.reg<>
    "snitch.ssr_set_dimension_stride"(%24) {"dm" = #builtin.int<1>, "dimension" = #builtin.int<0>} : (!riscv.reg<>) -> ()

    %last_x, %last_y = riscv_scf.for %row : !riscv.reg<> = %c0 to %new_h step %c1 iter_args(%x_row = %X_moved, %y_row = %Y_moved) -> (!riscv.reg<>, !riscv.reg<>) {
      "snitch.ssr_set_dimension_source"(%x_row) {"dm" = #builtin.int<0>, "dimension" = #builtin.int<3>} : (!riscv.reg<>) -> ()
      "snitch.ssr_set_dimension_destination"(%y_row) {"dm" = #builtin.int<1>, "dimension" = #builtin.int<0>} : (!riscv.reg<>) -> ()
        %X_stream, %Y_stream = "snitch.ssr_enable"() : () -> (!stream.readable<!riscv.freg<ft0>>, !stream.writable<!riscv.freg<ft1>>)
        riscv_scf.for %y_i : !riscv.reg<> = %c0 to %tile_count step %c1 {
          %init0 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
          %init1 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
          %init2 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>
          %init3 = riscv.fmv.d %zero_float : (!riscv.freg<>) -> !riscv.freg<>

          %res0, %res1, %res2, %res3 = riscv_snitch.frep_outer %c8 iter_args(%acc0 = %init0, %acc1 = %init1, %acc2 = %init2, %acc3 = %init3) -> (!riscv.freg<>, !riscv.freg<>, !riscv.freg<>, !riscv.freg<>) {
            %x0 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res0 = riscv.fadd.d %x0, %acc0 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            %x1 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res1 = riscv.fadd.d %x1, %acc1 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            %x2 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res2 = riscv.fadd.d %x2, %acc2 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
            %x3 = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
            %res3 = riscv.fadd.d %x3, %acc3 : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<>
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
      "snitch.ssr_disable"() : () -> ()
      %x_next = riscv.add %x_row, %x_stride : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>
      %y_next = riscv.add %y_row, %y_stride : (!riscv.reg<>, !riscv.reg<>) -> !riscv.reg<>

      riscv_scf.yield %x_next, %y_next : !riscv.reg<>, !riscv.reg<>
    }

    riscv_func.return
  }
}
