#define KERNEL_SIZE 8

int main() {
  int a[KERNEL_SIZE] = {1, 2, 3, 4, 5, 6, 7, 8};
  int b[KERNEL_SIZE] = {1, 2, 3, 4, 5, 6, 7, 8};
  int c = 0;

  for (int i = 0; i < KERNEL_SIZE; i++) {
    c += a[i] * b[i];
  }

  // prevent compiler from optimizing out the loop
  return c;
}