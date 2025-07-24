#include "data.h"

#include <snrt.h>

#include <math.h>

// Kernel provided via external definition
extern "C" void dense(double *x, double *w, double *b, double *y);

int main() {
    // Allocate shared local memory
    // By avoiding allocators and bumping by a known offset a base pointer
    // (snrt_l1_next()) that is the same for all the cores in the cluster, we are
    // essentially providing the same memory regions to all the cores in this cluster.
    double *local_x = (double *)snrt_l1_next();
    double *local_w = local_x + M * K;
    double *local_b = local_w + K * N;
    double *local_y = local_b + M * N;

    // Copy data in shared local memory
    if (snrt_is_dm_core()) {
        snrt_dma_start_1d((uint64_t)local_x, (uint64_t)X, M * K * sizeof(double));
        snrt_dma_start_1d((uint64_t)local_w, (uint64_t)W, K * N * sizeof(double));
        snrt_dma_start_1d((uint64_t)local_b, (uint64_t)B, M * N * sizeof(double));
        snrt_dma_start_1d((uint64_t)local_y, (uint64_t)Y_IN, M * N * sizeof(double));
        snrt_dma_wait_all();
    }

    snrt_cluster_hw_barrier();

    // Launch kernel: from this point on only core 0 is required to be alive.
    int thiscore = snrt_cluster_core_idx();
    if (thiscore != 0) return 0;

    snrt_fpu_fence();
    (void)snrt_mcycle();
    dense(local_x, local_w, local_b, local_y);
    snrt_fpu_fence();
    (void)snrt_mcycle();

    // Correctness check
    int nerr = 0;
    for (int i = 0; i < M * N; i++) {
        double d = fabs(local_y[i] - Y_OUT[i]);
        nerr += !(d <= 1E-2f);  // Make sure to take into account NaNs (e.g.: happy path
                                // on the taken branch)
    }
    return nerr;
}
