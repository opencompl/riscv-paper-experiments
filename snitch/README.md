# Snitch toolchain for MLIR

Tools to build MLIR and LLVM IR sources for Snitch, and run them via Verilator.

* [`mlir-runtime/`](mlir-runtime/) - runtime support for specific dialects (e.g.: [`vector.print`](https://mlir.llvm.org/docs/Dialects/Vector/#vectorprint-vectorprintop))
* [`snitch-runtime/`](snitch-runtime/) - runtime support for the [Snitch](https://github.com/pulp-platform/snitch) platform
* [`docker/`](docker/) - Docker image containing the toolchain needed to go from MLIR down to RTL simulation (pre-built Verilator simulator, Snitch-capable llvm, mlir)
* [`examples/`](examples/) - Minimal examples, serve as smoke tests for the simulation toolchain

**Note: `opencompl` members seems not to have enough rights to push packages to the organization's
package registry. The image built from [`docker/Dockerfile`](docker/Dockerfile) is currently made available available at:
[`ghcr.io/nazavode/snitch-toolchain:latest`](https://github.com/users/nazavode/packages/container/package/snitch-toolchain)**