*asyncio-runner.pyx*                          Last change: 2023 Sep 15

Runners
*******

**Source code:** Lib/asyncio/runners.py

This section outlines high-level asyncio primitives to run asyncio
code.

They are built on top of an event loop with the aim to simplify async
code usage for common wide-spread scenarios.

* Running an asyncio Program

* Runner context manager

* Handling Keyboard Interruption


Running an asyncio Program
==========================

                                           *run()..asyncio-runner.pyx*
asyncio.run(coro, *, debug=None, loop_factory=None)

   Execute the _coroutine_ _coro_ and return the result.

   This function runs the passed coroutine, taking care of managing
   the asyncio event loop, _finalizing asynchronous generators_, and
   closing the executor.

   This function cannot be called when another asyncio event loop is
   running in the same thread.

   If _debug_ is "True", the event loop will be run in debug mode.
   "False" disables debug mode explicitly. "None" is used to respect
   the global Debug Mode settings.

   If _loop_factory_ is not "None", it is used to create a new event
   loop; otherwise "asyncio.new_event_loop()" is used. The loop is
   closed at the end. This function should be used as a main entry
   point for asyncio programs, and should ideally only be called once.
   It is recommended to use _loop_factory_ to configure the event loop
   instead of policies.

   The executor is given a timeout duration of 5 minutes to shutdown.
   If the executor hasn’t finished within that duration, a warning is
   emitted and the executor is closed.

   Example:
>
      async def main():
          await asyncio.sleep(1)
          print('hello')

      asyncio.run(main())
<
   New in version 3.7.

   Changed in version 3.9: Updated to use
   "loop.shutdown_default_executor()".

   Changed in version 3.10: _debug_ is "None" by default to respect
   the global debug mode settings.

   Changed in version 3.12: Added _loop_factory_ parameter.


Runner context manager
======================

                                          *Runner..asyncio-runner.pyx*
class asyncio.Runner(*, debug=None, loop_factory=None)

   A context manager that simplifies _multiple_ async function calls
   in the same context.

   Sometimes several top-level async functions should be called in the
   same event loop and "contextvars.Context".

   If _debug_ is "True", the event loop will be run in debug mode.
   "False" disables debug mode explicitly. "None" is used to respect
   the global Debug Mode settings.

   _loop_factory_ could be used for overriding the loop creation. It
   is the responsibility of the _loop_factory_ to set the created loop
   as the current one. By default "asyncio.new_event_loop()" is used
   and set as current event loop with "asyncio.set_event_loop()" if
   _loop_factory_ is "None".

   Basically, "asyncio.run()" example can be rewritten with the runner
   usage:
>
      async def main():
          await asyncio.sleep(1)
          print('hello')

      with asyncio.Runner() as runner:
          runner.run(main())
<
   New in version 3.11.

   run(coro, *, context=None)          *Runner.run()..asyncio-runner.pyx*

      Run a _coroutine_ _coro_ in the embedded loop.

      Return the coroutine’s result or raise its exception.

      An optional keyword-only _context_ argument allows specifying a
      custom "contextvars.Context" for the _coro_ to run in. The
      runner’s default context is used if "None".

      This function cannot be called when another asyncio event loop
      is running in the same thread.

   close()                           *Runner.close()..asyncio-runner.pyx*

      Close the runner.

      Finalize asynchronous generators, shutdown default executor,
      close the event loop and release embedded "contextvars.Context".

   get_loop()                     *Runner.get_loop()..asyncio-runner.pyx*

      Return the event loop associated with the runner instance.

   Note:

     "Runner" uses the lazy initialization strategy, its constructor
     doesn’t initialize underlying low-level structures.Embedded
     _loop_ and _context_ are created at the "with" body entering or
     the first call of "run()" or "get_loop()".


Handling Keyboard Interruption
==============================

New in version 3.11.

When "signal.SIGINT" is raised by "Ctrl-C", "KeyboardInterrupt"
exception is raised in the main thread by default. However this
doesn’t work with "asyncio" because it can interrupt asyncio internals
and can hang the program from exiting.

To mitigate this issue, "asyncio" handles "signal.SIGINT" as follows:

1. "asyncio.Runner.run()" installs a custom "signal.SIGINT" handler
   before any user code is executed and removes it when exiting from
   the function.

2. The "Runner" creates the main task for the passed coroutine for its
   execution.

3. When "signal.SIGINT" is raised by "Ctrl-C", the custom signal
   handler cancels the main task by calling "asyncio.Task.cancel()"
   which raises "asyncio.CancelledError" inside the main task.  This
   causes the Python stack to unwind, "try/except" and "try/finally"
   blocks can be used for resource cleanup.  After the main task is
   cancelled, "asyncio.Runner.run()" raises "KeyboardInterrupt".

4. A user could write a tight loop which cannot be interrupted by
   "asyncio.Task.cancel()", in which case the second following
   "Ctrl-C" immediately raises the "KeyboardInterrupt" without
   cancelling the main task.

vim:tw=78:ts=8:ft=help:norl: