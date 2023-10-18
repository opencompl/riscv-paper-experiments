#include "ssr_api.h"

#include <stddef.h>
#include <stdint.h>

static void write_ssr_cfg(uint32_t reg, uint32_t dm, uint32_t value) {
    uint32_t addr = reg << 5u | dm;
    asm volatile(
        "scfgw %[value], %[addr]\n"
        ::[value] "r"(value), [addr] "r"(addr));
}

void snrt_fpu_fence(void) {
    unsigned tmp;
    asm volatile(
        "fmv.x.w %0, fa0\n"
        "mv      %0, %0\n"
        : "+r"(tmp)::"memory");
}

void snrt_ssr_enable(void) {
#ifdef __TOOLCHAIN_LLVM__
    __builtin_ssr_enable();
#else
    asm volatile("csrsi 0x7C0, 1\n");
#endif
}

void snrt_ssr_disable(void) {
#ifdef __TOOLCHAIN_LLVM__
    __builtin_ssr_disable();
#else
    asm volatile("csrci 0x7C0, 1\n");
#endif
}

void snrt_ssr_loop_1d(enum snrt_ssr_dm dm, size_t b0, size_t s0) {
    --b0;
    write_ssr_cfg(REG_BOUNDS + 0, dm, b0);
    size_t a = 0;
    write_ssr_cfg(REG_STRIDES + 0, dm, s0 - a);
    a += s0 * b0;
}

void snrt_ssr_loop_2d(enum snrt_ssr_dm dm, size_t b0, size_t b1, size_t s0, size_t s1) {
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

void snrt_ssr_loop_3d(enum snrt_ssr_dm dm, size_t b0, size_t b1, size_t b2, size_t s0,
                      size_t s1, size_t s2) {
    --b0;
    --b1;
    --b2;
    write_ssr_cfg(REG_BOUNDS + 0, dm, b0);
    write_ssr_cfg(REG_BOUNDS + 1, dm, b1);
    write_ssr_cfg(REG_BOUNDS + 2, dm, b2);
    size_t a = 0;
    write_ssr_cfg(REG_STRIDES + 0, dm, s0 - a);
    a += s0 * b0;
    write_ssr_cfg(REG_STRIDES + 1, dm, s1 - a);
    a += s1 * b1;
    write_ssr_cfg(REG_STRIDES + 2, dm, s2 - a);
    a += s2 * b2;
}

void snrt_ssr_loop_4d(enum snrt_ssr_dm dm, size_t b0, size_t b1, size_t b2, size_t b3,
                      size_t s0, size_t s1, size_t s2, size_t s3) {
    --b0;
    --b1;
    --b2;
    --b3;
    write_ssr_cfg(REG_BOUNDS + 0, dm, b0);
    write_ssr_cfg(REG_BOUNDS + 1, dm, b1);
    write_ssr_cfg(REG_BOUNDS + 2, dm, b2);
    write_ssr_cfg(REG_BOUNDS + 3, dm, b3);
    size_t a = 0;
    write_ssr_cfg(REG_STRIDES + 0, dm, s0 - a);
    a += s0 * b0;
    write_ssr_cfg(REG_STRIDES + 1, dm, s1 - a);
    a += s1 * b1;
    write_ssr_cfg(REG_STRIDES + 2, dm, s2 - a);
    a += s2 * b2;
    write_ssr_cfg(REG_STRIDES + 3, dm, s3 - a);
    a += s3 * b3;
}

void snrt_ssr_repeat(enum snrt_ssr_dm dm, size_t count) {
    write_ssr_cfg(REG_REPEAT, dm, count - 1);
}

void snrt_ssr_read(enum snrt_ssr_dm dm, enum snrt_ssr_dim dim, volatile void *ptr) {
    write_ssr_cfg(REG_RPTR + dim, dm, (uintptr_t)ptr);
}

void snrt_ssr_write(enum snrt_ssr_dm dm, enum snrt_ssr_dim dim, volatile void *ptr) {
    write_ssr_cfg(REG_WPTR + dim, dm, (uintptr_t)ptr);
}
