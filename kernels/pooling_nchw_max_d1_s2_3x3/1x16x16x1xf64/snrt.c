#include "data.h"

#include <snrt.h>

#include <stdint.h>

// Taken from math.h
#define MAXFLOAT 0x1.fffffep+127f

void pooling_nchw_max_d1_s2_3x3(const double* x, double* y) {
    snrt_ssr_loop_4d(SNRT_SSR_DM0,
                     // Bounds
                     NEW_H, NEW_W, 3, 3,
                     // Strides
                     2 * W * sizeof(double), 2 * sizeof(double), W * sizeof(double),
                     sizeof(double));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_4D, x);

    snrt_ssr_enable();

    for (int y_row = 0; y_row < NEW_H; ++y_row) {
        for (int y_col = 0; y_col < NEW_W; ++y_col) {
            register double max_value asm("ft3") = -10000.0;

            asm volatile(
                "frep.o  %[nfrep], 1, 0, 0                 \n\t"
                "fmax.d %[max_value], ft0, %[max_value]    \n\t"
                : [max_value] "+f"(max_value)
                : [nfrep] "r"(3 * 3 - 1)
                : "ft0", "ft1", "ft2", "memory");

            // Store the maximum value in the corresponding position in y
            int y_index = (y_row * NEW_W) + y_col;
            y[y_index] = max_value;
        }
    }

    snrt_ssr_disable();
}
