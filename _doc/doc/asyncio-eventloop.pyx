*asyncio-eventloop.pyx*                       Last change: 2023 Sep 15

Event Loop
**********

**Source code:** Lib/asyncio/events.py, Lib/asyncio/base_events.py

======================================================================

-[ Preface ]-

The event loop is the core of every asyncio application. Event loops
run asynchronous tasks and callbacks, perform network IO operations,
and run subprocesses.

Application developers should typically use the high-level asyncio
functions, such as "asyncio.run()", and should rarely need to
reference the loop object or call its methods.  This section is
intended mostly for authors of lower-level code, libraries, and
frameworks, who need finer control over the event loop behavior.

-[ Obtaining the Event Loop ]-

The following low-level functions can be used to get, set, or create
an event loop:

                           *get_running_loop()..asyncio-eventloop.pyx*
asyncio.get_running_loop()

   Return the running event loop in the current OS thread.

   Raise a "RuntimeError" if there is no running event loop.

   This function can only be called from a coroutine or a callback.

   New in version 3.7.

asyncio.get_event_loop()     *get_event_loop()..asyncio-eventloop.pyx*

   Get the current event loop.

   When called from a coroutine or a callback (e.g. scheduled with
   call_soon or similar API), this function will always return the
   running event loop.

   If there is no running event loop set, the function will return the
   result of the "get_event_loop_policy().get_event_loop()" call.

   Because this function has rather complex behavior (especially when
   custom event loop policies are in use), using the
   "get_running_loop()" function is preferred to "get_event_loop()" in
   coroutines and callbacks.

   As noted above, consider using the higher-level "asyncio.run()"
   function, instead of using these lower level functions to manually
   create and close an event loop.

   Deprecated since version 3.12: Deprecation warning is emitted if
   there is no current event loop. In some future Python release this
   will become an error.

                             *set_event_loop()..asyncio-eventloop.pyx*
asyncio.set_event_loop(loop)

   Set _loop_ as the current event loop for the current OS thread.

asyncio.new_event_loop()     *new_event_loop()..asyncio-eventloop.pyx*

   Create and return a new event loop object.

Note that the behaviour of "get_event_loop()", "set_event_loop()", and
"new_event_loop()" functions can be altered by setting a custom event
loop policy.

-[ Contents ]-

This documentation page contains the following sections:

* The Event Loop Methods section is the reference documentation of the
  event loop APIs;

* The Callback Handles section documents the "Handle" and
  "TimerHandle" instances which are returned from scheduling methods
  such as "loop.call_soon()" and "loop.call_later()";

* The Server Objects section documents types returned from event loop
  methods like "loop.create_server()";

* The Event Loop Implementations section documents the
  "SelectorEventLoop" and "ProactorEventLoop" classes;

* The Examples section showcases how to work with some event loop
  APIs.


Event Loop Methods
==================

Event loops have **low-level** APIs for the following:

* Running and stopping the loop

* Scheduling callbacks

* Scheduling delayed callbacks

* Creating Futures and Tasks

* Opening network connections

* Creating network servers

* Transferring files

* TLS Upgrade

* Watching file descriptors

* Working with socket objects directly

* DNS

* Working with pipes

* Unix signals

* Executing code in thread or process pools

* Error Handling API

* Enabling debug mode

* Running Subprocesses


Running and stopping the loop
-----------------------------

                    *loop.run_until_complete()..asyncio-eventloop.pyx*
loop.run_until_complete(future)

   Run until the _future_ (an instance of "Future") has completed.

   If the argument is a coroutine object it is implicitly scheduled to
   run as a "asyncio.Task".

   Return the Future’s result or raise its exception.

loop.run_forever()         *loop.run_forever()..asyncio-eventloop.pyx*

   Run the event loop until "stop()" is called.

   If "stop()" is called before "run_forever()" is called, the loop
   will poll the I/O selector once with a timeout of zero, run all
   callbacks scheduled in response to I/O events (and those that were
   already scheduled), and then exit.

   If "stop()" is called while "run_forever()" is running, the loop
   will run the current batch of callbacks and then exit. Note that
   new callbacks scheduled by callbacks will not run in this case;
   instead, they will run the next time "run_forever()" or
   "run_until_complete()" is called.

loop.stop()                       *loop.stop()..asyncio-eventloop.pyx*

   Stop the event loop.

loop.is_running()           *loop.is_running()..asyncio-eventloop.pyx*

   Return "True" if the event loop is currently running.

loop.is_closed()             *loop.is_closed()..asyncio-eventloop.pyx*

   Return "True" if the event loop was closed.

loop.close()                     *loop.close()..asyncio-eventloop.pyx*

   Close the event loop.

   The loop must not be running when this function is called. Any
   pending callbacks will be discarded.

   This method clears all queues and shuts down the executor, but does
   not wait for the executor to finish.

   This method is idempotent and irreversible.  No other methods
   should be called after the event loop is closed.

                    *loop.shutdown_asyncgens()..asyncio-eventloop.pyx*
coroutine loop.shutdown_asyncgens()

   Schedule all currently open _asynchronous generator_ objects to
   close with an "aclose()" call.  After calling this method, the
   event loop will issue a warning if a new asynchronous generator is
   iterated. This should be used to reliably finalize all scheduled
   asynchronous generators.

   Note that there is no need to call this function when
   "asyncio.run()" is used.

   Example:
>
      try:
          loop.run_forever()
      finally:
          loop.run_until_complete(loop.shutdown_asyncgens())
          loop.close()
<
   New in version 3.6.

             *loop.shutdown_default_executor()..asyncio-eventloop.pyx*
coroutine loop.shutdown_default_executor(timeout=None)

   Schedule the closure of the default executor and wait for it to
   join all of the threads in the "ThreadPoolExecutor". Once this
   method has been called, using the default executor with
   "loop.run_in_executor()" will raise a "RuntimeError".

   The _timeout_ parameter specifies the amount of time (in "float"
   seconds) the executor will be given to finish joining. With the
   default, "None", the executor is allowed an unlimited amount of
   time.

   If the _timeout_ is reached, a "RuntimeWarning" is emitted and the
   default executor is terminated without waiting for its threads to
   finish joining.

   Note:

     Do not call this method when using "asyncio.run()", as the latter
     handles default executor shutdown automatically.

   New in version 3.9.

   Changed in version 3.12: Added the _timeout_ parameter.


Scheduling callbacks
--------------------

                             *loop.call_soon()..asyncio-eventloop.pyx*
loop.call_soon(callback, *args, context=None)

   Schedule the _callback_ _callback_ to be called with _args_
   arguments at the next iteration of the event loop.

   Return an instance of "asyncio.Handle", which can be used later to
   cancel the callback.

   Callbacks are called in the order in which they are registered.
   Each callback will be called exactly once.

   The optional keyword-only _context_ argument specifies a custom
   "contextvars.Context" for the _callback_ to run in. Callbacks use
   the current context when no _context_ is provided.

   Unlike "call_soon_threadsafe()", this method is not thread-safe.

                  *loop.call_soon_threadsafe()..asyncio-eventloop.pyx*
loop.call_soon_threadsafe(callback, *args, context=None)

   A thread-safe variant of "call_soon()". When scheduling callbacks
   from another thread, this function _must_ be used, since
   "call_soon()" is not thread-safe.

   Raises "RuntimeError" if called on a loop that’s been closed. This
   can happen on a secondary thread when the main application is
   shutting down.

   See the concurrency and multithreading section of the
   documentation.

Changed in version 3.7: The _context_ keyword-only parameter was
added. See **PEP 567** for more details.

Note:

  Most "asyncio" scheduling functions don’t allow passing keyword
  arguments.  To do that, use "functools.partial()":

>
     # will schedule "print("Hello", flush=True)"
     loop.call_soon(
         functools.partial(print, "Hello", flush=True))
<
  Using partial objects is usually more convenient than using lambdas,
  as asyncio can render partial objects better in debug and error
  messages.


Scheduling delayed callbacks
----------------------------

Event loop provides mechanisms to schedule callback functions to be
called at some point in the future.  Event loop uses monotonic clocks
to track time.

                            *loop.call_later()..asyncio-eventloop.pyx*
loop.call_later(delay, callback, *args, context=None)

   Schedule _callback_ to be called after the given _delay_ number of
   seconds (can be either an int or a float).

   An instance of "asyncio.TimerHandle" is returned which can be used
   to cancel the callback.

   _callback_ will be called exactly once.  If two callbacks are
   scheduled for exactly the same time, the order in which they are
   called is undefined.

   The optional positional _args_ will be passed to the callback when
   it is called. If you want the callback to be called with keyword
   arguments use "functools.partial()".

   An optional keyword-only _context_ argument allows specifying a
   custom "contextvars.Context" for the _callback_ to run in. The
   current context is used when no _context_ is provided.

   Changed in version 3.7: The _context_ keyword-only parameter was
   added. See **PEP 567** for more details.

   Changed in version 3.8: In Python 3.7 and earlier with the default
   event loop implementation, the _delay_ could not exceed one day.
   This has been fixed in Python 3.8.

                               *loop.call_at()..asyncio-eventloop.pyx*
loop.call_at(when, callback, *args, context=None)

   Schedule _callback_ to be called at the given absolute timestamp
   _when_ (an int or a float), using the same time reference as
   "loop.time()".

   This method’s behavior is the same as "call_later()".

   An instance of "asyncio.TimerHandle" is returned which can be used
   to cancel the callback.

   Changed in version 3.7: The _context_ keyword-only parameter was
   added. See **PEP 567** for more details.

   Changed in version 3.8: In Python 3.7 and earlier with the default
   event loop implementation, the difference between _when_ and the
   current time could not exceed one day.  This has been fixed in
   Python 3.8.

loop.time()                       *loop.time()..asyncio-eventloop.pyx*

   Return the current time, as a "float" value, according to the event
   loop’s internal monotonic clock.

Note:

  Changed in version 3.8: In Python 3.7 and earlier timeouts (relative
  _delay_ or absolute _when_) should not exceed one day.  This has
  been fixed in Python 3.8.

See also: The "asyncio.sleep()" function.


Creating Futures and Tasks
--------------------------

loop.create_future()     *loop.create_future()..asyncio-eventloop.pyx*

   Create an "asyncio.Future" object attached to the event loop.

   This is the preferred way to create Futures in asyncio. This lets
   third-party event loops provide alternative implementations of the
   Future object (with better performance or instrumentation).

   New in version 3.5.2.

                           *loop.create_task()..asyncio-eventloop.pyx*
loop.create_task(coro, *, name=None, context=None)

   Schedule the execution of coroutine _coro_. Return a "Task" object.

   Third-party event loops can use their own subclass of "Task" for
   interoperability. In this case, the result type is a subclass of
   "Task".

   If the _name_ argument is provided and not "None", it is set as the
   name of the task using "Task.set_name()".

   An optional keyword-only _context_ argument allows specifying a
   custom "contextvars.Context" for the _coro_ to run in. The current
   context copy is created when no _context_ is provided.

   Changed in version 3.8: Added the _name_ parameter.

   Changed in version 3.11: Added the _context_ parameter.

                      *loop.set_task_factory()..asyncio-eventloop.pyx*
loop.set_task_factory(factory)

   Set a task factory that will be used by "loop.create_task()".

   If _factory_ is "None" the default task factory will be set.
   Otherwise, _factory_ must be a _callable_ with the signature
   matching "(loop, coro, context=None)", where _loop_ is a reference
   to the active event loop, and _coro_ is a coroutine object.  The
   callable must return a "asyncio.Future"-compatible object.

                      *loop.get_task_factory()..asyncio-eventloop.pyx*
loop.get_task_factory()

   Return a task factory or "None" if the default one is in use.


Opening network connections
---------------------------

                     *loop.create_connection()..asyncio-eventloop.pyx*
coroutine loop.create_connection(protocol_factory, host=None, port=None, *, ssl=None, family=0, proto=0, flags=0, sock=None, local_addr=None, server_hostname=None, ssl_handshake_timeout=None, ssl_shutdown_timeout=None, happy_eyeballs_delay=None, interleave=None, all_errors=False)

   Open a streaming transport connection to a given address specified
   by _host_ and _port_.

   The socket family can be either "AF_INET" or "AF_INET6" depending
   on _host_ (or the _family_ argument, if provided).

   The socket type will be "SOCK_STREAM".

   _protocol_factory_ must be a callable returning an asyncio protocol
   implementation.

   This method will try to establish the connection in the background.
   When successful, it returns a "(transport, protocol)" pair.

   The chronological synopsis of the underlying operation is as
   follows:

   1. The connection is established and a transport is created for it.

   2. _protocol_factory_ is called without arguments and is expected
      to return a protocol instance.

   3. The protocol instance is coupled with the transport by calling
      its "connection_made()" method.

   4. A "(transport, protocol)" tuple is returned on success.

   The created transport is an implementation-dependent bidirectional
   stream.

   Other arguments:

   * _ssl_: if given and not false, a SSL/TLS transport is created (by
     default a plain TCP transport is created).  If _ssl_ is a
     "ssl.SSLContext" object, this context is used to create the
     transport; if _ssl_ is "True", a default context returned from
     "ssl.create_default_context()" is used.

     See also: SSL/TLS security considerations

   * _server_hostname_ sets or overrides the hostname that the target
     server’s certificate will be matched against.  Should only be
     passed if _ssl_ is not "None".  By default the value of the
     _host_ argument is used.  If _host_ is empty, there is no default
     and you must pass a value for _server_hostname_.  If
     _server_hostname_ is an empty string, hostname matching is
     disabled (which is a serious security risk, allowing for
     potential man-in-the-middle attacks).

   * _family_, _proto_, _flags_ are the optional address family,
     protocol and flags to be passed through to getaddrinfo() for
     _host_ resolution. If given, these should all be integers from
     the corresponding "socket" module constants.

   * _happy_eyeballs_delay_, if given, enables Happy Eyeballs for this
     connection. It should be a floating-point number representing the
     amount of time in seconds to wait for a connection attempt to
     complete, before starting the next attempt in parallel. This is
     the “Connection Attempt Delay” as defined in **RFC 8305**. A
     sensible default value recommended by the RFC is "0.25" (250
     milliseconds).

   * _interleave_ controls address reordering when a host name
     resolves to multiple IP addresses. If "0" or unspecified, no
     reordering is done, and addresses are tried in the order returned
     by "getaddrinfo()". If a positive integer is specified, the
     addresses are interleaved by address family, and the given
     integer is interpreted as “First Address Family Count” as defined
     in **RFC 8305**. The default is "0" if _happy_eyeballs_delay_ is
     not specified, and "1" if it is.

   * _sock_, if given, should be an existing, already connected
     "socket.socket" object to be used by the transport. If _sock_ is
     given, none of _host_, _port_, _family_, _proto_, _flags_,
     _happy_eyeballs_delay_, _interleave_ and _local_addr_ should be
     specified.

     Note:

       The _sock_ argument transfers ownership of the socket to the
       transport created. To close the socket, call the transport’s
       "close()" method.

   * _local_addr_, if given, is a "(local_host, local_port)" tuple
     used to bind the socket locally.  The _local_host_ and
     _local_port_ are looked up using "getaddrinfo()", similarly to
     _host_ and _port_.

   * _ssl_handshake_timeout_ is (for a TLS connection) the time in
     seconds to wait for the TLS handshake to complete before aborting
     the connection. "60.0" seconds if "None" (default).

   * _ssl_shutdown_timeout_ is the time in seconds to wait for the SSL
     shutdown to complete before aborting the connection. "30.0"
     seconds if "None" (default).

   * _all_errors_ determines what exceptions are raised when a
     connection cannot be created. By default, only a single
     "Exception" is raised: the first exception if there is only one
     or all errors have same message, or a single "OSError" with the
     error messages combined. When "all_errors" is "True", an
     "ExceptionGroup" will be raised containing all exceptions (even
     if there is only one).

   Changed in version 3.5: Added support for SSL/TLS in
   "ProactorEventLoop".

   Changed in version 3.6: The socket option "TCP_NODELAY" is set by
   default for all TCP connections.

   Changed in version 3.7: Added the _ssl_handshake_timeout_
   parameter.

   Changed in version 3.8: Added the _happy_eyeballs_delay_ and
   _interleave_ parameters.Happy Eyeballs Algorithm: Success with
   Dual-Stack Hosts. When a server’s IPv4 path and protocol are
   working, but the server’s IPv6 path and protocol are not working, a
   dual-stack client application experiences significant connection
   delay compared to an IPv4-only client.  This is undesirable because
   it causes the dual-stack client to have a worse user experience.
   This document specifies requirements for algorithms that reduce
   this user-visible delay and provides an algorithm.For more
   information: https://datatracker.ietf.org/doc/html/rfc6555

   Changed in version 3.11: Added the _ssl_shutdown_timeout_
   parameter.

   Changed in version 3.12: _all_errors_ was added.

   See also:

     The "open_connection()" function is a high-level alternative API.
     It returns a pair of ("StreamReader", "StreamWriter") that can be
     used directly in async/await code.

              *loop.create_datagram_endpoint()..asyncio-eventloop.pyx*
coroutine loop.create_datagram_endpoint(protocol_factory, local_addr=None, remote_addr=None, *, family=0, proto=0, flags=0, reuse_port=None, allow_broadcast=None, sock=None)

   Create a datagram connection.

   The socket family can be either "AF_INET", "AF_INET6", or
   "AF_UNIX", depending on _host_ (or the _family_ argument, if
   provided).

   The socket type will be "SOCK_DGRAM".

   _protocol_factory_ must be a callable returning a protocol
   implementation.

   A tuple of "(transport, protocol)" is returned on success.

   Other arguments:

   * _local_addr_, if given, is a "(local_host, local_port)" tuple
     used to bind the socket locally.  The _local_host_ and
     _local_port_ are looked up using "getaddrinfo()".

   * _remote_addr_, if given, is a "(remote_host, remote_port)" tuple
     used to connect the socket to a remote address.  The
     _remote_host_ and _remote_port_ are looked up using
     "getaddrinfo()".

   * _family_, _proto_, _flags_ are the optional address family,
     protocol and flags to be passed through to "getaddrinfo()" for
     _host_ resolution. If given, these should all be integers from
     the corresponding "socket" module constants.

   * _reuse_port_ tells the kernel to allow this endpoint to be bound
     to the same port as other existing endpoints are bound to, so
     long as they all set this flag when being created. This option is
     not supported on Windows and some Unixes. If the "SO_REUSEPORT"
     constant is not defined then this capability is unsupported.

   * _allow_broadcast_ tells the kernel to allow this endpoint to send
     messages to the broadcast address.

   * _sock_ can optionally be specified in order to use a preexisting,
     already connected, "socket.socket" object to be used by the
     transport. If specified, _local_addr_ and _remote_addr_ should be
     omitted (must be "None").

     Note:

       The _sock_ argument transfers ownership of the socket to the
       transport created. To close the socket, call the transport’s
       "close()" method.

   See UDP echo client protocol and UDP echo server protocol examples.

   Changed in version 3.4.4: The _family_, _proto_, _flags_,
   _reuse_address_, _reuse_port_, _allow_broadcast_, and _sock_
   parameters were added.

   Changed in version 3.8.1: The _reuse_address_ parameter is no
   longer supported, as using "SO_REUSEADDR" poses a significant
   security concern for UDP. Explicitly passing "reuse_address=True"
   will raise an exception.When multiple processes with differing UIDs
   assign sockets to an identical UDP socket address with
   "SO_REUSEADDR", incoming packets can become randomly distributed
   among the sockets.For supported platforms, _reuse_port_ can be used
   as a replacement for similar functionality. With _reuse_port_,
   "SO_REUSEPORT" is used instead, which specifically prevents
   processes with differing UIDs from assigning sockets to the same
   socket address.

   Changed in version 3.8: Added support for Windows.

   Changed in version 3.11: The _reuse_address_ parameter, disabled
   since Python 3.9.0, 3.8.1, 3.7.6 and 3.6.10, has been entirely
   removed.

                *loop.create_unix_connection()..asyncio-eventloop.pyx*
coroutine loop.create_unix_connection(protocol_factory, path=None, *, ssl=None, sock=None, server_hostname=None, ssl_handshake_timeout=None, ssl_shutdown_timeout=None)

   Create a Unix connection.

   The socket family will be "AF_UNIX"; socket type will be
   "SOCK_STREAM".

   A tuple of "(transport, protocol)" is returned on success.

   _path_ is the name of a Unix domain socket and is required, unless
   a _sock_ parameter is specified.  Abstract Unix sockets, "str",
   "bytes", and "Path" paths are supported.

   See the documentation of the "loop.create_connection()" method for
   information about arguments to this method.

   Availability: Unix.

   Changed in version 3.7: Added the _ssl_handshake_timeout_
   parameter. The _path_ parameter can now be a _path-like object_.

   Changed in version 3.11: Added the _ssl_shutdown_timeout_
   parameter.


Creating network servers
------------------------

                         *loop.create_server()..asyncio-eventloop.pyx*
coroutine loop.create_server(protocol_factory, host=None, port=None, *, family=socket.AF_UNSPEC, flags=socket.AI_PASSIVE, sock=None, backlog=100, ssl=None, reuse_address=None, reuse_port=None, ssl_handshake_timeout=None, ssl_shutdown_timeout=None, start_serving=True)

   Create a TCP server (socket type "SOCK_STREAM") listening on _port_
   of the _host_ address.

   Returns a "Server" object.

   Arguments:

   * _protocol_factory_ must be a callable returning a protocol
     implementation.

   * The _host_ parameter can be set to several types which determine
     where the server would be listening:

     * If _host_ is a string, the TCP server is bound to a single
       network interface specified by _host_.

     * If _host_ is a sequence of strings, the TCP server is bound to
       all network interfaces specified by the sequence.

     * If _host_ is an empty string or "None", all interfaces are
       assumed and a list of multiple sockets will be returned (most
       likely one for IPv4 and another one for IPv6).

   * The _port_ parameter can be set to specify which port the server
     should listen on. If "0" or "None" (the default), a random unused
     port will be selected (note that if _host_ resolves to multiple
     network interfaces, a different random port will be selected for
     each interface).

   * _family_ can be set to either "socket.AF_INET" or "AF_INET6" to
     force the socket to use IPv4 or IPv6. If not set, the _family_
     will be determined from host name (defaults to "AF_UNSPEC").

   * _flags_ is a bitmask for "getaddrinfo()".

   * _sock_ can optionally be specified in order to use a preexisting
     socket object. If specified, _host_ and _port_ must not be
     specified.

     Note:

       The _sock_ argument transfers ownership of the socket to the
       server created. To close the socket, call the server’s
       "close()" method.

   * _backlog_ is the maximum number of queued connections passed to
     "listen()" (defaults to 100).

   * _ssl_ can be set to an "SSLContext" instance to enable TLS over
     the accepted connections.

   * _reuse_address_ tells the kernel to reuse a local socket in
     "TIME_WAIT" state, without waiting for its natural timeout to
     expire. If not specified will automatically be set to "True" on
     Unix.

   * _reuse_port_ tells the kernel to allow this endpoint to be bound
     to the same port as other existing endpoints are bound to, so
     long as they all set this flag when being created. This option is
     not supported on Windows.

   * _ssl_handshake_timeout_ is (for a TLS server) the time in seconds
     to wait for the TLS handshake to complete before aborting the
     connection. "60.0" seconds if "None" (default).

   * _ssl_shutdown_timeout_ is the time in seconds to wait for the SSL
     shutdown to complete before aborting the connection. "30.0"
     seconds if "None" (default).

   * _start_serving_ set to "True" (the default) causes the created
     server to start accepting connections immediately.  When set to
     "False", the user should await on "Server.start_serving()" or
     "Server.serve_forever()" to make the server to start accepting
     connections.

   Changed in version 3.5: Added support for SSL/TLS in
   "ProactorEventLoop".

   Changed in version 3.5.1: The _host_ parameter can be a sequence of
   strings.

   Changed in version 3.6: Added _ssl_handshake_timeout_ and
   _start_serving_ parameters. The socket option "TCP_NODELAY" is set
   by default for all TCP connections.

   Changed in version 3.11: Added the _ssl_shutdown_timeout_
   parameter.

   See also:

     The "start_server()" function is a higher-level alternative API
     that returns a pair of "StreamReader" and "StreamWriter" that can
     be used in an async/await code.

                    *loop.create_unix_server()..asyncio-eventloop.pyx*
coroutine loop.create_unix_server(protocol_factory, path=None, *, sock=None, backlog=100, ssl=None, ssl_handshake_timeout=None, ssl_shutdown_timeout=None, start_serving=True)

   Similar to "loop.create_server()" but works with the "AF_UNIX"
   socket family.

   _path_ is the name of a Unix domain socket, and is required, unless
   a _sock_ argument is provided.  Abstract Unix sockets, "str",
   "bytes", and "Path" paths are supported.

   See the documentation of the "loop.create_server()" method for
   information about arguments to this method.

   Availability: Unix.

   Changed in version 3.7: Added the _ssl_handshake_timeout_ and
   _start_serving_ parameters. The _path_ parameter can now be a
   "Path" object.

   Changed in version 3.11: Added the _ssl_shutdown_timeout_
   parameter.

               *loop.connect_accepted_socket()..asyncio-eventloop.pyx*
coroutine loop.connect_accepted_socket(protocol_factory, sock, *, ssl=None, ssl_handshake_timeout=None, ssl_shutdown_timeout=None)

   Wrap an already accepted connection into a transport/protocol pair.

   This method can be used by servers that accept connections outside
   of asyncio but that use asyncio to handle them.

   Parameters:

   * _protocol_factory_ must be a callable returning a protocol
     implementation.

   * _sock_ is a preexisting socket object returned from
     "socket.accept".

     Note:

       The _sock_ argument transfers ownership of the socket to the
       transport created. To close the socket, call the transport’s
       "close()" method.

   * _ssl_ can be set to an "SSLContext" to enable SSL over the
     accepted connections.

   * _ssl_handshake_timeout_ is (for an SSL connection) the time in
     seconds to wait for the SSL handshake to complete before aborting
     the connection. "60.0" seconds if "None" (default).

   * _ssl_shutdown_timeout_ is the time in seconds to wait for the SSL
     shutdown to complete before aborting the connection. "30.0"
     seconds if "None" (default).

   Returns a "(transport, protocol)" pair.

   New in version 3.5.3.

   Changed in version 3.7: Added the _ssl_handshake_timeout_
   parameter.

   Changed in version 3.11: Added the _ssl_shutdown_timeout_
   parameter.


Transferring files
------------------

                              *loop.sendfile()..asyncio-eventloop.pyx*
coroutine loop.sendfile(transport, file, offset=0, count=None, *, fallback=True)

   Send a _file_ over a _transport_.  Return the total number of bytes
   sent.

   The method uses high-performance "os.sendfile()" if available.

   _file_ must be a regular file object opened in binary mode.

   _offset_ tells from where to start reading the file. If specified,
   _count_ is the total number of bytes to transmit as opposed to
   sending the file until EOF is reached. File position is always
   updated, even when this method raises an error, and "file.tell()"
   can be used to obtain the actual number of bytes sent.

   _fallback_ set to "True" makes asyncio to manually read and send
   the file when the platform does not support the sendfile system
   call (e.g. Windows or SSL socket on Unix).

   Raise "SendfileNotAvailableError" if the system does not support
   the _sendfile_ syscall and _fallback_ is "False".

   New in version 3.7.


TLS Upgrade
-----------

                             *loop.start_tls()..asyncio-eventloop.pyx*
coroutine loop.start_tls(transport, protocol, sslcontext, *, server_side=False, server_hostname=None, ssl_handshake_timeout=None, ssl_shutdown_timeout=None)

   Upgrade an existing transport-based connection to TLS.

   Create a TLS coder/decoder instance and insert it between the
   _transport_ and the _protocol_. The coder/decoder implements both
   _transport_-facing protocol and _protocol_-facing transport.

   Return the created two-interface instance. After _await_, the
   _protocol_ must stop using the original _transport_ and communicate
   with the returned object only because the coder caches
   _protocol_-side data and sporadically exchanges extra TLS session
   packets with _transport_.

   In some situations (e.g. when the passed transport is already
   closing) this may return "None".

   Parameters:

   * _transport_ and _protocol_ instances that methods like
     "create_server()" and "create_connection()" return.

   * _sslcontext_: a configured instance of "SSLContext".

   * _server_side_ pass "True" when a server-side connection is being
     upgraded (like the one created by "create_server()").

   * _server_hostname_: sets or overrides the host name that the
     target server’s certificate will be matched against.

   * _ssl_handshake_timeout_ is (for a TLS connection) the time in
     seconds to wait for the TLS handshake to complete before aborting
     the connection. "60.0" seconds if "None" (default).

   * _ssl_shutdown_timeout_ is the time in seconds to wait for the SSL
     shutdown to complete before aborting the connection. "30.0"
     seconds if "None" (default).

   New in version 3.7.

   Changed in version 3.11: Added the _ssl_shutdown_timeout_
   parameter.


Watching file descriptors
-------------------------

                            *loop.add_reader()..asyncio-eventloop.pyx*
loop.add_reader(fd, callback, *args)

   Start monitoring the _fd_ file descriptor for read availability and
   invoke _callback_ with the specified arguments once _fd_ is
   available for reading.

loop.remove_reader(fd)   *loop.remove_reader()..asyncio-eventloop.pyx*

   Stop monitoring the _fd_ file descriptor for read availability.
   Returns "True" if _fd_ was previously being monitored for reads.

                            *loop.add_writer()..asyncio-eventloop.pyx*
loop.add_writer(fd, callback, *args)

   Start monitoring the _fd_ file descriptor for write availability
   and invoke _callback_ with the specified arguments once _fd_ is
   available for writing.

   Use "functools.partial()" to pass keyword arguments to _callback_.

loop.remove_writer(fd)   *loop.remove_writer()..asyncio-eventloop.pyx*

   Stop monitoring the _fd_ file descriptor for write availability.
   Returns "True" if _fd_ was previously being monitored for writes.

See also Platform Support section for some limitations of these
methods.


Working with socket objects directly
------------------------------------

In general, protocol implementations that use transport-based APIs
such as "loop.create_connection()" and "loop.create_server()" are
faster than implementations that work with sockets directly. However,
there are some use cases when performance is not critical, and working
with "socket" objects directly is more convenient.

                             *loop.sock_recv()..asyncio-eventloop.pyx*
coroutine loop.sock_recv(sock, nbytes)

   Receive up to _nbytes_ from _sock_.  Asynchronous version of
   "socket.recv()".

   Return the received data as a bytes object.

   _sock_ must be a non-blocking socket.

   Changed in version 3.7: Even though this method was always
   documented as a coroutine method, releases before Python 3.7
   returned a "Future". Since Python 3.7 this is an "async def"
   method.

                        *loop.sock_recv_into()..asyncio-eventloop.pyx*
coroutine loop.sock_recv_into(sock, buf)

   Receive data from _sock_ into the _buf_ buffer.  Modeled after the
   blocking "socket.recv_into()" method.

   Return the number of bytes written to the buffer.

   _sock_ must be a non-blocking socket.

   New in version 3.7.

                         *loop.sock_recvfrom()..asyncio-eventloop.pyx*
coroutine loop.sock_recvfrom(sock, bufsize)

   Receive a datagram of up to _bufsize_ from _sock_.  Asynchronous
   version of "socket.recvfrom()".

   Return a tuple of (received data, remote address).

   _sock_ must be a non-blocking socket.

   New in version 3.11.

                    *loop.sock_recvfrom_into()..asyncio-eventloop.pyx*
coroutine loop.sock_recvfrom_into(sock, buf, nbytes=0)

   Receive a datagram of up to _nbytes_ from _sock_ into _buf_.
   Asynchronous version of "socket.recvfrom_into()".

   Return a tuple of (number of bytes received, remote address).

   _sock_ must be a non-blocking socket.

   New in version 3.11.

                          *loop.sock_sendall()..asyncio-eventloop.pyx*
coroutine loop.sock_sendall(sock, data)

   Send _data_ to the _sock_ socket. Asynchronous version of
   "socket.sendall()".

   This method continues to send to the socket until either all data
   in _data_ has been sent or an error occurs.  "None" is returned on
   success.  On error, an exception is raised. Additionally, there is
   no way to determine how much data, if any, was successfully
   processed by the receiving end of the connection.

   _sock_ must be a non-blocking socket.

   Changed in version 3.7: Even though the method was always
   documented as a coroutine method, before Python 3.7 it returned a
   "Future". Since Python 3.7, this is an "async def" method.

                           *loop.sock_sendto()..asyncio-eventloop.pyx*
coroutine loop.sock_sendto(sock, data, address)

   Send a datagram from _sock_ to _address_. Asynchronous version of
   "socket.sendto()".

   Return the number of bytes sent.

   _sock_ must be a non-blocking socket.

   New in version 3.11.

                          *loop.sock_connect()..asyncio-eventloop.pyx*
coroutine loop.sock_connect(sock, address)

   Connect _sock_ to a remote socket at _address_.

   Asynchronous version of "socket.connect()".

   _sock_ must be a non-blocking socket.

   Changed in version 3.5.2: "address" no longer needs to be resolved.
   "sock_connect" will try to check if the _address_ is already
   resolved by calling "socket.inet_pton()".  If not,
   "loop.getaddrinfo()" will be used to resolve the _address_.

   See also:

     "loop.create_connection()" and  "asyncio.open_connection()".

                           *loop.sock_accept()..asyncio-eventloop.pyx*
coroutine loop.sock_accept(sock)

   Accept a connection.  Modeled after the blocking "socket.accept()"
   method.

   The socket must be bound to an address and listening for
   connections. The return value is a pair "(conn, address)" where
   _conn_ is a _new_ socket object usable to send and receive data on
   the connection, and _address_ is the address bound to the socket on
   the other end of the connection.

   _sock_ must be a non-blocking socket.

   Changed in version 3.7: Even though the method was always
   documented as a coroutine method, before Python 3.7 it returned a
   "Future". Since Python 3.7, this is an "async def" method.

   See also: "loop.create_server()" and "start_server()".

                         *loop.sock_sendfile()..asyncio-eventloop.pyx*
coroutine loop.sock_sendfile(sock, file, offset=0, count=None, *, fallback=True)

   Send a file using high-performance "os.sendfile" if possible.
   Return the total number of bytes sent.

   Asynchronous version of "socket.sendfile()".

   _sock_ must be a non-blocking "socket.SOCK_STREAM" "socket".

   _file_ must be a regular file object open in binary mode.

   _offset_ tells from where to start reading the file. If specified,
   _count_ is the total number of bytes to transmit as opposed to
   sending the file until EOF is reached. File position is always
   updated, even when this method raises an error, and "file.tell()"
   can be used to obtain the actual number of bytes sent.

   _fallback_, when set to "True", makes asyncio manually read and
   send the file when the platform does not support the sendfile
   syscall (e.g. Windows or SSL socket on Unix).

   Raise "SendfileNotAvailableError" if the system does not support
   _sendfile_ syscall and _fallback_ is "False".

   _sock_ must be a non-blocking socket.

   New in version 3.7.


DNS
---

                           *loop.getaddrinfo()..asyncio-eventloop.pyx*
coroutine loop.getaddrinfo(host, port, *, family=0, type=0, proto=0, flags=0)

   Asynchronous version of "socket.getaddrinfo()".

                           *loop.getnameinfo()..asyncio-eventloop.pyx*
coroutine loop.getnameinfo(sockaddr, flags=0)

   Asynchronous version of "socket.getnameinfo()".

Changed in version 3.7: Both _getaddrinfo_ and _getnameinfo_ methods
were always documented to return a coroutine, but prior to Python 3.7
they were, in fact, returning "asyncio.Future" objects.  Starting with
Python 3.7 both methods are coroutines.


Working with pipes
------------------

                     *loop.connect_read_pipe()..asyncio-eventloop.pyx*
coroutine loop.connect_read_pipe(protocol_factory, pipe)

   Register the read end of _pipe_ in the event loop.

   _protocol_factory_ must be a callable returning an asyncio protocol
   implementation.

   _pipe_ is a _file-like object_.

   Return pair "(transport, protocol)", where _transport_ supports the
   "ReadTransport" interface and _protocol_ is an object instantiated
   by the _protocol_factory_.

   With "SelectorEventLoop" event loop, the _pipe_ is set to non-
   blocking mode.

                    *loop.connect_write_pipe()..asyncio-eventloop.pyx*
coroutine loop.connect_write_pipe(protocol_factory, pipe)

   Register the write end of _pipe_ in the event loop.

   _protocol_factory_ must be a callable returning an asyncio protocol
   implementation.

   _pipe_ is _file-like object_.

   Return pair "(transport, protocol)", where _transport_ supports
   "WriteTransport" interface and _protocol_ is an object instantiated
   by the _protocol_factory_.

   With "SelectorEventLoop" event loop, the _pipe_ is set to non-
   blocking mode.

Note:

  "SelectorEventLoop" does not support the above methods on Windows.
  Use "ProactorEventLoop" instead for Windows.

See also:

  The "loop.subprocess_exec()" and "loop.subprocess_shell()" methods.


Unix signals
------------

                    *loop.add_signal_handler()..asyncio-eventloop.pyx*
loop.add_signal_handler(signum, callback, *args)

   Set _callback_ as the handler for the _signum_ signal.

   The callback will be invoked by _loop_, along with other queued
   callbacks and runnable coroutines of that event loop. Unlike signal
   handlers registered using "signal.signal()", a callback registered
   with this function is allowed to interact with the event loop.

   Raise "ValueError" if the signal number is invalid or uncatchable.
   Raise "RuntimeError" if there is a problem setting up the handler.

   Use "functools.partial()" to pass keyword arguments to _callback_.

   Like "signal.signal()", this function must be invoked in the main
   thread.

                 *loop.remove_signal_handler()..asyncio-eventloop.pyx*
loop.remove_signal_handler(sig)

   Remove the handler for the _sig_ signal.

   Return "True" if the signal handler was removed, or "False" if no
   handler was set for the given signal.

   Availability: Unix.

See also: The "signal" module.


Executing code in thread or process pools
-----------------------------------------

                       *loop.run_in_executor()..asyncio-eventloop.pyx*
awaitable loop.run_in_executor(executor, func, *args)

   Arrange for _func_ to be called in the specified executor.

   The _executor_ argument should be an "concurrent.futures.Executor"
   instance. The default executor is used if _executor_ is "None".

   Example:
>
      import asyncio
      import concurrent.futures

      def blocking_io():
          # File operations (such as logging) can block the
          # event loop: run them in a thread pool.
          with open('/dev/urandom', 'rb') as f:
              return f.read(100)

      def cpu_bound():
          # CPU-bound operations will block the event loop:
          # in general it is preferable to run them in a
          # process pool.
          return sum(i * i for i in range(10 ** 7))

      async def main():
          loop = asyncio.get_running_loop()

          ## Options:

          # 1. Run in the default loop's executor:
          result = await loop.run_in_executor(
              None, blocking_io)
          print('default thread pool', result)

          # 2. Run in a custom thread pool:
          with concurrent.futures.ThreadPoolExecutor() as pool:
              result = await loop.run_in_executor(
                  pool, blocking_io)
              print('custom thread pool', result)

          # 3. Run in a custom process pool:
          with concurrent.futures.ProcessPoolExecutor() as pool:
              result = await loop.run_in_executor(
                  pool, cpu_bound)
              print('custom process pool', result)

      if __name__ == '__main__':
          asyncio.run(main())
<
   Note that the entry point guard ("if __name__ == '__main__'") is
   required for option 3 due to the peculiarities of
   "multiprocessing", which is used by "ProcessPoolExecutor". See Safe
   importing of main module.

   This method returns a "asyncio.Future" object.

   Use "functools.partial()" to pass keyword arguments to _func_.

   Changed in version 3.5.3: "loop.run_in_executor()" no longer
   configures the "max_workers" of the thread pool executor it
   creates, instead leaving it up to the thread pool executor
   ("ThreadPoolExecutor") to set the default.

                  *loop.set_default_executor()..asyncio-eventloop.pyx*
loop.set_default_executor(executor)

   Set _executor_ as the default executor used by "run_in_executor()".
   _executor_ must be an instance of "ThreadPoolExecutor".

   Changed in version 3.11: _executor_ must be an instance of
   "ThreadPoolExecutor".


Error Handling API
------------------

Allows customizing how exceptions are handled in the event loop.

                 *loop.set_exception_handler()..asyncio-eventloop.pyx*
loop.set_exception_handler(handler)

   Set _handler_ as the new event loop exception handler.

   If _handler_ is "None", the default exception handler will be set.
   Otherwise, _handler_ must be a callable with the signature matching
   "(loop, context)", where "loop" is a reference to the active event
   loop, and "context" is a "dict" object containing the details of
   the exception (see "call_exception_handler()" documentation for
   details about context).

   If the handler is called on behalf of a "Task" or "Handle", it is
   run in the "contextvars.Context" of that task or callback handle.

   Changed in version 3.12: The handler may be called in the "Context"
   of the task or handle where the exception originated.

                 *loop.get_exception_handler()..asyncio-eventloop.pyx*
loop.get_exception_handler()

   Return the current exception handler, or "None" if no custom
   exception handler was set.

   New in version 3.5.2.

             *loop.default_exception_handler()..asyncio-eventloop.pyx*
loop.default_exception_handler(context)

   Default exception handler.

   This is called when an exception occurs and no exception handler is
   set. This can be called by a custom exception handler that wants to
   defer to the default handler behavior.

   _context_ parameter has the same meaning as in
   "call_exception_handler()".

                *loop.call_exception_handler()..asyncio-eventloop.pyx*
loop.call_exception_handler(context)

   Call the current event loop exception handler.

   _context_ is a "dict" object containing the following keys (new
   keys may be introduced in future Python versions):

   * ‘message’: Error message;

   * ‘exception’ (optional): Exception object;

   * ‘future’ (optional): "asyncio.Future" instance;

   * ‘task’ (optional): "asyncio.Task" instance;

   * ‘handle’ (optional): "asyncio.Handle" instance;

   * ‘protocol’ (optional): Protocol instance;

   * ‘transport’ (optional): Transport instance;

   * ‘socket’ (optional): "socket.socket" instance;

   * ‘asyncgen’ (optional): Asynchronous generator that caused
        the exception.

   Note:

     This method should not be overloaded in subclassed event loops.
     For custom exception handling, use the "set_exception_handler()"
     method.


Enabling debug mode
-------------------

loop.get_debug()             *loop.get_debug()..asyncio-eventloop.pyx*

   Get the debug mode ("bool") of the event loop.

   The default value is "True" if the environment variable
   "PYTHONASYNCIODEBUG" is set to a non-empty string, "False"
   otherwise.

                             *loop.set_debug()..asyncio-eventloop.pyx*
loop.set_debug(enabled: bool)

   Set the debug mode of the event loop.

   Changed in version 3.7: The new Python Development Mode can now
   also be used to enable the debug mode.

See also: The debug mode of asyncio.


Running Subprocesses
--------------------

Methods described in this subsections are low-level.  In regular
async/await code consider using the high-level
"asyncio.create_subprocess_shell()" and
"asyncio.create_subprocess_exec()" convenience functions instead.

Note:

  On Windows, the default event loop "ProactorEventLoop" supports
  subprocesses, whereas "SelectorEventLoop" does not. See Subprocess
  Support on Windows for details.

                       *loop.subprocess_exec()..asyncio-eventloop.pyx*
coroutine loop.subprocess_exec(protocol_factory, *args, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kwargs)

   Create a subprocess from one or more string arguments specified by
   _args_.

   _args_ must be a list of strings represented by:

   * "str";

   * or "bytes", encoded to the filesystem encoding.

   The first string specifies the program executable, and the
   remaining strings specify the arguments.  Together, string
   arguments form the "argv" of the program.

   This is similar to the standard library "subprocess.Popen" class
   called with "shell=False" and the list of strings passed as the
   first argument; however, where "Popen" takes a single argument
   which is list of strings, _subprocess_exec_ takes multiple string
   arguments.

   The _protocol_factory_ must be a callable returning a subclass of
   the "asyncio.SubprocessProtocol" class.

   Other parameters:

   * _stdin_ can be any of these:

     * a file-like object

     * an existing file descriptor (a positive integer), for example
       those created with "os.pipe()"

     * the "subprocess.PIPE" constant (default) which will create a
       new pipe and connect it,

     * the value "None" which will make the subprocess inherit the
       file descriptor from this process

     * the "subprocess.DEVNULL" constant which indicates that the
       special "os.devnull" file will be used

   * _stdout_ can be any of these:

     * a file-like object

     * the "subprocess.PIPE" constant (default) which will create a
       new pipe and connect it,

     * the value "None" which will make the subprocess inherit the
       file descriptor from this process

     * the "subprocess.DEVNULL" constant which indicates that the
       special "os.devnull" file will be used

   * _stderr_ can be any of these:

     * a file-like object

     * the "subprocess.PIPE" constant (default) which will create a
       new pipe and connect it,

     * the value "None" which will make the subprocess inherit the
       file descriptor from this process

     * the "subprocess.DEVNULL" constant which indicates that the
       special "os.devnull" file will be used

     * the "subprocess.STDOUT" constant which will connect the
       standard error stream to the process’ standard output stream

   * All other keyword arguments are passed to "subprocess.Popen"
     without interpretation, except for _bufsize_,
     _universal_newlines_, _shell_, _text_, _encoding_ and _errors_,
     which should not be specified at all.

     The "asyncio" subprocess API does not support decoding the
     streams as text. "bytes.decode()" can be used to convert the
     bytes returned from the stream to text.

   If a file-like object passed as _stdin_, _stdout_ or _stderr_
   represents a pipe, then the other side of this pipe should be
   registered with "connect_write_pipe()" or "connect_read_pipe()" for
   use with the event loop.

   See the constructor of the "subprocess.Popen" class for
   documentation on other arguments.

   Returns a pair of "(transport, protocol)", where _transport_
   conforms to the "asyncio.SubprocessTransport" base class and
   _protocol_ is an object instantiated by the _protocol_factory_.

                      *loop.subprocess_shell()..asyncio-eventloop.pyx*
coroutine loop.subprocess_shell(protocol_factory, cmd, *, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, **kwargs)

   Create a subprocess from _cmd_, which can be a "str" or a "bytes"
   string encoded to the filesystem encoding, using the platform’s
   “shell” syntax.

   This is similar to the standard library "subprocess.Popen" class
   called with "shell=True".

   The _protocol_factory_ must be a callable returning a subclass of
   the "SubprocessProtocol" class.

   See "subprocess_exec()" for more details about the remaining
   arguments.

   Returns a pair of "(transport, protocol)", where _transport_
   conforms to the "SubprocessTransport" base class and _protocol_ is
   an object instantiated by the _protocol_factory_.

Note:

  It is the application’s responsibility to ensure that all whitespace
  and special characters are quoted appropriately to avoid shell
  injection vulnerabilities. The "shlex.quote()" function can be used
  to properly escape whitespace and special characters in strings that
  are going to be used to construct shell commands.


Callback Handles
================

class asyncio.Handle                   *Handle..asyncio-eventloop.pyx*

   A callback wrapper object returned by "loop.call_soon()",
   "loop.call_soon_threadsafe()".

   get_context()            *Handle.get_context()..asyncio-eventloop.pyx*

      Return the "contextvars.Context" object associated with the
      handle.

      New in version 3.12.

   cancel()                      *Handle.cancel()..asyncio-eventloop.pyx*

      Cancel the callback.  If the callback has already been canceled
      or executed, this method has no effect.

   cancelled()                *Handle.cancelled()..asyncio-eventloop.pyx*

      Return "True" if the callback was cancelled.

      New in version 3.7.

class asyncio.TimerHandle         *TimerHandle..asyncio-eventloop.pyx*

   A callback wrapper object returned by "loop.call_later()", and
   "loop.call_at()".

   This class is a subclass of "Handle".

   when()                     *TimerHandle.when()..asyncio-eventloop.pyx*

      Return a scheduled callback time as "float" seconds.

      The time is an absolute timestamp, using the same time reference
      as "loop.time()".

      New in version 3.7.


Server Objects
==============

Server objects are created by "loop.create_server()",
"loop.create_unix_server()", "start_server()", and
"start_unix_server()" functions.

Do not instantiate the "Server" class directly.

class asyncio.Server                   *Server..asyncio-eventloop.pyx*

   _Server_ objects are asynchronous context managers.  When used in
   an "async with" statement, it’s guaranteed that the Server object
   is closed and not accepting new connections when the "async with"
   statement is completed:
>
      srv = await loop.create_server(...)

      async with srv:
          # some code

      # At this point, srv is closed and no longer accepts new connections.
<
   Changed in version 3.7: Server object is an asynchronous context
   manager since Python 3.7.

   Changed in version 3.11: This class was exposed publicly as
   "asyncio.Server" in Python 3.9.11, 3.10.3 and 3.11.

   close()                        *Server.close()..asyncio-eventloop.pyx*

      Stop serving: close listening sockets and set the "sockets"
      attribute to "None".

      The sockets that represent existing incoming client connections
      are left open.

      The server is closed asynchronously, use the "wait_closed()"
      coroutine to wait until the server is closed.

   get_loop()                  *Server.get_loop()..asyncio-eventloop.pyx*

      Return the event loop associated with the server object.

      New in version 3.7.

                       *Server.start_serving()..asyncio-eventloop.pyx*
   coroutine start_serving()

      Start accepting connections.

      This method is idempotent, so it can be called when the server
      is already serving.

      The _start_serving_ keyword-only parameter to
      "loop.create_server()" and "asyncio.start_server()" allows
      creating a Server object that is not accepting connections
      initially.  In this case "Server.start_serving()", or
      "Server.serve_forever()" can be used to make the Server start
      accepting connections.

      New in version 3.7.

                       *Server.serve_forever()..asyncio-eventloop.pyx*
   coroutine serve_forever()

      Start accepting connections until the coroutine is cancelled.
      Cancellation of "serve_forever" task causes the server to be
      closed.

      This method can be called if the server is already accepting
      connections.  Only one "serve_forever" task can exist per one
      _Server_ object.

      Example:
>
         async def client_connected(reader, writer):
             # Communicate with the client with
             # reader/writer streams.  For example:
             await reader.readline()

         async def main(host, port):
             srv = await asyncio.start_server(
                 client_connected, host, port)
             await srv.serve_forever()

         asyncio.run(main('127.0.0.1', 0))
<
      New in version 3.7.

   is_serving()              *Server.is_serving()..asyncio-eventloop.pyx*

      Return "True" if the server is accepting new connections.

      New in version 3.7.

                         *Server.wait_closed()..asyncio-eventloop.pyx*
   coroutine wait_closed()

      Wait until the "close()" method completes.

   sockets                        *Server.sockets..asyncio-eventloop.pyx*

      List of socket-like objects, "asyncio.trsock.TransportSocket",
      which the server is listening on.

      Changed in version 3.7: Prior to Python 3.7 "Server.sockets"
      used to return an internal list of server sockets directly.  In
      3.7 a copy of that list is returned.


Event Loop Implementations
==========================

asyncio ships with two different event loop implementations:
"SelectorEventLoop" and "ProactorEventLoop".

By default asyncio is configured to use "SelectorEventLoop" on Unix
and "ProactorEventLoop" on Windows.

                            *SelectorEventLoop..asyncio-eventloop.pyx*
class asyncio.SelectorEventLoop

   An event loop based on the "selectors" module.

   Uses the most efficient _selector_ available for the given
   platform.  It is also possible to manually configure the exact
   selector implementation to be used:
>
      import asyncio
      import selectors

      class MyPolicy(asyncio.DefaultEventLoopPolicy):
         def new_event_loop(self):
            selector = selectors.SelectSelector()
            return asyncio.SelectorEventLoop(selector)

      asyncio.set_event_loop_policy(MyPolicy())
<
   Availability: Unix, Windows.

                            *ProactorEventLoop..asyncio-eventloop.pyx*
class asyncio.ProactorEventLoop

   An event loop for Windows that uses “I/O Completion Ports” (IOCP).

   Availability: Windows.

   See also: MSDN documentation on I/O Completion Ports.

                            *AbstractEventLoop..asyncio-eventloop.pyx*
class asyncio.AbstractEventLoop

   Abstract base class for asyncio-compliant event loops.

   The Event Loop Methods section lists all methods that an
   alternative implementation of "AbstractEventLoop" should have
   defined.


Examples
========

Note that all examples in this section **purposefully** show how to
use the low-level event loop APIs, such as "loop.run_forever()" and
"loop.call_soon()".  Modern asyncio applications rarely need to be
written this way; consider using the high-level functions like
"asyncio.run()".


Hello World with call_soon()
----------------------------

An example using the "loop.call_soon()" method to schedule a callback.
The callback displays ""Hello World"" and then stops the event loop:
>
   import asyncio

   def hello_world(loop):
       """A callback to print 'Hello World' and stop the event loop"""
       print('Hello World')
       loop.stop()

   loop = asyncio.new_event_loop()

   # Schedule a call to hello_world()
   loop.call_soon(hello_world, loop)

   # Blocking call interrupted by loop.stop()
   try:
       loop.run_forever()
   finally:
       loop.close()
<
See also:

  A similar Hello World example created with a coroutine and the
  "run()" function.


Display the current date with call_later()
------------------------------------------

An example of a callback displaying the current date every second. The
callback uses the "loop.call_later()" method to reschedule itself
after 5 seconds, and then stops the event loop:
>
   import asyncio
   import datetime

   def display_date(end_time, loop):
       print(datetime.datetime.now())
       if (loop.time() + 1.0) < end_time:
           loop.call_later(1, display_date, end_time, loop)
       else:
           loop.stop()

   loop = asyncio.new_event_loop()

   # Schedule the first call to display_date()
   end_time = loop.time() + 5.0
   loop.call_soon(display_date, end_time, loop)

   # Blocking call interrupted by loop.stop()
   try:
       loop.run_forever()
   finally:
       loop.close()
<
See also:

  A similar current date example created with a coroutine and the
  "run()" function.


Watch a file descriptor for read events
---------------------------------------

Wait until a file descriptor received some data using the
"loop.add_reader()" method and then close the event loop:
>
   import asyncio
   from socket import socketpair

   # Create a pair of connected file descriptors
   rsock, wsock = socketpair()

   loop = asyncio.new_event_loop()

   def reader():
       data = rsock.recv(100)
       print("Received:", data.decode())

       # We are done: unregister the file descriptor
       loop.remove_reader(rsock)

       # Stop the event loop
       loop.stop()

   # Register the file descriptor for read event
   loop.add_reader(rsock, reader)

   # Simulate the reception of data from the network
   loop.call_soon(wsock.send, 'abc'.encode())

   try:
       # Run the event loop
       loop.run_forever()
   finally:
       # We are done. Close sockets and the event loop.
       rsock.close()
       wsock.close()
       loop.close()
<
See also:

  * A similar example using transports, protocols, and the
    "loop.create_connection()" method.

  * Another similar example using the high-level
    "asyncio.open_connection()" function and streams.


Set signal handlers for SIGINT and SIGTERM
------------------------------------------

(This "signals" example only works on Unix.)

Register handlers for signals "SIGINT" and "SIGTERM" using the
"loop.add_signal_handler()" method:
>
   import asyncio
   import functools
   import os
   import signal

   def ask_exit(signame, loop):
       print("got signal %s: exit" % signame)
       loop.stop()

   async def main():
       loop = asyncio.get_running_loop()

       for signame in {'SIGINT', 'SIGTERM'}:
           loop.add_signal_handler(
               getattr(signal, signame),
               functools.partial(ask_exit, signame, loop))

       await asyncio.sleep(3600)

   print("Event loop running for 1 hour, press Ctrl+C to interrupt.")
   print(f"pid {os.getpid()}: send SIGINT or SIGTERM to exit.")

   asyncio.run(main())
<
vim:tw=78:ts=8:ft=help:norl: