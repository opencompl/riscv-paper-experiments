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
extern "C" void exp_kernel(const DTYPE *x, DTYPE *z);

int main() {
    // Allocate shared local memory
    // By avoiding allocators and bumping by a known offset a base pointer
    // (snrt_l1_next()) that is the same for all the cores in the cluster, we are
    // essentially providing the same memory regions to all the cores in this cluster.
    // DTYPE *local_x = (DTYPE *)snrt_l1_next();
    // DTYPE *local_z = local_x + N;

    DTYPE *local_x = (DTYPE *)snrt_l1_alloc_cluster_local(N * sizeof(DTYPE), sizeof(DTYPE));
    DTYPE *local_z = (DTYPE *)snrt_l1_alloc_cluster_local(N * sizeof(DTYPE), sizeof(DTYPE));

    // Copy data in shared local memory
    if (snrt_is_dm_core()) {
        snrt_dma_start_1d((uint64_t)local_x, (uint64_t)X, N * sizeof(DTYPE));
        snrt_dma_wait_all();
    }

    snrt_cluster_hw_barrier();

    // Launch kernel: we need DMA core to participate so i moved the core!=0 check to later
    snrt_fpu_fence();
    (void)snrt_mcycle();
    exp_kernel(local_x, local_z);
    snrt_fpu_fence();
    (void)snrt_mcycle();

     // Only core 0, maybe we need to move this up.
    int thiscore = snrt_cluster_core_idx();
    if (thiscore != 0) return 0;

    // Correctness check
    int nerr = 0;
    int nzero = 0;
    for (int i = 0; i < N; i++) {
        if (local_z[i] == (DTYPE)0.0) nzero++;
        DTYPE d = FABSF(local_z[i] - G[i]);
        DTYPE ref = FABSF(G[i]);
        // Use relative error for large values, absolute for small
        DTYPE tol = ref > (DTYPE)1.0 ? ref * (DTYPE)1E-2 : (DTYPE)1E-2;
        nerr += !(d <= tol);
    }
    // If all outputs are zero, return 100 + nzero as a diagnostic signal
    if (nzero == N) return 100 + nzero;
    return nerr;
}
