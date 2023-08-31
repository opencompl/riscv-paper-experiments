#pragma once

#define ALPHA 1.0f
#define BETA 1.0f

#define M 16
#define N 16
#define K 16

#define TRANSA 'n'
#define LDA K

#define TRANSB 'n'
#define LDB N

#define LDC N

extern const float A[M * K];
extern const float B[K * N];
