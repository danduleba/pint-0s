/* Confere se a espera longa realmente bloqueia a thread. */
#include "devices/timer.h"
#include "tests/threads/tests.h"
#include "threads/interrupt.h"
#include "threads/synch.h"
#include "threads/thread.h"

struct sleep_probe
  {
    struct semaphore entered;
    struct semaphore finished;
    struct thread *sleeper;
    bool done;
  };

static void
sleep_worker (void *aux)
{
  struct sleep_probe *probe = aux;
  probe->sleeper = thread_current ();
  sema_up (&probe->entered);
  timer_sleep (TIMER_FREQ);
  probe->done = true;
  sema_up (&probe->finished);
}

void
test_alarm_blocked (void)
{
  struct sleep_probe probe;
  enum intr_level old_level;
  bool blocked;
  sema_init (&probe.entered, 0);
  sema_init (&probe.finished, 0);
  probe.sleeper = NULL;
  probe.done = false;
  if (thread_create ("sleep-probe", PRI_DEFAULT, sleep_worker, &probe)
      == TID_ERROR)
    fail ("Nao foi possivel criar a thread de teste.");
  sema_down (&probe.entered);
  timer_sleep (1);
  old_level = intr_disable ();
  /* Nao acessa o ponteiro se a thread ja tiver terminado. */
  blocked = !probe.done && probe.sleeper->status == THREAD_BLOCKED;
  intr_set_level (old_level);
  if (!blocked)
    fail ("A thread em espera nao ficou bloqueada.");
  sema_down (&probe.finished);
  pass ();
}
