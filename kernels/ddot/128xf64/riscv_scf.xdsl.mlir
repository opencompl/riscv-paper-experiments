// xdsl-opt ddot/128xf64/scf.mlir -p convert-func-to-riscv-func,convert-memref-to-riscv,convert-arith-to-riscv,convert-scf-to-riscv-scf,dce,reconcile-unrealized-casts,snitch-allocate-registers,canonicalize,riscv-scf-loop-range-folding,canonicalize
// Then manually optimise loop range

riscv.assembly_section ".text" {
    riscv.directive ".globl" "ddot"
    riscv.directive ".p2align" "2"
    riscv_func.func @ddot(%X : !riscv.reg<a0>, %Y : !riscv.reg<a1>, %Z : !riscv.reg<a2>) {
        // moving function arguments to (not-yet allocated) temporary registers
        %X_moved = riscv.mv %X : (!riscv.reg<a0>) -> !riscv.reg
        %Y_moved = riscv.mv %Y : (!riscv.reg<a1>) -> !riscv.reg
        %Z_moved = riscv.mv %Z : (!riscv.reg<a2>) -> !riscv.reg

        // Load pointee of %Z
        %init = riscv.fld %Z_moved, 0 : (!riscv.reg) -> !riscv.freg

        // loop lower bound, upper bound and step as address offsets
        %lb = riscv.li 0 : () -> !riscv.reg
        %ub = riscv.li 1024 : () -> !riscv.reg
        %c8 = riscv.li 8 : () -> !riscv.reg

        // for loop incrementing induction variable %iv by a step %s in interval [%lb, %ub)
        %res = riscv_scf.for %i : !riscv.reg = %lb to %ub step %c8 iter_args(%acc_in = %init) -> (!riscv.freg) {
            %x_ptr = riscv.add %X_moved, %i : (!riscv.reg, !riscv.reg) -> !riscv.reg
            %x = riscv.fld %x_ptr, 0 : (!riscv.reg) -> !riscv.freg
            %y_ptr = riscv.add %Y_moved, %i : (!riscv.reg, !riscv.reg) -> !riscv.reg
            %y = riscv.fld %y_ptr, 0 : (!riscv.reg) -> !riscv.freg
            %xy = riscv.fmul.d %x, %y : (!riscv.freg, !riscv.freg) -> !riscv.freg<ft2>
            %acc_out = riscv.fadd.d %acc_in, %xy : (!riscv.freg, !riscv.freg<ft2>) -> !riscv.freg
            riscv_scf.yield %acc_out : !riscv.freg
        }

        // Store result to out address
        riscv.fsd %Z_moved, %res, 0 : (!riscv.reg, !riscv.freg) -> ()

        riscv_func.return
    }
}
