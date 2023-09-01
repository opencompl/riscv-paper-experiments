#include "data.h"

#include <snrt.h>

#include <stdint.h>

void fadd(float* x, float* y, float* z) {
    typedef float v2f32 __attribute__((vector_size(2 * sizeof(float))));
    const uint32_t niter = (M * N) / 2;

    snrt_ssr_loop_1d(SNRT_SSR_DM_ALL, niter, sizeof(v2f32));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, x);   // ft0
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_1D, y);   // ft1
    snrt_ssr_write(SNRT_SSR_DM2, SNRT_SSR_1D, z);  // ft2

    snrt_ssr_enable();

    asm volatile(
        "frep.o  %[nfrep], 1, 0, 0 \n"
        "vfadd.s ft2, ft0, ft1\n"
        :
        : [nfrep] "r"(niter - 1)
        : "ft0", "ft1", "ft2", "memory");

    snrt_fpu_fence();

    snrt_ssr_disable();
}
