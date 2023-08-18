#include <mlir-vector.h>

// FIXME it's impossible to include the actual snitch-runtime headers the
// way they are written right now. Let's declare stuff here and pray the abi gods.
void snrt_putchar(char);
int printf_(const char* format, ...);
//

void printI64(int64_t i) { printf_("%lld", i); }

void printU64(uint64_t u) { printf_("%llu", u); }

void printF32(float f) { printf_("%g", f); }

void printF64(double d) { printf_("%lg", d); }

void printOpen() {
  snrt_putchar('(');
  snrt_putchar(' ');
}

void printClose() {
  snrt_putchar(' ');
  snrt_putchar(')');
}

void printComma() {
  snrt_putchar(',');
  snrt_putchar(' ');
}

void printNewline() { snrt_putchar('\n'); }
