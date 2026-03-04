#include "include data.h"

#ifdef __cplusplus
extern "C" {
#endif

void vexpf_kernel(double *a, double *b) {
    vexpf_baseline(a, b);
}

#ifdef __cplusplus
}
#endif