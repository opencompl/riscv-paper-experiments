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
extern "C" void exp_kernel(const fp_t *x, fp_t *z);

int main() {
    // Allocate shared local memory
    // By avoiding allocators and bumping by a known offset a base pointer
    // (snrt_l1_next()) that is the same for all the cores in the cluster, we are
    // essentially providing the same memory regions to all the cores in this cluster.
    fp_t *local_x = (fp_t *)snrt_l1_next();
    fp_t *local_z = local_x + N;

    // Copy data in shared local memory
    if (snrt_is_dm_core()) {
        snrt_dma_start_1d((uint64_t)local_x, (uint64_t)X, N * sizeof(fp_t));
        snrt_dma_wait_all();
    }

    snrt_cluster_hw_barrier();

    // Launch kernel: from this point on only core 0 is required to be alive.
    int thiscore = snrt_cluster_core_idx();
    if (thiscore != 0) return 0;

    snrt_fpu_fence();
    (void)snrt_mcycle();
    exp_kernel(local_x, local_z);
    snrt_fpu_fence();
    (void)snrt_mcycle();

    // Correctness check
    int nerr = 0;
    for (int i = 0; i < N; i++) {
        fp_t d = FABSF(local_z[i] - G[i]);
        fp_t ref = FABSF(G[i]);
        // Use relative error for large values, absolute for small
        fp_t tol = ref > (fp_t)1.0 ? ref * (fp_t)1E-2 : (fp_t)1E-2;
        nerr += !(d <= tol);
    }
    return nerr;
}
