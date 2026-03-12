#include "data.h"

#include <snrt.h>
#include <stdint.h>

#include "../optimized.h"


#ifdef __cplusplus
extern "C" {
#endif

double x_mem[N], z_mem[N];

void exp_kernel(const DTYPE* x, DTYPE* z) {
    // Problem 1: exp_optimized expects double pointers to memory,
    // but we pass pointers to the l1 scatchpad.
    // -> We create arrays in memory and copye date from l1 scratchpad to these arrays

    // Problem 2: only implemented for f64
    // -> For any other DTYPE we convert the data to f64 explicitly first before calling exp_optimized 
    // and then convert it back to DTYPE after.
    if (snrt_cluster_core_idx() == 0) {
        for (int i = 0; i < N; i++) {
            x_mem[i] = (double)x[i];
        }
    }    
    snrt_cluster_hw_barrier();
    // instead of operating on each element one by one by iterating over the array, 
    // we operate on multiple elements at a time.
    exp_optimized(x_mem, z_mem); 

    snrt_cluster_hw_barrier();

    if (snrt_cluster_core_idx() == 0) {
        for (int i = 0; i < N; i++) {
            z[i] = (DTYPE)z_mem[i];
            // z[i] = (DTYPE)EXPF(x[i]);
        }
    }

    
}

#ifdef __cplusplus
}
#endif
