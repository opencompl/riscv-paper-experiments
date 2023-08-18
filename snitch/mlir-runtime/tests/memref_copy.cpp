// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include <snmlir.h>

#include <printf.h>

#include <array>

int main() {
    auto I = snrt_global_core_idx();
    std::array<int32_t, 6> v1_data = {I, I + 1, I + 2, I + 3, I + 4, I + 5};
    std::array<int32_t, 6> v2_data;

    auto v1_memref = StridedMemRefType<int32_t, 1>{};
    v1_memref.basePtr = v1_data.data();  // basePtr
    v1_memref.data = v1_data.data();     // data
    v1_memref.offset = 0;                // offset
    v1_memref.sizes[0] = 6;              // sizes
    v1_memref.strides[0] = 1;            // strides

    auto v2_memref = StridedMemRefType<int32_t, 1>{};
    v2_memref.basePtr = v2_data.data();  // basePtr
    v2_memref.data = v2_data.data();     // data
    v2_memref.offset = 0;                // offset
    v2_memref.sizes[0] = 6;              // sizes
    v2_memref.strides[0] = 1;            // strides


    auto v1_unranked_memref = UnrankedMemRefType<char>{
        1,          // rank
        &v1_memref  // descriptor
    };

    auto v2_unranked_memref = UnrankedMemRefType<char>{
        1,          // rank
        &v2_memref  // descriptor
    };

    memrefCopy(sizeof(int32_t), &v1_unranked_memref, &v2_unranked_memref);
    bool pass = v1_data == v2_data;

    printf("Core %d/%d (cluster %d/%d) memref copy test: %s\n",
           snrt_global_core_idx(), snrt_global_core_num(), snrt_cluster_idx(),
           snrt_cluster_num(), pass ? "pass" : "fail");
}
