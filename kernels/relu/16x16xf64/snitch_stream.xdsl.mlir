riscv.assembly_section ".text" {
  riscv.directive ".globl" "relu"
  riscv.directive ".p2align" "2"
  riscv_func.func @relu(%X : !riscv.reg<a0>, %Y : !riscv.reg<a1>) {
    %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg<>
    %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg<>

    %zero_int = riscv.get_register : () -> !riscv.reg<zero>
    %zero_float = riscv.fcvt.d.w %zero_int : (!riscv.reg<zero>) -> !riscv.freg<>

    "snitch_stream.streaming_region"(%X_moved, %Y_moved) <{
      "stride_patterns" = [
        #snitch_stream.stride_pattern<ub = [16, 16], strides = [8, 128]>
      ],
      "operandSegmentSizes" = array<i32: 1, 1>
    }> ({
    ^0(%X_stream : !stream.readable<!riscv.freg<ft0>>, %Y_stream : !stream.writable<!riscv.freg<ft1>>):
      %c255 = riscv.li 255 : () -> !riscv.reg<>
      riscv_snitch.frep_outer %c255 {
        %x = riscv_snitch.read from %X_stream : !riscv.freg<ft0>
        %y = riscv.fmax.d %x, %zero_float : (!riscv.freg<ft0>, !riscv.freg<>) -> !riscv.freg<ft1>
        riscv_snitch.write %y to %Y_stream : !riscv.freg<ft1>
      }
    }) : (!riscv.reg<>, !riscv.reg<>) -> ()

    riscv_func.return
  }
}
