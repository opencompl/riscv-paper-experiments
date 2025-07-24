#include "data.h"

#include <snrt.h>

#include <stdint.h>

// x[ N ]
// y[ N ]
// g[ 1 ]
void ddot(const double* x, const double* y, double* g) {
    snrt_ssr_loop_1d(SNRT_SSR_DM_ALL,
                     // Bounds
                     N,
                     // Strides
                     sizeof(double));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, (volatile void*)x);
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_1D, (volatile void*)y);

    snrt_ssr_enable();

    register double c asm("ft3") = *g;

    asm volatile(
        "frep.o  %[nfrep], 1, 0, 0       \n\t"
        "fmadd.d %[c], ft0, ft1, %[c]    \n\t"
        : [c] "+f"(c)
        : [nfrep] "r"(N - 1)
        : "ft0", "ft1", "ft2", "memory");

    *g = c;

    snrt_ssr_disable();
}
