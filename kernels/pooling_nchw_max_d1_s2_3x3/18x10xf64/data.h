#pragma once

#define N 1
#define C 1
#define H 18
#define W 10
#define NEW_H 8
#define NEW_W 4

extern const double X[N * C * H * W];
extern const double Y_IN[N * C * NEW_H * NEW_W];
extern const double Y_OUT[N * C * NEW_H * NEW_W];

// volatile const int TEST_COUNT = 1;
volatile const int TEST_COUNT = N * C * NEW_H * NEW_W;

