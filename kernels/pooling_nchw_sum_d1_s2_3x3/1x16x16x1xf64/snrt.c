#include "data.h"

#include <snrt.h>

#include <stdint.h>

void pooling_nchw_sum_d1_s2_3x3(const double* x, double* y) {
    snrt_ssr_loop_4d(SNRT_SSR_DM0,
                     // Bounds
                     3, 3, NEW_W, NEW_H,
                     // Strides
                     sizeof(double), W * sizeof(double), 2 * sizeof(double),
                     2 * W * sizeof(double));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_4D, x);

    snrt_ssr_enable();

    for (int y_row = 0; y_row < NEW_H; ++y_row) {
        for (int y_col = 0; y_col < NEW_W; ++y_col) {
            register double sum asm("ft3") = 0.0;

            asm volatile(
                "frep.o  %[nfrep], 1, 0, 0     \n\t"
                "fadd.d %[sum], ft0, %[sum]    \n\t"
                : [sum] "+f"(sum)
                : [nfrep] "r"(3 * 3 - 1)
                : "ft0", "ft1", "ft2", "memory");

            // Store the maximum value in the corresponding position in y
            y[y_row * NEW_W + y_col] = sum;
        }
    }

    snrt_ssr_disable();
}
