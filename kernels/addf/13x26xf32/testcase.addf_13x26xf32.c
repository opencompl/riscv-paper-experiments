#include "testcase.h"

#include "data_13x26xf32.h"

// Defined by the actual kernel source.
void addf(float* A, const float* B);

void testcase_get(struct testcase* test) {
    struct testcase t = {
        .Kernel = addf,
        .m = M,
        .n = N,
        .A = A,
        .B = B,
        .Expected = A_PLUS_B,
    };
    *test = t;
}
