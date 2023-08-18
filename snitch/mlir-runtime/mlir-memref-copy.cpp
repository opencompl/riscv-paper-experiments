#include <mlir-memref-copy.hpp>

#include <cstring>

// FIXME it's impossible to include the actual snitch-runtime headers the
// way they are written right now. Let's declare stuff here and pray the abi gods.
extern "C" void *snrt_l1alloc(size_t);
//

//===----------------------------------------------------------------------===//
// Small runtime support library for memref.copy lowering during codegen.
//===----------------------------------------------------------------------===//

extern "C" void memrefCopy(int64_t elemSize, UnrankedMemRefType<char> *srcArg,
                           UnrankedMemRefType<char> *dstArg) {
  DynamicMemRefType<char> src(*srcArg);
  DynamicMemRefType<char> dst(*dstArg);

  int32_t rank = src.rank;

  // Handle empty shapes -> nothing to copy.
  for (int rankp = 0; rankp < rank; ++rankp)
    if (src.sizes[rankp] == 0)
      return;

  char *srcPtr = src.data + src.offset * elemSize;
  char *dstPtr = dst.data + dst.offset * elemSize;

  if (rank == 0) {
    memcpy(dstPtr, srcPtr, elemSize);
    return;
  }

  int32_t *indices =
      static_cast<int32_t *>(::snrt_l1alloc(sizeof(int32_t) * rank));
  int32_t *srcStrides =
      static_cast<int32_t *>(::snrt_l1alloc(sizeof(int32_t) * rank));
  int32_t *dstStrides =
      static_cast<int32_t *>(::snrt_l1alloc(sizeof(int32_t) * rank));

  // Initialize index and scale strides.
  for (int rankp = 0; rankp < rank; ++rankp) {
    indices[rankp] = 0;
    srcStrides[rankp] = /* src.strides[rankp] */ 1 * elemSize;
    dstStrides[rankp] = /* dst.strides[rankp] */ 1 * elemSize;
  }

  int32_t readIndex = 0, writeIndex = 0;
  for (;;) {
    // Copy over the element, byte by byte.
    memcpy(dstPtr + writeIndex, srcPtr + readIndex, elemSize);
    // Advance index and read position.
    for (int32_t axis = rank - 1; axis >= 0; --axis) {
      // Advance at current axis.
      auto newIndex = ++indices[axis];
      readIndex += srcStrides[axis];
      writeIndex += dstStrides[axis];
      // If this is a valid index, we have our next index, so continue copying.
      if (src.sizes[axis] != newIndex)
        break;
      // We reached the end of this axis. If this is axis 0, we are done.
      if (axis == 0)
        return;
      // Else, reset to 0 and undo the advancement of the linear index that
      // this axis had. Then continue with the axis one outer.
      indices[axis] = 0;
      readIndex -= src.sizes[axis] * srcStrides[axis];
      writeIndex -= dst.sizes[axis] * dstStrides[axis];
    }
  }
}
