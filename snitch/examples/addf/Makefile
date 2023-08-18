include ../../Makefile.rules

SNITCH_RUNTIME_PREFIX ?= ../../install
MLIR_RUNTIME_PREFIX ?= $(SNITCH_RUNTIME_PREFIX)

OBJS =
OBJS += addf.o
OBJS += main.o

CFLAGS += -I$(SNITCH_RUNTIME_PREFIX)/include
CFLAGS += -Wall -Wextra -pedantic

addf.x: $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $(MLIR_RUNTIME_PREFIX)/lib/libmlir-runtime.a $^ -o $@

run: addf.x
	/opt/snitch-rtl/bin/snitch_cluster.vlt $<

clean:
	rm -f *.o *.a *.ll12 addf.x
