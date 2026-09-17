.PHONY: all clean demonstrar testar-basico

all:
	$(MAKE) -C src/utils setitimer-helper
	$(MAKE) -C src/threads

# O teste deve falhar nesta etapa: o erro proposital continua no codigo.
demonstrar: all
	cd src/threads/build && ../../utils/pintos --qemu --no-vga -T 30 -- -q run alarm-minimum

testar-basico: all
	cd src/threads/build && PATH="$(CURDIR)/src/utils:$$PATH" $(MAKE) tests/threads/alarm-zero.result tests/threads/alarm-negative.result tests/threads/alarm-minimum.result

clean:
	$(MAKE) -C src/threads clean
	$(MAKE) -C src/utils clean
