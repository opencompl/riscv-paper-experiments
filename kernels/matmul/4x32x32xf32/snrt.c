#include "data.h"

#include <snrt.h>

#include <stdint.h>

typedef float v2f32 __attribute__((vector_size(8)));

#define UNROLL 8
#define LANES 2
#define TRANSFER_SIZE sizeof(v2f32)

#if (K % UNROLL) != 0
#error K must be a multiple of the unroll factor
#endif

#if (N % LANES) != 0
#error N must be a multiple of the number of SIMD lanes
#endif

#if sizeof(v2f32) != __riscv_flen
#error size of a SIMD vector is not FLEN, SSRs are't going to behave how we expect
#endif

// x[ M x K ]
// y[ K x N ]
// c[ M x N ]
// c = x * y
void matmul(const float* restrict x, const float* restrict y, float* restrict c) {
    snrt_ssr_loop_3d(SNRT_SSR_DM0,
                     // Bounds
                     K, N, M,
                     // Strides
                     TRANSFER_SIZE, 0, TRANSFER_SIZE * K);

    snrt_ssr_loop_3d(SNRT_SSR_DM1,
                     // Bounds
                     K, N, M,
                     // Strides
                     TRANSFER_SIZE * N, TRANSFER_SIZE, 0);

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_3D, x); // ft0
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_3D, y); // ft1

    v2f32 dot[UNROLL];

    const double fzero asm("ft4") = 0.;

    snrt_ssr_enable();

    for (uint32_t m = 0; m < M; ++m) {
        for (uint32_t n = 0; n < N; n += LANES) {
            asm volatile(
                // Zero partial accumulators
                "vfcpka.s.s %[dot0], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot1], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot2], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot3], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot4], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot5], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot6], %[fzero], %[fzero] \n"
                "vfcpka.s.s %[dot7], %[fzero], %[fzero] \n"
                // Inner products
                "frep.o %[nfrep], %[unroll], 0, 0 \n"
                    "vfmac.s %[dot0], ft1, ft0 \n"
                    "vfmac.s %[dot1], ft1, ft0 \n"
                    "vfmac.s %[dot2], ft1, ft0 \n"
                    "vfmac.s %[dot3], ft1, ft0 \n"
                    "vfmac.s %[dot4], ft1, ft0 \n"
                    "vfmac.s %[dot5], ft1, ft0 \n"
                    "vfmac.s %[dot6], ft1, ft0 \n"
                    "vfmac.s %[dot7], ft1, ft0 \n"
                // Binary reduction of partial accumulators:
                // tree depth is log2(UNROLL)
                // Depth 1:
                "vfsum.s %[dot0], %[dot1] \n"
                "vfsum.s %[dot2], %[dot3] \n"
                "vfsum.s %[dot4], %[dot5] \n"
                "vfsum.s %[dot6], %[dot7] \n"
                // Depth 2:
                "vfsum.s %[dot0], %[dot2] \n"
                "vfsum.s %[dot4], %[dot6] \n"
                // Depth 3: final result in dot0
                "vfsum.s %[dot0], %[dot4] \n"
                :
                : [nfrep] "r"(K / UNROLL - 1),
                  [unroll] "i"(UNROLL),
                  [fzero] "f"(fzero),
                  [dot0] "+f"(dot[0]),
                  [dot1] "+f"(dot[1]),
                  [dot2] "+f"(dot[2]),
                  [dot3] "+f"(dot[3]),
                  [dot4] "+f"(dot[4]),
                  [dot5] "+f"(dot[5]),
                  [dot6] "+f"(dot[6]),
                  [dot7] "+f"(dot[7])
                : "ft0", "ft1", "ft2", "memory");
            
            c[m * N + n] = dot[0];
        }
    }

    snrt_ssr_disable();
}
