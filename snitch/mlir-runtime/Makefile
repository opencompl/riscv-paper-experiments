MLIR_RUNTIME_DIRNAME := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(MLIR_RUNTIME_DIRNAME)/../Makefile.rules

# Default install prefix:
PREFIX ?= $(MLIR_RUNTIME_DIRNAME)/install

OBJS = mlir-memref-alloc.o

CFLAGS += -I $(MLIR_RUNTIME_DIRNAME)/include

all: libmlir-runtime.a

libmlir-runtime.a: $(OBJS)
	$(AR) rc $@ $^
	$(RANLIB) $@

install: libmlir-runtime.a
	mkdir -p $(PREFIX)/lib
	cp -f libmlir-runtime.a $(PREFIX)/lib
	cp -fr include $(PREFIX)/

clean:
	rm -f *.a *.o
