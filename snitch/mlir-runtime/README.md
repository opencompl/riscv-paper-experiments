# Minimal MLIR Runtime for Snitch

Minimal runtime support for lowering of various MLIR dialects (mainly
[`llvm`](https://mlir.llvm.org/docs/Dialects/LLVM/),
[`vector`](https://mlir.llvm.org/docs/Dialects/Vector/) and
[`memref`](https://mlir.llvm.org/docs/Dialects/MemRef/)).

This has been built via:

* a direct port of the
  [MLIR execution engine utils](https://github.com/llvm/llvm-project/blob/55c88aafa6965646d46404eab16393ba8b1bff95/mlir/include/mlir/ExecutionEngine/CRunnerUtils.h)
  to the Snitch runtime and toolchains; 
* shims to make the
  [MLIR LLVM IR Target](https://mlir.llvm.org/docs/TargetLLVMIR/#generic-alloction-and-deallocation-functions)
  happy;
* shims to make
  [`vector.print`](https://mlir.llvm.org/docs/Dialects/Vector/#vectorprint-mlirvectorprintop)
  work;
* allocators to allow using STL containers on Snitch (currently leveraging bump allocators provided by the runtime).
