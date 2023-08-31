#include <snrt.h>

#include <stdint.h>

typedef float v2f32
    __attribute__((vector_size(2 * sizeof(float))));  // Packed vector of 2x floats

// Unrolling factor of most inner loop.
// Should be at least as high as the FMA delay
// for maximum utilization
#define UNROLL 8

// This is equivalent to a BLAS Level 3 FGEMM[1] with the following parameters fixed to:
// * M -> defined by macro in "data.h"
// * N -> defined by macro in "data.h"
// * K -> defined by macro in "data.h"
// * ldA = M
// * ldB = N
// * ldC = K
// * TRANSA = 'N'
// * TRANSB = 'N'
// [1] https://www.netlib.org/lapack/explore-html/db/dc9/group__single__blas__level3_gafe51bacb54592ff5de056acabd83c260.html#gafe51bacb54592ff5de056acabd83c260

void fgemm(uint32_t ALPHA, const float* A, const float* B, float* C) {
    // Stream 0 (no. of elements)
    // Bounds : UNROLL  | K / 2 | N / UNROLL |   M
    // Strides: (rep) 0 |     2 |          0 | ldA

    uint32_t ssr0_b[4] = {UNROLL, K / 2, N / UNROLL, M};
    uint32_t ssr0_i[4] = {0, sizeof(float) * 2, 0, sizeof(float) * ldA};

    // Stream 1 (no. of elements)
    // Bounds : UNROLL | K / 2 |   N / UNROLL | M
    // Strides:    ldB |     2 | UNROLL * ldb | 0

    uint32_t ssr1_b[4] = {UNROLL, K / 2, N / UNROLL, M};
    uint32_t ssr1_i[4] = {sizeof(float) * ldB, sizeof(float) * 2,
                          sizeof(float) * UNROLL * ldB, 0};

    snrt_ssr_loop_3d(SNRT_SSR_DM0, ssr0_b[1], ssr0_b[2], ssr0_b[3], ssr0_i[1], ssr0_i[2],
                     ssr0_i[3]);
    snrt_ssr_repeat(SNRT_SSR_DM0, UNROLL);

    snrt_ssr_loop_4d(SNRT_SSR_DM1, ssr1_b[0], ssr1_b[1], ssr1_b[2], ssr1_b[3], ssr1_i[0],
                     ssr1_i[1], ssr1_i[2], ssr1_i[3]);

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_4D, A);
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_4D, B);
    snrt_ssr_enable();

    // Inner loop trip count:
    // K / packed SIMD lanes - 1 (frep executes nfrep + 1 iterations)
    const uint32_t n_frep = K / 2 - 1;

    for (uint32_t m = 0; m < M; m++) {
        uint32_t n = 0;
        for (uint32_t n0 = 0; n0 < N / UNROLL; n0++) {
            float* _C = &C[m * ldC + n / 2];
            const register float zero = 0.0;
            register v2f32 c[UNROLL], reduce_reg[UNROLL];

            asm volatile(
                "beqz    %[ALPHA], 1f \n"
                // Load intermediate results
                "flw %[reduce_reg0], 0(%[C]) \n"
                "flw %[reduce_reg1], 4(%[C]) \n"
                "flw %[reduce_reg2], 8(%[C]) \n"
                "flw %[reduce_reg3], 12(%[C]) \n"
                "flw %[reduce_reg4], 16(%[C]) \n"
                "flw %[reduce_reg5], 20(%[C]) \n"
                "flw %[reduce_reg6], 24(%[C]) \n"
                "flw %[reduce_reg7], 28(%[C]) \n"
                // Pack intermediate results into SIMD vector
                "vfcpka.s.s %[reduce_reg0], %[reduce_reg0], %[zero] \n"
                "vfcpka.s.s %[reduce_reg1], %[reduce_reg1], %[zero] \n"
                "vfcpka.s.s %[reduce_reg2], %[reduce_reg2], %[zero] \n"
                "vfcpka.s.s %[reduce_reg3], %[reduce_reg3], %[zero] \n"
                "vfcpka.s.s %[reduce_reg4], %[reduce_reg4], %[zero] \n"
                "vfcpka.s.s %[reduce_reg5], %[reduce_reg5], %[zero] \n"
                "vfcpka.s.s %[reduce_reg6], %[reduce_reg6], %[zero] \n"
                "vfcpka.s.s %[reduce_reg7], %[reduce_reg7], %[zero] \n"
                "j 2f \n"
                "1: \n"
                // Initialize SIMD vector with zeros
                "vfcpka.s.s %[reduce_reg0], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg1], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg2], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg3], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg4], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg5], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg6], %[zero], %[zero] \n"
                "vfcpka.s.s %[reduce_reg7], %[zero], %[zero] \n"

                "2: \n"
                // Don't accumulate in first iteration
                "vfmul.s %[c0], ft1, ft0 \n"
                "vfmul.s %[c1], ft1, ft0 \n"
                "vfmul.s %[c2], ft1, ft0 \n"
                "vfmul.s %[c3], ft1, ft0 \n"
                "vfmul.s %[c4], ft1, ft0 \n"
                "vfmul.s %[c5], ft1, ft0 \n"
                "vfmul.s %[c6], ft1, ft0 \n"
                "vfmul.s %[c7], ft1, ft0 \n"
                // frep over MACs
                "frep.o  %[n_frep], 8, 0, 0 \n"
                "vfmac.s %[c0], ft1, ft0 \n"
                "vfmac.s %[c1], ft1, ft0 \n"
                "vfmac.s %[c2], ft1, ft0 \n"
                "vfmac.s %[c3], ft1, ft0 \n"
                "vfmac.s %[c4], ft1, ft0 \n"
                "vfmac.s %[c5], ft1, ft0 \n"
                "vfmac.s %[c6], ft1, ft0 \n"
                "vfmac.s %[c7], ft1, ft0 \n"
                // Sum-reduce vector
                "vfsum.s %[reduce_reg0], %[c0] \n"
                "vfsum.s %[reduce_reg1], %[c1] \n"
                "vfsum.s %[reduce_reg2], %[c2] \n"
                "vfsum.s %[reduce_reg3], %[c3] \n"
                "vfsum.s %[reduce_reg4], %[c4] \n"
                "vfsum.s %[reduce_reg5], %[c5] \n"
                "vfsum.s %[reduce_reg6], %[c6] \n"
                "vfsum.s %[reduce_reg7], %[c7] \n"
                // Pack results together again into vectors
                "vfcpka.s.s %[c0], %[reduce_reg0], %[reduce_reg1] \n"
                "vfcpka.s.s %[c1], %[reduce_reg2], %[reduce_reg3] \n"
                "vfcpka.s.s %[c2], %[reduce_reg4], %[reduce_reg5] \n"
                "vfcpka.s.s %[c3], %[reduce_reg6], %[reduce_reg7] \n"
                : [c0] "+f"(c[0]), [c1] "+f"(c[1]), [c2] "+f"(c[2]), [c3] "+f"(c[3]),
                  [c4] "+f"(c[4]), [c5] "+f"(c[5]), [c6] "+f"(c[6]), [c7] "+f"(c[7]),
                  [reduce_reg0] "+f"(reduce_reg[0]), [reduce_reg1] "+f"(reduce_reg[1]),
                  [reduce_reg2] "+f"(reduce_reg[2]), [reduce_reg3] "+f"(reduce_reg[3]),
                  [reduce_reg4] "+f"(reduce_reg[4]), [reduce_reg5] "+f"(reduce_reg[5]),
                  [reduce_reg6] "+f"(reduce_reg[6]), [reduce_reg7] "+f"(reduce_reg[7])
                : [C] "r"(_C), [zero] "f"(zero), [n_frep] "r"(n_frep - 1),
                  [ALPHA] "r"(ALPHA)
                : "ft0", "ft1", "ft2");

            // Store results
            ((v2f32*)_C)[0] = c[0];
            ((v2f32*)_C)[1] = c[1];
            ((v2f32*)_C)[2] = c[2];
            ((v2f32*)_C)[3] = c[3];

            // progress by 2 columns each iteration of the loop
            n += UNROLL * 2;
        }

        // Clean up of leftover columns
        snrt_ssr_disable();

        for (; n < N; n++) {
            float c = ALPHA ? C[m * ldC + n] : 0.0;
            for (uint32_t k = 0; k < K; k++) {
                c += A[k + m * ldA] * B[k + n * ldB];
            }
            C[m * ldC + n] = c;
        }

        snrt_ssr_enable();
    }

    snrt_ssr_disable();
}
