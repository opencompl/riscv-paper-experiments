#pragma once

#define M 16
#define N 32

extern const double X;
extern const double Y[M * N];

// volatile const int TEST_COUNT = 1;
volatile const int TEST_COUNT = M * N;
