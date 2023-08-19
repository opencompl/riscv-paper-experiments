#pragma once

// To have a fair comparison vs the mlir side of things where memrefs
// are statically sized, we are using macros for the bounds
#define M 13
#define N 26

extern const float A[M * N];
extern const float B[M * N];
extern const float A_PLUS_B[M * N];
