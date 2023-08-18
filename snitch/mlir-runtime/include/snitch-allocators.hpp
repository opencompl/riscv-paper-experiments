// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

//===----------------------------------------------------------------------===//
// Standard-compliant allocator shims to enable using (some) STL containers
// on Snitch.
// Note: all of the allocators leverage the bump allocators provided by the
// Snitch runtime, a.k.a. all deallocations are no-ops.
//===----------------------------------------------------------------------===//

#pragma once

#include <cstddef>
#include <cstdlib>

// FIXME it's impossible to include the actual snitch-runtime headers the
// way they are written right now. Let's declare stuff here and pray the abi gods.
extern "C" void *snrt_l1alloc(size_t);
extern "C" void *snrt_l3alloc(size_t);
//

namespace snitch {

template <class T>
class l1_allocator {
public:
  using value_type = T;

  l1_allocator() = default;

  template <class U>
  l1_allocator(l1_allocator<U> const &) noexcept {}

  value_type *allocate(std::size_t n) {
    return static_cast<value_type *>(::snrt_l1alloc(n * sizeof(value_type)));
  }

  void deallocate(value_type *, std::size_t) noexcept {
    // For the current Snitch runtime bump allocator,
    // free is a no-op.
  }
};

template <class T, class U>
bool operator==(l1_allocator<T> const &, l1_allocator<U> const &) noexcept {
  return true;
}

template <class T, class U>
bool operator!=(l1_allocator<T> const &x, l1_allocator<U> const &y) noexcept {
  return !(x == y);
}

template <class T>
class l3_allocator {
public:
  using value_type = T;

  l3_allocator() = default;

  template <class U>
  l3_allocator(l3_allocator<U> const &) noexcept {}

  value_type *allocate(std::size_t n) {
    return static_cast<value_type *>(::snrt_l3alloc(n * sizeof(value_type)));
  }

  void deallocate(value_type *, std::size_t) noexcept {
    // For the current Snitch runtime bump allocator,
    // free is a no-op.
  }
};

template <class T, class U>
bool operator==(l3_allocator<T> const &, l3_allocator<U> const &) noexcept {
  return true;
}

template <class T, class U>
bool operator!=(l3_allocator<T> const &x, l3_allocator<U> const &y) noexcept {
  return !(x == y);
}

} // namespace snitch
