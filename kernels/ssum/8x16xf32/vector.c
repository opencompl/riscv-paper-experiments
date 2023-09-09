#include "data.h"

#include <stdint.h>

void ssum(const float* x, const float* y, float* z) {
    typedef float v2f32 __attribute__((vector_size(2 * sizeof(float))));
    const v2f32* x_vec = (v2f32*)x;
    const v2f32* y_vec = (v2f32*)y;
    v2f32* z_vec = (v2f32*)z;

    const uint32_t niter = (M * N) / 2;

    for (uint32_t i = 0; i < niter; ++i) {
        v2f32 x_elem = x_vec[i];
        v2f32 y_elem = y_vec[i];
        v2f32 z_elem = x_elem + y_elem;
        z_vec[i] = z_elem;
    }
}
