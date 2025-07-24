#include "data.h"

#include <snrt.h>

#include <math.h>

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
        snrt_dma_start_1d((uint64_t)local_x, (uint64_t)X, M * N * sizeof(DTYPE));
        snrt_dma_start_1d((uint64_t)local_y, (uint64_t)Y, M * N * sizeof(DTYPE));
        snrt_dma_wait_all();
    }

    snrt_cluster_hw_barrier();

    // Launch kernel: from this point on only core 0 is required to be alive.
    int thiscore = snrt_cluster_core_idx();
    if (thiscore != 0) return 0;

    snrt_fpu_fence();
    (void)snrt_mcycle();
    sum(local_x, local_y, local_z);
    snrt_fpu_fence();
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
