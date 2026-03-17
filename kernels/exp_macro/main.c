#include "data.h"

#include <snrt.h>

#include <math.h>

#include <stddef.h>

extern "C" {
    void *_sbrk(ptrdiff_t incr) { (void)incr; return (void *)-1; }
    int _read(int fd, void *buf, size_t count) { (void)fd; (void)buf; (void)count; return -1; }
    int _write(int fd, const void *buf, size_t count) { (void)fd; (void)buf; (void)count; return -1; }
    int _lseek(int fd, long offset, int whence) { (void)fd; (void)offset; (void)whence; return -1; }
    int _close(int fd) { (void)fd; return -1; }
}

// Kernel provided via external definition
extern "C" void exp_kernel(double *x, double *z, double *workspace, size_t workspace_size);
double Z[N];

int main() {
    // Allocate shared local memory
    // We use snrt_l1_alloc_cluster_local to ensure that the l1 local memory pointer advances 
    // when we use it later to allocate l1 memory buffers 
    // DTYPE *local_x = (DTYPE *)snrt_l1_alloc_cluster_local(N * sizeof(DTYPE), sizeof(DTYPE));
    // DTYPE *local_z = (DTYPE *)snrt_l1_alloc_cluster_local(N * sizeof(DTYPE), sizeof(DTYPE));

    // Allocate buffer space to operate in for exp_optimized
    size_t workspace_size = 13 * BATCH_SIZE * sizeof(double); 
    double *workspace = (double *)snrt_l1_alloc_cluster_local(workspace_size, sizeof(double));

    // Copy data in shared local memory
    // if (snrt_is_dm_core()) {
    //     snrt_dma_start_1d((uint64_t)local_x, (uint64_t)X, N * sizeof(DTYPE));
    //     snrt_dma_wait_all();
    // }

    snrt_cluster_hw_barrier();

    // Launch kernel: we need DMA core to participate so i moved the core!=0 check to later
    snrt_fpu_fence();
    (void)snrt_mcycle();
    exp_kernel(X, Z, workspace, workspace_size);
    snrt_fpu_fence();
    (void)snrt_mcycle();

     // From this point only core 0 is running
    int thiscore = snrt_cluster_core_idx();
    if (thiscore != 0) return 0;

    // Correctness check
    int nerr = 0;
    for (int i = 0; i < N; i++) {
        // if (i < 5) printf("X[%d] = %f, Z[%d] = %f, G[%d] = %f\n", i, X[i], i, flZ[i], i, G[i]);
        DTYPE d = FABSF((float)Z[i] - (float)G[i]);
        DTYPE ref = FABSF((float)G[i]);

        // Use relative error for large values, absolute for small
        DTYPE tol = ref > (DTYPE)1.0 ? ref * (DTYPE)1E-2 : (DTYPE)1E-2;
        nerr += !(d <= tol);
    }
    return nerr;
}
