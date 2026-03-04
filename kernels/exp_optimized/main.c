// Copyright 2024 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Luca Colagrande <colluca@iis.ee.ethz.ch>
#include "data.h"
#include <math.h>
#include <snrt.h>


extern "C" void vexpf_kernel(double *a, double *b);

double a[LEN], b_golden[LEN], b_actual[LEN];

int main() {
    uint32_t tstart, tend;

    // Initialize input and golden arrays from pre-generated data (core 0 only)
    if (snrt_cluster_core_idx() == 0) {
        for (int i = 0; i < LEN; i++) {
            a[i] = X[i];
            b_golden[i] = G[i];
        }
    }


    // Synchronize cores
    snrt_cluster_hw_barrier();

    // do i need some instruction to describe which cores are to be involved
    // other kernels have only core 0 doing the work, but here i want to involve all cores (DMA core handles transfers, compute core 0 handles computation)

    // Calculate exponential of input array using vectorized implementation
    snrt_fpu_fence();
    (void)snrt_mcycle();
    vexpf_kernel(a, b_actual);
    snrt_fpu_fence();
    (void)snrt_mcycle();


    // Correctness check (do i need to specify that only core 0 does this?)
    if (snrt_cluster_core_idx() == 0) {
        uint32_t nerr = 0;
        for (int i = 0; i < LEN; i++) {
            // Compare results
            float d = fabsf((float)b_golden[i] - (float)b_actual[i]);
            float ref = fabsf((float)b_golden[i]);
            float tol = ref > 1.0f ? ref * 1E-2f : 1E-2f;
            nerr += !(d <= tol);
        }
        return nerr;
    } else
    // is this the right way to go?
    return 0;
}