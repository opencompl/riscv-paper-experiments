# Example makefile
# By including 'Makefile.rules', proper rules for .ll, .c and for building the
# runtime are in place, the only missing thing we have to deal with here is
# the actual dependencies of the final target

include ../../Makefile.rules

SNITCH_RUNTIME_PREFIX ?= ../../install

OBJS =
OBJS += echo.o
OBJS += main.o

CFLAGS += -I$(SNITCH_RUNTIME_PREFIX)/include
CFLAGS += -Wall -Wextra -pedantic

echo.x: $(OBJS)
	$(LD) $(LDFLAGS) $(SNITCH_RUNTIME_PREFIX)/lib/libsnitch-runtime.a $^ -o $@

run: echo.x
	/opt/snitch-rtl/bin/snitch_cluster.vlt $<

clean:
	rm -f *.o *.a *.ll12 echo.x
