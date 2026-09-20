/* Tests timer_sleep(0), which should return immediately. */

#include <stdio.h>
#include "tests/threads/tests.h"
#include "threads/malloc.h"
#include "threads/synch.h"
#include "threads/thread.h"
#include "threads/interrupt.h"
#include "devices/timer.h"

void
test_alarm_zero (void) 
{
  int i;
  for (i = 0; i < 100; i++)
    {
      timer_sleep (0);
      ASSERT (intr_get_level () == INTR_ON);
    }
  /* Uma espera normal ainda deve funcionar depois dos retornos imediatos. */
  timer_sleep (1);
  pass ();
}
