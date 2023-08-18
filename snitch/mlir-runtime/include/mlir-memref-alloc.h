#pragma once

#include <stdlib.h>

//===----------------------------------------------------------------------===//
// Support library for the LLVM IR Target. See:
// https://mlir.llvm.org/docs/TargetLLVMIR/#generic-alloction-and-deallocation-functions
//===----------------------------------------------------------------------===//

void *_mlir_memref_to_llvm_alloc(size_t size);
void _mlir_memref_to_llvm_free(void *ptr);
