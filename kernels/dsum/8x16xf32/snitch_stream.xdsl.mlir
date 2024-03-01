  riscv.assembly_section ".text" {
    riscv.directive ".globl" "dsum"
    riscv.directive ".p2align" "2"
    riscv_func.func @dsum(%arg0 : !riscv.reg<a0>, %arg1 : !riscv.reg<a1>, %arg2 : !riscv.reg<a2>) -> !riscv.reg<a0> {
      %0 = riscv.mv %arg0 : (!riscv.reg<a0>) -> !riscv.reg<>
      %1 = riscv.mv %arg1 : (!riscv.reg<a1>) -> !riscv.reg<>
      %2 = riscv.mv %arg2 : (!riscv.reg<a2>) -> !riscv.reg<>
      %4 = riscv.li 128 : () -> !riscv.reg<>

    "snitch_stream.streaming_region"(%0, %1, %2) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [256], strides = [8]>
      ],
      "operandSegmentSizes" = array<i32: 2, 1>
    }> ({
      ^0(%5 : !stream.readable<!riscv.freg<ft0>>, %6 : !stream.readable<!riscv.freg<ft1>>, %7 : !stream.writable<!riscv.freg<ft2>>):
        %8 = riscv.addi %4, -1 : (!riscv.reg<>) -> !riscv.reg<>
        riscv_snitch.frep_outer %8 {
          %9 = riscv_snitch.read from %5 : !riscv.freg<ft0>
          %10 = riscv_snitch.read from %6 : !riscv.freg<ft1>
          %11 = riscv.fadd.d %9, %10 : (!riscv.freg<ft0>, !riscv.freg<ft1>) -> !riscv.freg<ft2>
          riscv_snitch.write %11 to %7 : !riscv.freg<ft2>
        }
      }) : (!riscv.reg<>, !riscv.reg<>, !riscv.reg<>) -> ()
      %12 = riscv.mv %2 : (!riscv.reg<>) -> !riscv.reg<a0>
      riscv_func.return %12 : !riscv.reg<a0>
    }
  }
