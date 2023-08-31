#include "data.h"

#include <snrt.h>

#include <stdint.h>

void fadd(float* restrict x, float* restrict y, float* restrict z) {
    typedef float v2f32 __attribute__((vector_size(2 * sizeof(float))));
    const uint32_t niter = (M * N) / 2;

    snrt_ssr_loop_1d(SNRT_SSR_DM_ALL, niter, sizeof(v2f32));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, x);   // ft0
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_1D, y);   // ft1
    snrt_ssr_write(SNRT_SSR_DM2, SNRT_SSR_1D, z);  // ft2

    // Let's take advantage of the fact that we are dealing
    // with statically known shapes: use an unroll factor
    // that leaves no leftovers to be dealt with in a peel
    // loop:
    // (M x N) % (<simd size> x <unroll factor>) = 0
    // Note: this is probably one of the smart things that libxsmm does
    //       to take full advantage of JIT compilation.
#define UNROLL 7
    uint32_t nfrep = (niter / UNROLL) - 1;

    snrt_ssr_enable();

    asm volatile(
        "frep.o  %[nfrep], 7, 0, 0 \n"
        "vfadd.s ft2, ft0, ft1\n"
        "vfadd.s ft2, ft0, ft1\n"
        "vfadd.s ft2, ft0, ft1\n"
        "vfadd.s ft2, ft0, ft1\n"
        "vfadd.s ft2, ft0, ft1\n"
        "vfadd.s ft2, ft0, ft1\n"
        "vfadd.s ft2, ft0, ft1\n"
        :
        : [nfrep] "r"(nfrep)
        : "ft0", "ft1", "ft2", "memory");

    snrt_fpu_fence();
    snrt_ssr_disable();
}
