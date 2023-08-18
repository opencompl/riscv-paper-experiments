#include <snitch/runtime.h>

#include <stdint.h>

void echo_from_mlir() {
    uint32_t core_idx = snrt_global_core_idx();
    uint32_t core_num = snrt_global_core_num();
    uint32_t hart = snrt_hartid();

    printf("hart %d (core %d/%d): hello from xdsl-opt -> mlir-opt -> llvm -> snitch\n", hart, core_idx, core_num);
}
