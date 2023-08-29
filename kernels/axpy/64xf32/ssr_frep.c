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

void axpy(float a, float* x, float* y, float* z) {
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

    v2f32 vtmp;
    v2f32 va = {a, a};
    uint32_t nfrep = niter - 1;  // Beware: frep executes nfrep + 1 iterations!

    snrt_ssr_enable();

    // Since we are forced to unroll the loop, the easiest way to
    // deal with 2x float values per iteration would be to have
    // proper SIMD instructions. Since we are dealing with a *frugal*
    // architecture, the best we can do is use packed SIMD custom
    // instructions:
    // https://iis-git.ee.ethz.ch/smach/smallFloat-spec
    asm volatile(
        "frep.o  %[nfrep], 2, 0, 0 \n"
        "vfmul.s %[vtmp], %[va], ft0\n"
        "vfadd.s ft2, %[vtmp], ft1\n"
        : [vtmp] "=&f"(vtmp)  // see [1]
        : [nfrep] "r"(nfrep), [va] "f"(va)
        : "ft0", "ft1", "ft2", "memory");

    snrt_fpu_fence();  // Syncronize integer and floating point pipelines that
                       // operate indipendently during frep loops
    snrt_ssr_disable();
}

// [1] According to the GNU docs:
// Rather than allocating fixed registers via clobbers to provide scratch registers
// for an asm statement, an alternative is to define a variable and make it an
// early-clobber [...]. This gives the compiler register allocator more freedom.
// Source:
// https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers-1
