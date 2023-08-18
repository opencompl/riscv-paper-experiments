#pragma once

#include <stdint.h>

//===----------------------------------------------------------------------===//
// Small runtime support library for vector.print lowering during codegen.
//===----------------------------------------------------------------------===//

void printI64(int64_t i);
void printU64(uint64_t u);
void printF32(float f);
void printF64(double d);
void printOpen();
void printClose();
void printComma();
void printNewline();