# PintOS - Alarm Clock

Implementação da atividade de Infraestrutura de Software. A função `timer_sleep()` bloqueia a thread usando um semáforo e uma fila ordenada pelo prazo de despertar, evitando espera ocupada.

## Compilar e testar

Ambiente: Linux ou Ubuntu no WSL, com GCC com suporte a 32 bits, binutils, make, Perl e QEMU.

Na raiz do repositório:

```bash
make                 # Compila o projeto
make testar-alarmes  # Verifica os sete testes do Alarm Clock
make validar         # Limpa, recompila e executa os testes novamente
make clean           # Remove os arquivos compilados
```

Os testes verificam prazos, esperas simultâneas, valores zero e negativos e o bloqueio real da thread. A bateria registrada no relatório teve sete testes executados em cinco rodadas, com 35 aprovações.

## Arquivos principais

- `src/devices/timer.c`: implementação do Alarm Clock.
- `src/tests/threads/`: testes.
- `evidencias.log`: registros do desenvolvimento.
- [dad.pdf](dad.pdf): relatório da atividade.

Base utilizada: [jhu-cs318/pintos](https://github.com/jhu-cs318/pintos).
