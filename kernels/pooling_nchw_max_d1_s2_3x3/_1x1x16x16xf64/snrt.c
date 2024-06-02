#include "data.h"

#include <snrt.h>

#include <stdint.h>

void pooling_nchw_max_d1_s2_3x3(const double* x, double* y) {
    snrt_ssr_loop_4d(SNRT_SSR_DM0,
                     // Bounds
                     3, 3, NEW_W, NEW_H,
                     // Strides
                     sizeof(double), W * sizeof(double), 2 * sizeof(double),
                     2 * W * sizeof(double));
    snrt_ssr_loop_1d(SNRT_SSR_DM1,
                     // Bounds
                     NEW_W * NEW_H,
                     // Strides
                     sizeof(double));

    // 2 * sizeof(double), 2 * W * sizeof(double));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_4D, (volatile void*)x);
    snrt_ssr_write(SNRT_SSR_DM1, SNRT_SSR_1D, (volatile void*)y);

    snrt_ssr_enable();

    // Not sure how to do -inf
    register double lowbound asm("ft4") = -10000.0;

    for (int y_row = 0; y_row < NEW_H; ++y_row) {
        for (int y_col = 0; y_col < NEW_W; ++y_col) {
            asm volatile(
                "fmv.d ft3, %[smallval]              \n\t"
                "frep.o  %[nfrep], 1, 0, 0   \n\t"
                "fmax.d ft3, ft0, ft3        \n\t"
                "fmv.d ft1, ft3              \n\t"
                :
                : [array] "r"(&y[y_row * NEW_W + y_col]), [nfrep] "r"(3 * 3 - 1),
                  [smallval] "f"(lowbound)
                : "ft0", "ft1", "memory");
        }
    }

    snrt_ssr_disable();
}
