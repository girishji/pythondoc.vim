*asyncio.pyx*                                 Last change: 2023 Sep 15

"asyncio" — Asynchronous I/O
****************************

======================================================================


Hello World!
^^^^^^^^^^^^
>
   import asyncio

   async def main():
       print('Hello ...')
       await asyncio.sleep(1)
       print('... World!')

   asyncio.run(main())
<
asyncio is a library to write **concurrent** code using the
**async/await** syntax.

asyncio is used as a foundation for multiple Python asynchronous
frameworks that provide high-performance network and web-servers,
database connection libraries, distributed task queues, etc.

asyncio is often a perfect fit for IO-bound and high-level
**structured** network code.

asyncio provides a set of **high-level** APIs to:

* run Python coroutines concurrently and have full control over their
  execution;

* perform network IO and IPC;

* control subprocesses;

* distribute tasks via queues;

* synchronize concurrent code;

Additionally, there are **low-level** APIs for _library and framework
developers_ to:

* create and manage event loops, which provide asynchronous APIs for
  "networking", running "subprocesses", handling "OS signals", etc;

* implement efficient protocols using transports;

* bridge callback-based libraries and code with async/await syntax.

You can experiment with an "asyncio" concurrent context in the REPL:
>
   $ python -m asyncio
   asyncio REPL ...
   Use "await" directly instead of "asyncio.run()".
   Type "help", "copyright", "credits" or "license" for more information.
   >>> import asyncio
   >>> await asyncio.sleep(10, result='hello')
   'hello'
<
Availability: not Emscripten, not WASI.

This module does not work or is not available on WebAssembly platforms
"wasm32-emscripten" and "wasm32-wasi". See WebAssembly platforms for
more information.

-[ Reference ]-


High-level APIs
^^^^^^^^^^^^^^^

* Runners

* Coroutines and Tasks

* Streams

* Synchronization Primitives

* Subprocesses

* Queues

* Exceptions


Low-level APIs
^^^^^^^^^^^^^^

* Event Loop

* Futures

* Transports and Protocols

* Policies

* Platform Support

* Extending


Guides and Tutorials
^^^^^^^^^^^^^^^^^^^^

* High-level API Index

* Low-level API Index

* Developing with asyncio

Note:

  The source code for asyncio can be found in Lib/asyncio/.

vim:tw=78:ts=8:ft=help:norl: