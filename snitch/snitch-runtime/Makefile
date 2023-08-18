SNITCH_RUNTIME_DIRNAME := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(SNITCH_RUNTIME_DIRNAME)/../Makefile.rules

# Default install prefix:
PREFIX ?= $(SNITCH_RUNTIME_DIRNAME)/install

OBJS =
OBJS += alloc.o
OBJS += barrier.o
OBJS += dma.o
OBJS += interrupt.o
OBJS += memcpy.o
OBJS += perf_cnt.o
OBJS += printf.o
OBJS += putchar.o
OBJS += ssr.o
OBJS += start.o
OBJS += team.o
OBJS += start_snitch_rtl.o

CFLAGS += -I $(SNITCH_RUNTIME_DIRNAME)/include
CFLAGS += -Wall -Wextra

all: libsnitch-runtime.a

libsnitch-runtime.a: $(OBJS)
	$(AR) rc $@ $^
	$(RANLIB) $@

install: libsnitch-runtime.a
	mkdir -p $(PREFIX)/lib
	cp -f libsnitch-runtime.a $(PREFIX)/lib
	cp -fr include $(PREFIX)/

clean:
	rm -f *.a *.o

