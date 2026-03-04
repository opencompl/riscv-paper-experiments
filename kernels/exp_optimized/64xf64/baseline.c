#include "../vexpf_optimized_v2.h"

#ifdef __cplusplus
extern "C" {
#endif

void vexpf_kernel(double *a, double *b) {
    vexpf_optimized_v2(a, b);
}

#ifdef __cplusplus
}
#endif