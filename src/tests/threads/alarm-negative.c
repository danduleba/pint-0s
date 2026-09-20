/* Tests timer_sleep(-100).  Only requirement is that it not crash. */

#include <stdio.h>
#include "tests/threads/tests.h"
#include "threads/malloc.h"
#include "threads/synch.h"
#include "threads/thread.h"
#include "threads/interrupt.h"
#include "devices/timer.h"

void
test_alarm_negative (void) 
{
  static const int64_t durations[] = {-1, -100, INT64_MIN};
  unsigned i;
  for (i = 0; i < sizeof durations / sizeof *durations; i++)
    {
      timer_sleep (durations[i]);
      ASSERT (intr_get_level () == INTR_ON);
    }
  timer_sleep (1);
  pass ();
}
