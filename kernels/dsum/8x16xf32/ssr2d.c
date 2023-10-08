#include "data.h"

#include <snrt.h>

#include <stdint.h>

void ssum(double* x, double* y, double* z) {
    const uint32_t m = M;
    const uint32_t n = N;

    uint32_t dm = 0;
    uint32_t b0 = m;
    uint32_t b1 = n;
    uint32_t s0 = n * sizeof(double);
    uint32_t s1 = sizeof(double);

    --b0;
    --b1;
    write_ssr_cfg(REG_BOUNDS + 0, dm, b0);
    write_ssr_cfg(REG_BOUNDS + 1, dm, b1);
    size_t a = 0;
    write_ssr_cfg(REG_STRIDES + 0, dm, s0 - a);
    a += s0 * b0;
    write_ssr_cfg(REG_STRIDES + 1, dm, s1 - a);
    a += s1 * b1;
}
