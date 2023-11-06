#include "data.h"

#include <snrt.h>

#include <stdint.h>

// Taken from math.h
#define MAXFLOAT 0x1.fffffep+127f

void pooling_nchw_max_d1_s2_3x3(const double* x, double* y) {
    for (int row = 0; row < H - 3 + 1; row += 2) {
        for (int col = 0; col < W - 3 + 1; col += 2) {
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < C; j++) {
                    double max_value = -MAXFLOAT;
                    for (int k = 0; k < 3; k++) {
                        for (int l = 0; l < 3; l++) {
                            int x_index = (i * (C * H * W)) + (j * (H * W)) +
                                          ((row + k) * W) + (col + l);
                            double current_value = x[x_index];
                            if (current_value > max_value) {
                                max_value = current_value;
                            }
                        }
                    }
                    // Store the maximum value in the corresponding position in y
                    int y_row = row / 2;
                    int y_col = col / 2;
                    int y_index = (i * (C * NEW_H * NEW_W)) + (j * (NEW_H * NEW_W)) +
                                  (y_row * NEW_W) + y_col;
                    y[y_index] = max_value;
                }
            }
        }
    }
}
