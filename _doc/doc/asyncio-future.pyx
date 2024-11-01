*asyncio-future.pyx*                          Last change: 2023 Sep 15

Futures
*******

**Source code:** Lib/asyncio/futures.py, Lib/asyncio/base_futures.py

======================================================================

_Future_ objects are used to bridge **low-level callback-based code**
with high-level async/await code.


Future Functions
================

asyncio.isfuture(obj)                 *isfuture()..asyncio-future.pyx*

   Return "True" if _obj_ is either of:

   * an instance of "asyncio.Future",

   * an instance of "asyncio.Task",

   * a Future-like object with a "_asyncio_future_blocking" attribute.

   New in version 3.5.

                                 *ensure_future()..asyncio-future.pyx*
asyncio.ensure_future(obj, *, loop=None)

   Return:

   * _obj_ argument as is, if _obj_ is a "Future", a "Task", or a
     Future-like object ("isfuture()" is used for the test.)

   * a "Task" object wrapping _obj_, if _obj_ is a coroutine
     ("iscoroutine()" is used for the test); in this case the
     coroutine will be scheduled by "ensure_future()".

   * a "Task" object that would await on _obj_, if _obj_ is an
     awaitable ("inspect.isawaitable()" is used for the test.)

   If _obj_ is neither of the above a "TypeError" is raised.

   Important:

     See also the "create_task()" function which is the preferred way
     for creating new Tasks.Save a reference to the result of this
     function, to avoid a task disappearing mid-execution.

   Changed in version 3.5.1: The function accepts any _awaitable_
   object.

   Deprecated since version 3.10: Deprecation warning is emitted if
   _obj_ is not a Future-like object and _loop_ is not specified and
   there is no running event loop.

                                   *wrap_future()..asyncio-future.pyx*
asyncio.wrap_future(future, *, loop=None)

   Wrap a "concurrent.futures.Future" object in a "asyncio.Future"
   object.

   Deprecated since version 3.10: Deprecation warning is emitted if
   _future_ is not a Future-like object and _loop_ is not specified
   and there is no running event loop.


Future Object
=============

class asyncio.Future(*, loop=None)        *Future..asyncio-future.pyx*

   A Future represents an eventual result of an asynchronous
   operation.  Not thread-safe.

   Future is an _awaitable_ object.  Coroutines can await on Future
   objects until they either have a result or an exception set, or
   until they are cancelled. A Future can be awaited multiple times
   and the result is same.

   Typically Futures are used to enable low-level callback-based code
   (e.g. in protocols implemented using asyncio transports) to
   interoperate with high-level async/await code.

   The rule of thumb is to never expose Future objects in user-facing
   APIs, and the recommended way to create a Future object is to call
   "loop.create_future()".  This way alternative event loop
   implementations can inject their own optimized implementations of a
   Future object.

   Changed in version 3.7: Added support for the "contextvars" module.

   Deprecated since version 3.10: Deprecation warning is emitted if
   _loop_ is not specified and there is no running event loop.

   result()                         *Future.result()..asyncio-future.pyx*

      Return the result of the Future.

      If the Future is _done_ and has a result set by the
      "set_result()" method, the result value is returned.

      If the Future is _done_ and has an exception set by the
      "set_exception()" method, this method raises the exception.

      If the Future has been _cancelled_, this method raises a
      "CancelledError" exception.

      If the Future’s result isn’t yet available, this method raises a
      "InvalidStateError" exception.

   set_result(result)           *Future.set_result()..asyncio-future.pyx*

      Mark the Future as _done_ and set its result.

      Raises a "InvalidStateError" error if the Future is already
      _done_.

                          *Future.set_exception()..asyncio-future.pyx*
   set_exception(exception)

      Mark the Future as _done_ and set an exception.

      Raises a "InvalidStateError" error if the Future is already
      _done_.

   done()                             *Future.done()..asyncio-future.pyx*

      Return "True" if the Future is _done_.

      A Future is _done_ if it was _cancelled_ or if it has a result
      or an exception set with "set_result()" or "set_exception()"
      calls.

   cancelled()                   *Future.cancelled()..asyncio-future.pyx*

      Return "True" if the Future was _cancelled_.

      The method is usually used to check if a Future is not
      _cancelled_ before setting a result or an exception for it:
>
         if not fut.cancelled():
             fut.set_result(42)
<

                      *Future.add_done_callback()..asyncio-future.pyx*
   add_done_callback(callback, *, context=None)

      Add a callback to be run when the Future is _done_.

      The _callback_ is called with the Future object as its only
      argument.

      If the Future is already _done_ when this method is called, the
      callback is scheduled with "loop.call_soon()".

      An optional keyword-only _context_ argument allows specifying a
      custom "contextvars.Context" for the _callback_ to run in. The
      current context is used when no _context_ is provided.

      "functools.partial()" can be used to pass parameters to the
      callback, e.g.:
>
         # Call 'print("Future:", fut)' when "fut" is done.
         fut.add_done_callback(
             functools.partial(print, "Future:"))
<
      Changed in version 3.7: The _context_ keyword-only parameter was
      added. See **PEP 567** for more details.

                   *Future.remove_done_callback()..asyncio-future.pyx*
   remove_done_callback(callback)

      Remove _callback_ from the callbacks list.

      Returns the number of callbacks removed, which is typically 1,
      unless a callback was added more than once.

   cancel(msg=None)                 *Future.cancel()..asyncio-future.pyx*

      Cancel the Future and schedule callbacks.

      If the Future is already _done_ or _cancelled_, return "False".
      Otherwise, change the Future’s state to _cancelled_, schedule
      the callbacks, and return "True".

      Changed in version 3.9: Added the _msg_ parameter.

   exception()                   *Future.exception()..asyncio-future.pyx*

      Return the exception that was set on this Future.

      The exception (or "None" if no exception was set) is returned
      only if the Future is _done_.

      If the Future has been _cancelled_, this method raises a
      "CancelledError" exception.

      If the Future isn’t _done_ yet, this method raises an
      "InvalidStateError" exception.

   get_loop()                     *Future.get_loop()..asyncio-future.pyx*

      Return the event loop the Future object is bound to.

      New in version 3.7.

This example creates a Future object, creates and schedules an
asynchronous Task to set result for the Future, and waits until the
Future has a result:
>
   async def set_after(fut, delay, value):
       # Sleep for *delay* seconds.
       await asyncio.sleep(delay)

       # Set *value* as a result of *fut* Future.
       fut.set_result(value)

   async def main():
       # Get the current event loop.
       loop = asyncio.get_running_loop()

       # Create a new Future object.
       fut = loop.create_future()

       # Run "set_after()" coroutine in a parallel Task.
       # We are using the low-level "loop.create_task()" API here because
       # we already have a reference to the event loop at hand.
       # Otherwise we could have just used "asyncio.create_task()".
       loop.create_task(
           set_after(fut, 1, '... world'))

       print('hello ...')

       # Wait until *fut* has a result (1 second) and print it.
       print(await fut)

   asyncio.run(main())
<
Important:

  The Future object was designed to mimic "concurrent.futures.Future".
  Key differences include:

  * unlike asyncio Futures, "concurrent.futures.Future" instances
    cannot be awaited.

  * "asyncio.Future.result()" and "asyncio.Future.exception()" do not
    accept the _timeout_ argument.

  * "asyncio.Future.result()" and "asyncio.Future.exception()" raise
    an "InvalidStateError" exception when the Future is not _done_.

  * Callbacks registered with "asyncio.Future.add_done_callback()" are
    not called immediately.  They are scheduled with
    "loop.call_soon()" instead.

  * asyncio Future is not compatible with the
    "concurrent.futures.wait()" and
    "concurrent.futures.as_completed()" functions.

  * "asyncio.Future.cancel()" accepts an optional "msg" argument, but
    "concurrent.futures.Future.cancel()" does not.

vim:tw=78:ts=8:ft=help:norl: