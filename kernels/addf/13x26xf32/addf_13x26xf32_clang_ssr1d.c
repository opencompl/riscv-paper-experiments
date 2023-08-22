#include "data_13x26xf32.h"

#include <snitch/runtime.h>

#include <stdint.h>

#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wlanguage-extension-token"
#endif

void addf(float* A, const float* B) {
    register volatile double ft0 asm("ft0");
    register volatile double ft1 asm("ft1");
    asm volatile("" : "=f"(ft0), "=f"(ft1));

    snrt_ssr_loop_1d(SNRT_SSR_DM0, M * N, 1);
    snrt_ssr_loop_1d(SNRT_SSR_DM1, M * N, 1);

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, A);
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_1D, B);
    // FIXME: use write stream for output
    // snrt_ssr_write(SNRT_SSR_DM0, SNRT_SSR_1D, A);

    snrt_ssr_enable();

    register float tmp;
    for (int32_t i = 0; i < M * N; ++i) {
        asm volatile("fadd.s %[tmp], ft0, ft1 \n" : [tmp] "+f"(tmp)::"ft0", "ft1", "ft2");
        A[i] = tmp;
    }

    snrt_ssr_disable();
    asm volatile("" ::"f"(ft0), "f"(ft1));
}
