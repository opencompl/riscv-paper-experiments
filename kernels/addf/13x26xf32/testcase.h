#pragma once

#include <stdint.h>

struct testcase {
    void (*Kernel)(float*, const float*);
    uint32_t m;
    uint32_t n;
    // Note: pointers below should be const since they
    // are going to refer to global const stuff laid
    // out by the linker in read-only elf sections
    const float* A;
    const float* B;
    const float* Expected;
};

// Platform-specific test case runner.
// Each platform (e.g.: snitch, linux/amd64) must provide its own definition.
int32_t testcase_run(void);

// Test-specific test case factory.
// Each test case (e.g.: addf_13x26xf32, addf_20x20xf32, etc...) must provide
// its own definition.
void testcase_get(struct testcase* test);
