// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include <snitch/runtime.h>

#include <string.h>

// TODO: Implement using cluster DMA for a faster `memcpy`.
void *snrt_memcpy(void *restrict dst, const void *restrict src, size_t n) {
    return memcpy(dst, src, n);
}