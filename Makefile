.PHONY: all clean demonstrar testar-basico testar-concorrencia testar-alarmes validar

all:
	$(MAKE) -C src/utils setitimer-helper
	$(MAKE) -C src/threads

# Verifica se a espera respeita o prazo minimo solicitado.
demonstrar: all
	cd src/threads/build && ../../utils/pintos --qemu --no-vga -T 30 -- -q run alarm-minimum

testar-basico: all
	cd src/threads/build && PATH="$(CURDIR)/src/utils:$$PATH" $(MAKE) tests/threads/alarm-zero.result tests/threads/alarm-negative.result tests/threads/alarm-minimum.result
	grep -qx PASS src/threads/build/tests/threads/alarm-zero.result
	grep -qx PASS src/threads/build/tests/threads/alarm-negative.result
	grep -qx PASS src/threads/build/tests/threads/alarm-minimum.result

clean:
	$(MAKE) -C src/threads clean
	$(MAKE) -C src/utils clean

# Confere repeticoes de espera e threads com o mesmo prazo.
testar-concorrencia: all
	cd src/threads/build && PATH="$(CURDIR)/src/utils:$$PATH" $(MAKE) tests/threads/alarm-multiple.result tests/threads/alarm-simultaneous.result
	grep -qx PASS src/threads/build/tests/threads/alarm-multiple.result
	grep -qx PASS src/threads/build/tests/threads/alarm-simultaneous.result

ALARMES = alarm-single alarm-multiple alarm-simultaneous alarm-zero \
          alarm-negative alarm-minimum alarm-blocked
RESULTADOS = $(addprefix tests/threads/,$(addsuffix .result,$(ALARMES)))

testar-alarmes: all
	cd src/threads/build && PATH="$(CURDIR)/src/utils:$$PATH" $(MAKE) $(RESULTADOS)
	@for teste in $(ALARMES); do \
	  grep -qx PASS src/threads/build/tests/threads/$$teste.result || exit 1; \
	  printf '%s: PASS\n' "$$teste"; \
	done

# Recompila do zero para nao reutilizar resultados de execucoes anteriores.
validar:
	$(MAKE) clean
	$(MAKE) testar-alarmes
