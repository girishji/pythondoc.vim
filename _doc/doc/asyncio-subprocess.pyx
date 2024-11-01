*asyncio-subprocess.pyx*                      Last change: 2023 Sep 15

Subprocesses
************

**Source code:** Lib/asyncio/subprocess.py,
Lib/asyncio/base_subprocess.py

======================================================================

This section describes high-level async/await asyncio APIs to create
and manage subprocesses.

Here’s an example of how asyncio can run a shell command and obtain
its result:
>
   import asyncio

   async def run(cmd):
       proc = await asyncio.create_subprocess_shell(
           cmd,
           stdout=asyncio.subprocess.PIPE,
           stderr=asyncio.subprocess.PIPE)

       stdout, stderr = await proc.communicate()

       print(f'[{cmd!r} exited with {proc.returncode}]')
       if stdout:
           print(f'[stdout]\n{stdout.decode()}')
       if stderr:
           print(f'[stderr]\n{stderr.decode()}')

   asyncio.run(run('ls /zzz'))
<
will print:
>
   ['ls /zzz' exited with 1]
   [stderr]
   ls: /zzz: No such file or directory
<
Because all asyncio subprocess functions are asynchronous and asyncio
provides many tools to work with such functions, it is easy to execute
and monitor multiple subprocesses in parallel.  It is indeed trivial
to modify the above example to run several commands simultaneously:
>
   async def main():
       await asyncio.gather(
           run('ls /zzz'),
           run('sleep 1; echo "hello"'))

   asyncio.run(main())
<
See also the Examples subsection.


Creating Subprocesses
=====================

                    *create_subprocess_exec()..asyncio-subprocess.pyx*
coroutine asyncio.create_subprocess_exec(program, *args, stdin=None, stdout=None, stderr=None, limit=None, **kwds)

   Create a subprocess.

   The _limit_ argument sets the buffer limit for "StreamReader"
   wrappers for "Process.stdout" and "Process.stderr" (if
   "subprocess.PIPE" is passed to _stdout_ and _stderr_ arguments).

   Return a "Process" instance.

   See the documentation of "loop.subprocess_exec()" for other
   parameters.

   Changed in version 3.10: Removed the _loop_ parameter.

                   *create_subprocess_shell()..asyncio-subprocess.pyx*
coroutine asyncio.create_subprocess_shell(cmd, stdin=None, stdout=None, stderr=None, limit=None, **kwds)

   Run the _cmd_ shell command.

   The _limit_ argument sets the buffer limit for "StreamReader"
   wrappers for "Process.stdout" and "Process.stderr" (if
   "subprocess.PIPE" is passed to _stdout_ and _stderr_ arguments).

   Return a "Process" instance.

   See the documentation of "loop.subprocess_shell()" for other
   parameters.

   Important:

     It is the application’s responsibility to ensure that all
     whitespace and special characters are quoted appropriately to
     avoid shell injection vulnerabilities. The "shlex.quote()"
     function can be used to properly escape whitespace and special
     shell characters in strings that are going to be used to
     construct shell commands.

   Changed in version 3.10: Removed the _loop_ parameter.

Note:

  Subprocesses are available for Windows if a "ProactorEventLoop" is
  used. See Subprocess Support on Windows for details.

See also:

  asyncio also has the following _low-level_ APIs to work with
  subprocesses: "loop.subprocess_exec()", "loop.subprocess_shell()",
  "loop.connect_read_pipe()", "loop.connect_write_pipe()", as well as
  the Subprocess Transports and Subprocess Protocols.


Constants
=========

                     *asyncio.subprocess.PIPE..asyncio-subprocess.pyx*
asyncio.subprocess.PIPE

   Can be passed to the _stdin_, _stdout_ or _stderr_ parameters.

   If _PIPE_ is passed to _stdin_ argument, the "Process.stdin"
   attribute will point to a "StreamWriter" instance.

   If _PIPE_ is passed to _stdout_ or _stderr_ arguments, the
   "Process.stdout" and "Process.stderr" attributes will point to
   "StreamReader" instances.

                   *asyncio.subprocess.STDOUT..asyncio-subprocess.pyx*
asyncio.subprocess.STDOUT

   Special value that can be used as the _stderr_ argument and
   indicates that standard error should be redirected into standard
   output.

                  *asyncio.subprocess.DEVNULL..asyncio-subprocess.pyx*
asyncio.subprocess.DEVNULL

   Special value that can be used as the _stdin_, _stdout_ or _stderr_
   argument to process creation functions.  It indicates that the
   special file "os.devnull" will be used for the corresponding
   subprocess stream.


Interacting with Subprocesses
=============================

Both "create_subprocess_exec()" and "create_subprocess_shell()"
functions return instances of the _Process_ class.  _Process_ is a
high-level wrapper that allows communicating with subprocesses and
watching for their completion.

                  *asyncio.subprocess.Process..asyncio-subprocess.pyx*
class asyncio.subprocess.Process

   An object that wraps OS processes created by the
   "create_subprocess_exec()" and "create_subprocess_shell()"
   functions.

   This class is designed to have a similar API to the
   "subprocess.Popen" class, but there are some notable differences:

   * unlike Popen, Process instances do not have an equivalent to the
     "poll()" method;

   * the "communicate()" and "wait()" methods don’t have a _timeout_
     parameter: use the "wait_for()" function;

   * the "Process.wait()" method is asynchronous, whereas
     "subprocess.Popen.wait()" method is implemented as a blocking
     busy loop;

   * the _universal_newlines_ parameter is not supported.

   This class is not thread safe.

   See also the Subprocess and Threads section.

           *asyncio.subprocess.Process.wait()..asyncio-subprocess.pyx*
   coroutine wait()

      Wait for the child process to terminate.

      Set and return the "returncode" attribute.

      Note:

        This method can deadlock when using "stdout=PIPE" or
        "stderr=PIPE" and the child process generates so much output
        that it blocks waiting for the OS pipe buffer to accept more
        data. Use the "communicate()" method when using pipes to avoid
        this condition.

    *asyncio.subprocess.Process.communicate()..asyncio-subprocess.pyx*
   coroutine communicate(input=None)

      Interact with process:

      1. send data to _stdin_ (if _input_ is not "None");

      2. closes _stdin_;

      3. read data from _stdout_ and _stderr_, until EOF is reached;

      4. wait for process to terminate.

      The optional _input_ argument is the data ("bytes" object) that
      will be sent to the child process.

      Return a tuple "(stdout_data, stderr_data)".

      If either "BrokenPipeError" or "ConnectionResetError" exception
      is raised when writing _input_ into _stdin_, the exception is
      ignored.  This condition occurs when the process exits before
      all data are written into _stdin_.

      If it is desired to send data to the process’ _stdin_, the
      process needs to be created with "stdin=PIPE".  Similarly, to
      get anything other than "None" in the result tuple, the process
      has to be created with "stdout=PIPE" and/or "stderr=PIPE"
      arguments.

      Note, that the data read is buffered in memory, so do not use
      this method if the data size is large or unlimited.

      Changed in version 3.12: _stdin_ gets closed when _input=None_
      too.

    *asyncio.subprocess.Process.send_signal()..asyncio-subprocess.pyx*
   send_signal(signal)

      Sends the signal _signal_ to the child process.

      Note:

        On Windows, "SIGTERM" is an alias for "terminate()".
        "CTRL_C_EVENT" and "CTRL_BREAK_EVENT" can be sent to processes
        started with a _creationflags_ parameter which includes
        "CREATE_NEW_PROCESS_GROUP".

      *asyncio.subprocess.Process.terminate()..asyncio-subprocess.pyx*
   terminate()

      Stop the child process.

      On POSIX systems this method sends "signal.SIGTERM" to the child
      process.

      On Windows the Win32 API function "TerminateProcess()" is called
      to stop the child process.

   kill()     *asyncio.subprocess.Process.kill()..asyncio-subprocess.pyx*

      Kill the child process.

      On POSIX systems this method sends "SIGKILL" to the child
      process.

      On Windows this method is an alias for "terminate()".

   stdin       *asyncio.subprocess.Process.stdin..asyncio-subprocess.pyx*

      Standard input stream ("StreamWriter") or "None" if the process
      was created with "stdin=None".

   stdout     *asyncio.subprocess.Process.stdout..asyncio-subprocess.pyx*

      Standard output stream ("StreamReader") or "None" if the process
      was created with "stdout=None".

   stderr     *asyncio.subprocess.Process.stderr..asyncio-subprocess.pyx*

      Standard error stream ("StreamReader") or "None" if the process
      was created with "stderr=None".

   Warning:

     Use the "communicate()" method rather than
     "process.stdin.write()", "await process.stdout.read()" or "await
     process.stderr.read()". This avoids deadlocks due to streams
     pausing reading or writing and blocking the child process.

   pid           *asyncio.subprocess.Process.pid..asyncio-subprocess.pyx*

      Process identification number (PID).

      Note that for processes created by the
      "create_subprocess_shell()" function, this attribute is the PID
      of the spawned shell.

       *asyncio.subprocess.Process.returncode..asyncio-subprocess.pyx*
   returncode

      Return code of the process when it exits.

      A "None" value indicates that the process has not terminated
      yet.

      A negative value "-N" indicates that the child was terminated by
      signal "N" (POSIX only).


Subprocess and Threads
----------------------

Standard asyncio event loop supports running subprocesses from
different threads by default.

On Windows subprocesses are provided by "ProactorEventLoop" only
(default), "SelectorEventLoop" has no subprocess support.

On UNIX _child watchers_ are used for subprocess finish waiting, see
Process Watchers for more info.

Changed in version 3.8: UNIX switched to use "ThreadedChildWatcher"
for spawning subprocesses from different threads without any
limitation.Spawning a subprocess with _inactive_ current child watcher
raises "RuntimeError".

Note that alternative event loop implementations might have own
limitations; please refer to their documentation.

See also: The Concurrency and multithreading in asyncio section.


Examples
--------

An example using the "Process" class to control a subprocess and the
"StreamReader" class to read from its standard output.

The subprocess is created by the "create_subprocess_exec()" function:
>
   import asyncio
   import sys

   async def get_date():
       code = 'import datetime; print(datetime.datetime.now())'

       # Create the subprocess; redirect the standard output
       # into a pipe.
       proc = await asyncio.create_subprocess_exec(
           sys.executable, '-c', code,
           stdout=asyncio.subprocess.PIPE)

       # Read one line of output.
       data = await proc.stdout.readline()
       line = data.decode('ascii').rstrip()

       # Wait for the subprocess exit.
       await proc.wait()
       return line

   date = asyncio.run(get_date())
   print(f"Current date: {date}")
<
See also the same example written using low-level APIs.

vim:tw=78:ts=8:ft=help:norl: