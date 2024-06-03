#include "data.h"

#include <snrt.h>

#include <stdint.h>

// SSR constraints:
// * The SSR streams load and store eight bytes at a time into float registers
//   that are so treated as double precision values.
// * The dimension of a stream may be at most four.
// * Data in SSR streams may only stem from and go to the TCDM, i.e.,
//   the address range of a stream is constrained to that of the TCDM.
// * There are (usually) three data movers, i.e., there may be at most
//   three streams active at the same time.

void saxpy(float a, float* x, float* y, float* z) {
    // Due to the SSR limitation of moving 64 bits at a time,
    // when dealing with a data type smaller than double
    // we are forced to unroll the loop (by a factor of
    // sizeof(double) / sizeof(float) in this case).
    typedef float v2f32
        __attribute__((vector_size(2 * sizeof(float))));  // Packed vector of 2x floats
    const uint32_t niter = N / 2;

    // Make sure to configure SSRs with a stride multiple of 8,
    // otherwise the scfgw* instructions would silently setup
    // a 0-strided stream.
    snrt_ssr_loop_1d(SNRT_SSR_DM_ALL, niter, sizeof(v2f32));

    snrt_ssr_read(SNRT_SSR_DM0, SNRT_SSR_1D, x);   // ft0
    snrt_ssr_read(SNRT_SSR_DM1, SNRT_SSR_1D, y);   // ft1
    snrt_ssr_write(SNRT_SSR_DM2, SNRT_SSR_1D, z);  // ft2

// We are unrolling by a factor of 8 since the latency for
// a single iteration (vfmul.s + vfadd.s) is ~5 plus a bit
// of additional spare room since we want to see whether
// manually inflating the register pressure is beneficial
#define UNROLL 8

    v2f32 vtmp[UNROLL];
    v2f32 va = {a, a};
    uint32_t nfrep = (niter / UNROLL) - 1;  // Beware: frep executes nfrep + 1 iterations!

    snrt_ssr_enable();

    // Since we are forced to unroll the loop, the easiest way to
    // deal with 2x float values per iteration would be to have
    // proper SIMD instructions. Since we are dealing with a *frugal*
    // architecture, the best we can do is use packed SIMD custom
    // instructions:
    // https://iis-git.ee.ethz.ch/smach/smallFloat-spec
    asm volatile(
        "frep.o  %[nfrep], 16, 0, 0 \n"
        "vfmul.s %[vtmp0], %[va], ft0\n"
        "vfmul.s %[vtmp1], %[va], ft0\n"
        "vfmul.s %[vtmp2], %[va], ft0\n"
        "vfmul.s %[vtmp3], %[va], ft0\n"
        "vfmul.s %[vtmp4], %[va], ft0\n"
        "vfmul.s %[vtmp5], %[va], ft0\n"
        "vfmul.s %[vtmp6], %[va], ft0\n"
        "vfmul.s %[vtmp7], %[va], ft0\n"
        "vfadd.s ft2, %[vtmp0], ft1\n"
        "vfadd.s ft2, %[vtmp1], ft1\n"
        "vfadd.s ft2, %[vtmp2], ft1\n"
        "vfadd.s ft2, %[vtmp3], ft1\n"
        "vfadd.s ft2, %[vtmp4], ft1\n"
        "vfadd.s ft2, %[vtmp5], ft1\n"
        "vfadd.s ft2, %[vtmp6], ft1\n"
        "vfadd.s ft2, %[vtmp7], ft1\n"
        : [vtmp0] "=&f"(vtmp[0]), [vtmp1] "=&f"(vtmp[1]), [vtmp2] "=&f"(vtmp[2]),
          [vtmp3] "=&f"(vtmp[3]), [vtmp4] "=&f"(vtmp[4]), [vtmp5] "=&f"(vtmp[5]),
          [vtmp6] "=&f"(vtmp[6]), [vtmp7] "=&f"(vtmp[7])  // see [1]
        : [nfrep] "r"(nfrep), [va] "f"(va)
        : "ft0", "ft1", "ft2", "memory");
    
    snrt_ssr_disable();
}

// [1] According to the GNU docs:
// Rather than allocating fixed registers via clobbers to provide scratch registers
// for an asm statement, an alternative is to define a variable and make it an
// early-clobber [...]. This gives the compiler register allocator more freedom.
// Source:
// https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers-1
