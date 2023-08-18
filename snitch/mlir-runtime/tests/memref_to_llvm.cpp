// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include <snmlir.h>

#include <printf.h>

#include <cstddef>
#include <cstdint>

int main() {
    auto I = snrt_global_core_idx();
    auto size = I * sizeof(int32_t);
    auto mem = static_cast<int32_t*>(_mlir_memref_to_llvm_alloc(size));
    _mlir_memref_to_llvm_free(mem);
    printf(
        "Core %d/%d (cluster %d/%d): allocated/freed %d bytes via MLIR shims\n",
        I, snrt_global_core_num(), snrt_cluster_idx(), snrt_cluster_num(),
        size);
    return mem == nullptr;
}
