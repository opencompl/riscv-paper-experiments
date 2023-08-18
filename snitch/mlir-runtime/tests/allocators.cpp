// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
#include <snmlir.h>

#include <printf.h>

#include <numeric>
#include <vector>

namespace {

template <typename T>
using l1_vector = std::vector<T, snitch::l1_allocator<T>>;

template <typename T>
using l3_vector = std::vector<T, snitch::l3_allocator<T>>;

// inline constexpr size_t Size = 16; // FIXME: enable at least C++17
#define Size 16L

}  // namespace

template <template <typename> typename Vector>
static bool test_vector(size_t n, size_t value) {
    auto V = Vector<int32_t>(n, 0);
    std::fill(begin(V), end(V), static_cast<int32_t>(value));
    auto sum = std::accumulate(begin(V), end(V), 0);
    return sum == (n * value);
}

int main() {
    auto I = snrt_global_core_idx();
    auto l1_pass = test_vector<l1_vector>(Size, I);
    printf("Core %d/%d (cluster %d/%d) L1 allocator test: %s\n",
           snrt_global_core_idx(), snrt_global_core_num(), snrt_cluster_idx(),
           snrt_cluster_num(), l1_pass ? "pass" : "fail");
    auto l3_pass = test_vector<l3_vector>(Size, I);
    printf("Core %d/%d (cluster %d/%d) L3 allocator test: %s\n",
           snrt_global_core_idx(), snrt_global_core_num(), snrt_cluster_idx(),
           snrt_cluster_num(), l3_pass ? "pass" : "fail");
    return !(l1_pass && l3_pass);
}