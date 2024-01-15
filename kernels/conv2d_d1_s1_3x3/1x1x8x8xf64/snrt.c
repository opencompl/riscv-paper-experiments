#include "data.h"

#include <snrt.h>

#include <stdint.h>

void conv_2d_nchw_fchw_d1_s1_3x3(const double* x, const double* y, double* z) {
    snrt_ssr_loop_4d(SNRT_SSR_DM0,
                     // Bounds
                     3, 3, NEW_W, NEW_H,
                     // Strides
                     sizeof(double), W * sizeof(double), sizeof(double),
                     W * sizeof(double));

    snrt_ssr_loop_4d(SNRT_SSR_DM1,
                     // Bounds
                     3, 3, NEW_W, NEW_H,
                     // Strides
                     sizeof(double), 3 * sizeof(double), 0, 0);

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_4D, x);
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_4D, y);

    snrt_ssr_enable();

    for (int y_row = 0; y_row < NEW_H; ++y_row) {
        for (int y_col = 0; y_col < NEW_W; ++y_col) {
            asm volatile(
                "fld ft3, 0(%[array])          \n\t"
                "frep.o  %[nfrep], 1, 0, 0     \n\t"
                "fmadd.d ft3, ft0, ft1, ft3    \n\t"
                "fsd ft3, 0(%[array])          \n\t"
                :
                : [array] "r"(&z[y_row * NEW_W + y_col]), [nfrep] "r"(3 * 3 - 1)
                : "ft0", "ft1", "ft2", "memory");
        }
    }

    snrt_ssr_disable();
}