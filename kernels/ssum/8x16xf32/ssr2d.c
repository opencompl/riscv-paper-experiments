#include "data.h"

#include <snrt.h>

#include <stdint.h>

void ssum(float* x, float* y, float* z) {
    typedef float v2f32 __attribute__((vector_size(2 * sizeof(float))));
    const uint32_t m = M;
    const uint32_t n = N / 2;

    snrt_ssr_loop_2d(SNRT_SSR_DM_ALL, m, n, sizeof(v2f32) * n, sizeof(v2f32));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_2D, x);   // ft0
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_2D, y);   // ft1
    snrt_ssr_write(SNRT_SSR_DM2, SNRT_SSR_2D, z);  // ft2

    snrt_ssr_enable();

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            asm volatile("vfadd.s ft2, ft0, ft1\n" : : : "ft0", "ft1", "ft2", "memory");
        }
    }

    snrt_ssr_disable();
}
