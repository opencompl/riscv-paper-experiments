#include "data.h"

#include <snrt.h>

#include <stdint.h>

void matmul(const double* restrict x, const double* restrict y, double* restrict g) {
    // G = X Y
    snrt_ssr_loop_3d(SNRT_SSR_DM0,
                     // Bounds
                     K, N, M,
                     // Strides
                     sizeof(double), 0, sizeof(double) * K);

    snrt_ssr_loop_3d(SNRT_SSR_DM1,
                     // Bounds
                     K, N, M,
                     // Strides
                     sizeof(double) * N, sizeof(double), 0);

    snrt_ssr_loop_2d(SNRT_SSR_DM2,
                     // Bounds
                     N, M,
                     // Strides
                     sizeof(double), sizeof(double) * N);

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_3D, x);
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_3D, y);
    snrt_ssr_read(SNRT_SSR_DM2, SNRT_SSR_2D, g);

    snrt_ssr_enable();

    const register double fzero asm("ft4") = 0.;

    for (uint32_t m = 0; m < M; ++m) {
        for (uint32_t n = 0; n < N; ++n) {
            asm volatile(
                "fmv.d ft3, %[fzero]          \n\t"
                "frep.o  %[nfrep], 1, 0, 0    \n\t"
                "fmadd.d ft3, ft0, ft1, ft3   \n\t"
                "fsd ft3, 0(%[array])         \n\t"
                :
                : [array] "r"(&g[m * N + n]), [nfrep] "r"(K - 1), [fzero] "f"(fzero)
                : "ft0", "ft1", "ft2", "memory");
        }
    }

    snrt_ssr_disable();
}

