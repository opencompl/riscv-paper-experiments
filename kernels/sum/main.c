#include "data.h"

#include <snrt.h>

#include <math.h>

static inline void __rt_fpu_fence_full() {
    uint32_t register tmp;
    asm volatile("fmv.x.w %0, fa0\n\t" : "=&r"(tmp) : :);
}

// Kernel provided via external definition
void sum(DTYPE *x, DTYPE *y, DTYPE *z);

int main() {
    // Allocate shared local memory
    // By avoiding allocators and bumping by a known offset a base pointer
    // (snrt_l1_next()) that is the same for all the cores in the cluster, we are
    // essentially providing the same memory regions to all the cores in this cluster.
    DTYPE *local_x = (DTYPE *)snrt_l1_next();
    DTYPE *local_y = local_x + M * N;
    DTYPE *local_z = local_y + M * N;

    // Copy data in shared local memory
    if (snrt_is_dm_core()) {
        snrt_dma_start_1d(local_x, X, M * N * sizeof(DTYPE));
        snrt_dma_start_1d(local_y, Y, M * N * sizeof(DTYPE));
        snrt_dma_wait_all();
    }

    snrt_cluster_hw_barrier();

    // Launch kernel: from this point on only core 0 is required to be alive.
    int thiscore = snrt_cluster_core_idx();
    if (thiscore != 0) return 0;

    __rt_fpu_fence_full();
    (void)snrt_mcycle();
    sum(local_x, local_y, local_z);
    __rt_fpu_fence_full();
    (void)snrt_mcycle();

    // Correctness check
    int nerr = 0;
    for (int i = 0; i < TEST_COUNT; i++) {
        DTYPE d = fabs(local_z[i] - G[i]);
        nerr += !(d <= 1E-2);  // Make sure to take into account NaNs (e.g.: happy path
                               // on the taken branch)
    }
    return nerr;
}
