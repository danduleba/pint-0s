/* Verifica o contrato: nunca retornar antes do prazo solicitado. */
#include <inttypes.h>
#include "devices/timer.h"
#include "tests/threads/tests.h"

void
test_alarm_minimum (void)
{
  int64_t start = timer_ticks ();
  int64_t elapsed;
  timer_sleep (100);
  elapsed = timer_elapsed (start);
  msg ("Solicitado: 100 ticks; observado: %"PRId64" ticks", elapsed);
  if (elapsed < 100)
    fail ("A thread acordou antes do prazo solicitado.");
  pass ();
}
