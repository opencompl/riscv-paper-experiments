// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
#include <snmlir.h>
#include <snitch/runtime.h>

#include <algorithm>

int main() {
    auto I = snrt_global_core_idx();
    int* V = static_cast<int*>(__builtin_alloca(sizeof(int) * I));
    std::fill(V, V + I, static_cast<int>(I));
    printOpen();
    std::for_each(V, V + I, [](auto i) {
        printI64(i);
        printComma();
    });
    printClose();
    printNewline();
}
