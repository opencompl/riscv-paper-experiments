#include "data.h"

#include <snrt.h>

void relu(const double* x, double* y) {
    const int niter = (M * N);

    // Still cheaper to do a single configuration on SNRT_SSR_DM_ALL
    // even if we are using inly 2 streams
    snrt_ssr_loop_1d(SNRT_SSR_DM_ALL, niter, sizeof(double));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, x);   // ft0
    snrt_ssr_write(SNRT_SSR_DM1, SNRT_SSR_1D, y);  // ft1

    // BEWARE: even if we are using only 2 streams, all stream-mapped registers become
    // streamed after snrt_ssr_enable()! This means that, alongside our correctly
    // configured ft0 and ft1, also ft2 must be considered reserved.
    register double lowbound asm("ft3") = 0.;

// This is tricky: latency of fmax.d is 1 cycle sharp, so what would be
// the right unroll factor? Probably unrolling is not useful (can even
// be hurtful) here.
#define UNROLL 2

    int nfrep = (niter / UNROLL) - 1;  // Beware: frep executes nfrep + 1 iterations!

    snrt_ssr_enable();

    asm volatile(
        "frep.o  %[nfrep], 2, 0, 0 \n"
        "fmax.d ft1, ft0, %[lowbound]\n"
        "fmax.d ft1, ft0, %[lowbound]\n"
        :
        : [nfrep] "r"(nfrep), [lowbound] "f"(lowbound)
        : "ft0", "ft1", "memory");

    snrt_ssr_disable();
}
