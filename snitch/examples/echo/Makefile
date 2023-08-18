# Example makefile
# By including 'Makefile.rules', proper rules for .ll, .c and for building the
# runtime are in place, the only missing thing we have to deal with here is
# the actual dependencies of the final target

include ../../Makefile.rules

SNITCH_RUNTIME_PREFIX ?= /opt/snitch-runtime

OBJS =
OBJS += echo.o
OBJS += main.o

CFLAGS += -I$(SNITCH_RUNTIME_PREFIX)/include
CFLAGS += -Wall -Wextra -pedantic

echo.x: $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $^ -o $@

run: echo.x
	/opt/snitch-rtl/bin/snitch_cluster.vlt $<

logs/trace_hart_%.txt: logs/trace_hart_%.dasm ../../gentrace.py
	/opt/snitch-spike/bin/spike-dasm < $< | ../../gentrace.py > $@

traces: $(shell (ls logs/trace_hart_*.dasm 2>/dev/null | sed 's/\.dasm/\.txt/') || echo "")

clean:
	rm -fr *.o *.a *.ll12 echo.x logs/
