#include "data.h"

#include <snrt.h>

#include <stdint.h>

void fill(const double x, double* y) {
    const uint32_t niter = M * N;

    snrt_ssr_loop_1d(SNRT_SSR_DM0, niter, sizeof(double));

    snrt_ssr_write(SNRT_SSR_DM0, SNRT_SSR_1D, y);  // ft0

    snrt_ssr_enable();

    const register double fval asm("ft3") = x;

    asm volatile(
        "frep.o  %[nfrep], 1, 0, 0 \n"
        "fmv.d ft0, %[fval]\n"
        :
        : [nfrep] "r"(niter - 1), [fval] "f"(fval)
        : "ft0", "ft3", "memory");

    snrt_fpu_fence();

    snrt_ssr_disable();
}
