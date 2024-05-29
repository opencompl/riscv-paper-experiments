#pragma once

#define N 1
#define C 1
#define H 18
#define W 34
#define NEW_H 8
#define NEW_W 16

extern const double X[N * C * H * W];
extern const double Y_IN[N * C * NEW_H * NEW_W];
extern const double Y_OUT[N * C * NEW_H * NEW_W];

#define TEST_COUNT (N * C * NEW_H * NEW_W)

