#include "data.h"

#include <stdint.h>

void pooling_nchw_sum_d1_s2_3x3(const double* x, double* y) {
    for (int row = 0; row < H - 3 + 1; row += 2) {
        for (int col = 0; col < W - 3 + 1; col += 2) {
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < C; j++) {
                    double sum = 0.0;
                    for (int k = 0; k < 3; k++) {
                        for (int l = 0; l < 3; l++) {
                            int x_index = (i * (C * H * W)) + (j * (H * W)) +
                                          ((row + k) * W) + (col + l);
                            double current_value = x[x_index];
                            sum += current_value;
                        }
                    }
                    // Store the sum in the corresponding position in y
                    int y_row = row / 2;
                    int y_col = col / 2;
                    int y_index = (i * (C * NEW_H * NEW_W)) + (j * (NEW_H * NEW_W)) +
                                  (y_row * NEW_W) + y_col;
                    y[y_index] = sum;
                }
            }
        }
    }
}