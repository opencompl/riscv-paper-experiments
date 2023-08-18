#include <mlir-memref-alloc.h>

// FIXME it's impossible to include the actual snitch-runtime headers the
// way they are written right now. Let's declare stuff here and pray the abi gods.
void *snrt_l1alloc(size_t);
//

void *_mlir_memref_to_llvm_alloc(size_t size) { return snrt_l1alloc(size); }

void _mlir_memref_to_llvm_free(void *ptr) {
    (void)ptr;
    // For the current Snitch Runtime bump allocator,
    // free is a no-op.
}
