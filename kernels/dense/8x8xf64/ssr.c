#include "data.h"

#include <snrt.h>

#include <stdint.h>

// Attributes must be on function *declarations*, and the function
// must be inline (even if it's already static) to make always_inline work
static inline void matmul_f64(double* C, const double* A, const double* B)
    __attribute__((always_inline));

static inline void add_f64(double* y, const double* b) __attribute__((always_inline));

static inline void relu_f64(double* y) __attribute__((always_inline));

// A[ M x K ] -> ldA = K, non transposed
// B[ K x N ] -> ldB = N, non transposed
// C[ M x N ] -> ldC = N
static inline void matmul_f64(double* C, const double* A, const double* B) {
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

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_3D, A);
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_3D, B);
    snrt_ssr_write(SNRT_SSR_DM1, SNRT_SSR_2D, C);

    snrt_ssr_enable();

    for (uint32_t m = 0; m < M; ++m) {
        for (uint32_t n = 0; n < N; ++n) {
            double c = 0.;
            for (uint32_t k = 0; k < K; ++k) {
                asm volatile("fmadd.d %[c], ft0, ft1, %[c]"
                             : [c] "+f"(c)::"ft0", "ft1", "ft2");
            }
            // Note: we are streaming also the stores to C.
            // Not sure a single fsd (without streaming C) would be much slower
            // than a single fmv.d. The point is that this form *should* be compatible
            // with frep.o + frep.i
            // C[m * /*ldC*/ N + n] = c;
            asm volatile("fmv.d ft2, %[c]" : [c] "+f"(c)::"ft0", "ft1", "ft2");
        }
    }

    snrt_ssr_disable();
}

// y[ M x N ]
// b[ M x N ]
static inline void add_f64(double* y, const double* b) {
    snrt_ssr_loop_1d(SNRT_SSR_DM0,
                     // Bounds
                     M * N,
                     // Strides
                     sizeof(double));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, b);

    snrt_ssr_enable();

    for (uint32_t m = 0; m < M; ++m) {
        for (uint32_t n = 0; n < N; ++n) {
            ++y;
            asm volatile(
                "fld    ft3, 0(%[y])\n"
                "fadd.d ft3, ft3, ft0\n"
                "fsd    ft3, 0(%[y])\n" ::[y] "r"(y)
                : "ft0", "ft1", "ft2", "memory");
        }
    }

    snrt_ssr_disable();
}

// y[ M x N ]
static inline void relu_f64(double* y) {
    for (uint32_t m = 0; m < M; ++m) {
        for (uint32_t n = 0; n < N; ++n) {
            double v = y[m * N + n];
            y[m * N + n] = v > 0. ? v : 0.;
        }
    }
}

// SSR-only version, non-fused
// * Inputs:  x[ M x K ]
// * Weights: w[ K x N ]
// * Biases:  b[ M x N ]
// * Outputs: y[ M x N ]
void dense(const double* restrict x, const double* restrict w, const double* restrict b,
           double* restrict y) {
    // Y = X W
    matmul_f64(y, x, w);
    // Y = Y + B
    add_f64(y, b);
    // Y = relu(Y)
    relu_f64(y);
}
