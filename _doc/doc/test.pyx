*test.pyx*                                    Last change: 2023 Sep 15

"test" — Regression tests package for Python
********************************************

Note:

  The "test" package is meant for internal use by Python only. It is
  documented for the benefit of the core developers of Python. Any use
  of this package outside of Python’s standard library is discouraged
  as code mentioned here can change or be removed without notice
  between releases of Python.

======================================================================

The "test" package contains all regression tests for Python as well as
the modules "test.support" and "test.regrtest". "test.support" is used
to enhance your tests while "test.regrtest" drives the testing suite.

Each module in the "test" package whose name starts with "test_" is a
testing suite for a specific module or feature. All new tests should
be written using the "unittest" or "doctest" module.  Some older tests
are written using a “traditional” testing style that compares output
printed to "sys.stdout"; this style of test is considered deprecated.

See also:

  Module "unittest"
     Writing PyUnit regression tests.

  Module "doctest"
     Tests embedded in documentation strings.


Writing Unit Tests for the "test" package
=========================================

It is preferred that tests that use the "unittest" module follow a few
guidelines. One is to name the test module by starting it with "test_"
and end it with the name of the module being tested. The test methods
in the test module should start with "test_" and end with a
description of what the method is testing. This is needed so that the
methods are recognized by the test driver as test methods. Also, no
documentation string for the method should be included. A comment
(such as "# Tests function returns only True or False") should be used
to provide documentation for test methods. This is done because
documentation strings get printed out if they exist and thus what test
is being run is not stated.

A basic boilerplate is often used:
>
   import unittest
   from test import support

   class MyTestCase1(unittest.TestCase):

       # Only use setUp() and tearDown() if necessary

       def setUp(self):
           ... code to execute in preparation for tests ...

       def tearDown(self):
           ... code to execute to clean up after tests ...

       def test_feature_one(self):
           # Test feature one.
           ... testing code ...

       def test_feature_two(self):
           # Test feature two.
           ... testing code ...

       ... more test methods ...

   class MyTestCase2(unittest.TestCase):
       ... same structure as MyTestCase1 ...

   ... more test classes ...

   if __name__ == '__main__':
       unittest.main()
<
This code pattern allows the testing suite to be run by
"test.regrtest", on its own as a script that supports the "unittest"
CLI, or via the "python -m unittest" CLI.

The goal for regression testing is to try to break code. This leads to
a few guidelines to be followed:

* The testing suite should exercise all classes, functions, and
  constants. This includes not just the external API that is to be
  presented to the outside world but also “private” code.

* Whitebox testing (examining the code being tested when the tests are
  being written) is preferred. Blackbox testing (testing only the
  published user interface) is not complete enough to make sure all
  boundary and edge cases are tested.

* Make sure all possible values are tested including invalid ones.
  This makes sure that not only all valid values are acceptable but
  also that improper values are handled correctly.

* Exhaust as many code paths as possible. Test where branching occurs
  and thus tailor input to make sure as many different paths through
  the code are taken.

* Add an explicit test for any bugs discovered for the tested code.
  This will make sure that the error does not crop up again if the
  code is changed in the future.

* Make sure to clean up after your tests (such as close and remove all
  temporary files).

* If a test is dependent on a specific condition of the operating
  system then verify the condition already exists before attempting
  the test.

* Import as few modules as possible and do it as soon as possible.
  This minimizes external dependencies of tests and also minimizes
  possible anomalous behavior from side-effects of importing a module.

* Try to maximize code reuse. On occasion, tests will vary by
  something as small as what type of input is used. Minimize code
  duplication by subclassing a basic test class with a class that
  specifies the input:
>
     class TestFuncAcceptsSequencesMixin:

         func = mySuperWhammyFunction

         def test_func(self):
             self.func(self.arg)

     class AcceptLists(TestFuncAcceptsSequencesMixin, unittest.TestCase):
         arg = [1, 2, 3]

     class AcceptStrings(TestFuncAcceptsSequencesMixin, unittest.TestCase):
         arg = 'abc'

     class AcceptTuples(TestFuncAcceptsSequencesMixin, unittest.TestCase):
         arg = (1, 2, 3)
<
  When using this pattern, remember that all classes that inherit from
  "unittest.TestCase" are run as tests.  The "Mixin" class in the
  example above does not have any data and so can’t be run by itself,
  thus it does not inherit from "unittest.TestCase".

See also:

  Test Driven Development
     A book by Kent Beck on writing tests before code.


Running tests using the command-line interface
==============================================

The "test" package can be run as a script to drive Python’s regression
test suite, thanks to the "-m" option: **python -m test**. Under the
hood, it uses "test.regrtest"; the call **python -m test.regrtest**
used in previous Python versions still works.  Running the script by
itself automatically starts running all regression tests in the "test"
package. It does this by finding all modules in the package whose name
starts with "test_", importing them, and executing the function
"test_main()" if present or loading the tests via
unittest.TestLoader.loadTestsFromModule if "test_main" does not exist.
The names of tests to execute may also be passed to the script.
Specifying a single regression test (**python -m test test_spam**)
will minimize output and only print whether the test passed or failed.

Running "test" directly allows what resources are available for tests
to use to be set. You do this by using the "-u" command-line option.
Specifying "all" as the value for the "-u" option enables all possible
resources: **python -m test -uall**. If all but one resource is
desired (a more common case), a comma-separated list of resources that
are not desired may be listed after "all". The command **python -m
test -uall,-audio,-largefile** will run "test" with all resources
except the "audio" and "largefile" resources. For a list of all
resources and more command-line options, run **python -m test -h**.

Some other ways to execute the regression tests depend on what
platform the tests are being executed on. On Unix, you can run **make
test** at the top-level directory where Python was built. On Windows,
executing **rt.bat** from your "PCbuild" directory will run all
regression tests.


"test.support" — Utilities for the Python test suite
****************************************************

The "test.support" module provides support for Python’s regression
test suite.

Note:

  "test.support" is not a public module.  It is documented here to
  help Python developers write tests.  The API of this module is
  subject to change without backwards compatibility concerns between
  releases.

This module defines the following exceptions:

exception test.support.TestFailed               *TestFailed..test.pyx*

   Exception to be raised when a test fails. This is deprecated in
   favor of "unittest"-based tests and "unittest.TestCase"’s assertion
   methods.

exception test.support.ResourceDenied       *ResourceDenied..test.pyx*

   Subclass of "unittest.SkipTest". Raised when a resource (such as a
   network connection) is not available. Raised by the "requires()"
   function.

The "test.support" module defines the following constants:

test.support.verbose                               *verbose..test.pyx*

   "True" when verbose output is enabled. Should be checked when more
   detailed information is desired about a running test. _verbose_ is
   set by "test.regrtest".

test.support.is_jython                           *is_jython..test.pyx*

   "True" if the running interpreter is Jython.

test.support.is_android                         *is_android..test.pyx*

   "True" if the system is Android.

test.support.unix_shell                         *unix_shell..test.pyx*

   Path for shell if not on Windows; otherwise "None".

test.support.LOOPBACK_TIMEOUT             *LOOPBACK_TIMEOUT..test.pyx*

   Timeout in seconds for tests using a network server listening on
   the network local loopback interface like "127.0.0.1".

   The timeout is long enough to prevent test failure: it takes into
   account that the client and the server can run in different threads
   or even different processes.

   The timeout should be long enough for "connect()", "recv()" and
   "send()" methods of "socket.socket".

   Its default value is 5 seconds.

   See also "INTERNET_TIMEOUT".

test.support.INTERNET_TIMEOUT             *INTERNET_TIMEOUT..test.pyx*

   Timeout in seconds for network requests going to the internet.

   The timeout is short enough to prevent a test to wait for too long
   if the internet request is blocked for whatever reason.

   Usually, a timeout using "INTERNET_TIMEOUT" should not mark a test
   as failed, but skip the test instead: see "transient_internet()".

   Its default value is 1 minute.

   See also "LOOPBACK_TIMEOUT".

test.support.SHORT_TIMEOUT                   *SHORT_TIMEOUT..test.pyx*

   Timeout in seconds to mark a test as failed if the test takes “too
   long”.

   The timeout value depends on the regrtest "--timeout" command line
   option.

   If a test using "SHORT_TIMEOUT" starts to fail randomly on slow
   buildbots, use "LONG_TIMEOUT" instead.

   Its default value is 30 seconds.

test.support.LONG_TIMEOUT                     *LONG_TIMEOUT..test.pyx*

   Timeout in seconds to detect when a test hangs.

   It is long enough to reduce the risk of test failure on the slowest
   Python buildbots. It should not be used to mark a test as failed if
   the test takes “too long”.  The timeout value depends on the
   regrtest "--timeout" command line option.

   Its default value is 5 minutes.

   See also "LOOPBACK_TIMEOUT", "INTERNET_TIMEOUT" and
   "SHORT_TIMEOUT".

test.support.PGO                                       *PGO..test.pyx*

   Set when tests can be skipped when they are not useful for PGO.

test.support.PIPE_MAX_SIZE                   *PIPE_MAX_SIZE..test.pyx*

   A constant that is likely larger than the underlying OS pipe buffer
   size, to make writes blocking.

test.support.Py_DEBUG                             *Py_DEBUG..test.pyx*

   True if Python is built with the "Py_DEBUG" macro defined: if
   Python is built in debug mode ("./configure --with-pydebug").

   New in version 3.12.

test.support.SOCK_MAX_SIZE                   *SOCK_MAX_SIZE..test.pyx*

   A constant that is likely larger than the underlying OS socket
   buffer size, to make writes blocking.

test.support.TEST_SUPPORT_DIR             *TEST_SUPPORT_DIR..test.pyx*

   Set to the top level directory that contains "test.support".

test.support.TEST_HOME_DIR                   *TEST_HOME_DIR..test.pyx*

   Set to the top level directory for the test package.

test.support.TEST_DATA_DIR                   *TEST_DATA_DIR..test.pyx*

   Set to the "data" directory within the test package.

test.support.MAX_Py_ssize_t                 *MAX_Py_ssize_t..test.pyx*

   Set to "sys.maxsize" for big memory tests.

test.support.max_memuse                         *max_memuse..test.pyx*

   Set by "set_memlimit()" as the memory limit for big memory tests.
   Limited by "MAX_Py_ssize_t".

test.support.real_max_memuse               *real_max_memuse..test.pyx*

   Set by "set_memlimit()" as the memory limit for big memory tests.
   Not limited by "MAX_Py_ssize_t".

test.support.MISSING_C_DOCSTRINGS     *MISSING_C_DOCSTRINGS..test.pyx*

   Set to "True" if Python is built without docstrings (the
   "WITH_DOC_STRINGS" macro is not defined). See the "configure
   --without-doc-strings" option.

   See also the "HAVE_DOCSTRINGS" variable.

test.support.HAVE_DOCSTRINGS               *HAVE_DOCSTRINGS..test.pyx*

   Set to "True" if function docstrings are available. See the "python
   -OO" option, which strips docstrings of functions implemented in
   Python.

   See also the "MISSING_C_DOCSTRINGS" variable.

test.support.TEST_HTTP_URL                   *TEST_HTTP_URL..test.pyx*

   Define the URL of a dedicated HTTP server for the network tests.

test.support.ALWAYS_EQ                           *ALWAYS_EQ..test.pyx*

   Object that is equal to anything.  Used to test mixed type
   comparison.

test.support.NEVER_EQ                             *NEVER_EQ..test.pyx*

   Object that is not equal to anything (even to "ALWAYS_EQ"). Used to
   test mixed type comparison.

test.support.LARGEST                               *LARGEST..test.pyx*

   Object that is greater than anything (except itself). Used to test
   mixed type comparison.

test.support.SMALLEST                             *SMALLEST..test.pyx*

   Object that is less than anything (except itself). Used to test
   mixed type comparison.

The "test.support" module defines the following functions:

                                              *busy_retry()..test.pyx*
test.support.busy_retry(timeout, err_msg=None, /, *, error=True)

   Run the loop body until "break" stops the loop.

   After _timeout_ seconds, raise an "AssertionError" if _error_ is
   true, or just stop the loop if _error_ is false.

   Example:
>
      for _ in support.busy_retry(support.SHORT_TIMEOUT):
          if check():
              break
<
   Example of error=False usage:
>
      for _ in support.busy_retry(support.SHORT_TIMEOUT, error=False):
          if check():
              break
      else:
          raise RuntimeError('my custom error')
<

                                          *sleeping_retry()..test.pyx*
test.support.sleeping_retry(timeout, err_msg=None, /, *, init_delay=0.010, max_delay=1.0, error=True)

   Wait strategy that applies exponential backoff.

   Run the loop body until "break" stops the loop. Sleep at each loop
   iteration, but not at the first iteration. The sleep delay is
   doubled at each iteration (up to _max_delay_ seconds).

   See "busy_retry()" documentation for the parameters usage.

   Example raising an exception after SHORT_TIMEOUT seconds:
>
      for _ in support.sleeping_retry(support.SHORT_TIMEOUT):
          if check():
              break
<
   Example of error=False usage:
>
      for _ in support.sleeping_retry(support.SHORT_TIMEOUT, error=False):
          if check():
              break
      else:
          raise RuntimeError('my custom error')
<

                                     *is_resource_enabled()..test.pyx*
test.support.is_resource_enabled(resource)

   Return "True" if _resource_ is enabled and available. The list of
   available resources is only set when "test.regrtest" is executing
   the tests.

test.support.python_is_optimized()   *python_is_optimized()..test.pyx*

   Return "True" if Python was not built with "-O0" or "-Og".

test.support.with_pymalloc()               *with_pymalloc()..test.pyx*

   Return "_testcapi.WITH_PYMALLOC".

test.support.requires(resource, msg=None)       *requires()..test.pyx*

   Raise "ResourceDenied" if _resource_ is not available. _msg_ is the
   argument to "ResourceDenied" if it is raised. Always returns "True"
   if called by a function whose "__name__" is "'__main__'". Used when
   tests are executed by "test.regrtest".

test.support.sortdict(dict)                     *sortdict()..test.pyx*

   Return a repr of _dict_ with keys sorted.

test.support.findfile(filename, subdir=None)    *findfile()..test.pyx*

   Return the path to the file named _filename_. If no match is found
   _filename_ is returned. This does not equal a failure since it
   could be the path to the file.

   Setting _subdir_ indicates a relative path to use to find the file
   rather than looking directly in the path directories.

test.support.match_test(test)                 *match_test()..test.pyx*

   Determine whether _test_ matches the patterns set in
   "set_match_tests()".

                                         *set_match_tests()..test.pyx*
test.support.set_match_tests(accept_patterns=None, ignore_patterns=None)

   Define match patterns on test filenames and test method names for
   filtering tests.

test.support.run_unittest(*classes)         *run_unittest()..test.pyx*

   Execute "unittest.TestCase" subclasses passed to the function. The
   function scans the classes for methods starting with the prefix
   "test_" and executes the tests individually.

   It is also legal to pass strings as parameters; these should be
   keys in "sys.modules". Each associated module will be scanned by
   "unittest.TestLoader.loadTestsFromModule()". This is usually seen
   in the following "test_main()" function:
>
      def test_main():
          support.run_unittest(__name__)
<
   This will run all tests defined in the named module.

                                             *run_doctest()..test.pyx*
test.support.run_doctest(module, verbosity=None, optionflags=0)

   Run "doctest.testmod()" on the given _module_.  Return
   "(failure_count, test_count)".

   If _verbosity_ is "None", "doctest.testmod()" is run with verbosity
   set to "verbose".  Otherwise, it is run with verbosity set to
   "None".  _optionflags_ is passed as "optionflags" to
   "doctest.testmod()".

test.support.get_pagesize()                 *get_pagesize()..test.pyx*

   Get size of a page in bytes.

   New in version 3.12.

                                       *setswitchinterval()..test.pyx*
test.support.setswitchinterval(interval)

   Set the "sys.setswitchinterval()" to the given _interval_.  Defines
   a minimum interval for Android systems to prevent the system from
   hanging.

                                       *check_impl_detail()..test.pyx*
test.support.check_impl_detail(**guards)

   Use this check to guard CPython’s implementation-specific tests or
   to run them only on the implementations guarded by the arguments.
   This function returns "True" or "False" depending on the host
   platform. Example usage:
>
      check_impl_detail()               # Only on CPython (default).
      check_impl_detail(jython=True)    # Only on Jython.
      check_impl_detail(cpython=False)  # Everywhere except CPython.
<
test.support.set_memlimit(limit)            *set_memlimit()..test.pyx*

   Set the values for "max_memuse" and "real_max_memuse" for big
   memory tests.

                                  *record_original_stdout()..test.pyx*
test.support.record_original_stdout(stdout)

   Store the value from _stdout_.  It is meant to hold the stdout at
   the time the regrtest began.

test.support.get_original_stdout()   *get_original_stdout()..test.pyx*

   Return the original stdout set by "record_original_stdout()" or
   "sys.stdout" if it’s not set.

                             *args_from_interpreter_flags()..test.pyx*
test.support.args_from_interpreter_flags()

   Return a list of command line arguments reproducing the current
   settings in "sys.flags" and "sys.warnoptions".

                       *optim_args_from_interpreter_flags()..test.pyx*
test.support.optim_args_from_interpreter_flags()

   Return a list of command line arguments reproducing the current
   optimization settings in "sys.flags".

test.support.captured_stdin()             *captured_stdin()..test.pyx*
test.support.captured_stdout()           *captured_stdout()..test.pyx*
test.support.captured_stderr()           *captured_stderr()..test.pyx*

   A context managers that temporarily replaces the named stream with
   "io.StringIO" object.

   Example use with output streams:
>
      with captured_stdout() as stdout, captured_stderr() as stderr:
          print("hello")
          print("error", file=sys.stderr)
      assert stdout.getvalue() == "hello\n"
      assert stderr.getvalue() == "error\n"
<
   Example use with input stream:
>
      with captured_stdin() as stdin:
          stdin.write('hello\n')
          stdin.seek(0)
          # call test code that consumes from sys.stdin
          captured = input()
      self.assertEqual(captured, "hello")
<

                                    *disable_faulthandler()..test.pyx*
test.support.disable_faulthandler()

   A context manager that temporary disables "faulthandler".

test.support.gc_collect()                     *gc_collect()..test.pyx*

   Force as many objects as possible to be collected.  This is needed
   because timely deallocation is not guaranteed by the garbage
   collector.  This means that "__del__" methods may be called later
   than expected and weakrefs may remain alive for longer than
   expected.

test.support.disable_gc()                     *disable_gc()..test.pyx*

   A context manager that disables the garbage collector on entry. On
   exit, the garbage collector is restored to its prior state.

test.support.swap_attr(obj, attr, new_val)     *swap_attr()..test.pyx*

   Context manager to swap out an attribute with a new object.

   Usage:
>
      with swap_attr(obj, "attr", 5):
          ...
<
   This will set "obj.attr" to 5 for the duration of the "with" block,
   restoring the old value at the end of the block.  If "attr" doesn’t
   exist on "obj", it will be created and then deleted at the end of
   the block.

   The old value (or "None" if it doesn’t exist) will be assigned to
   the target of the “as” clause, if there is one.

test.support.swap_item(obj, attr, new_val)     *swap_item()..test.pyx*

   Context manager to swap out an item with a new object.

   Usage:
>
      with swap_item(obj, "item", 5):
          ...
<
   This will set "obj["item"]" to 5 for the duration of the "with"
   block, restoring the old value at the end of the block. If "item"
   doesn’t exist on "obj", it will be created and then deleted at the
   end of the block.

   The old value (or "None" if it doesn’t exist) will be assigned to
   the target of the “as” clause, if there is one.

test.support.flush_std_streams()       *flush_std_streams()..test.pyx*

   Call the "flush()" method on "sys.stdout" and then on "sys.stderr".
   It can be used to make sure that the logs order is consistent
   before writing into stderr.

   New in version 3.11.

test.support.print_warning(msg)            *print_warning()..test.pyx*

   Print a warning into "sys.__stderr__". Format the message as:
   "f"Warning -- {msg}"". If _msg_ is made of multiple lines, add
   ""Warning -- "" prefix to each line.

   New in version 3.9.

                                            *wait_process()..test.pyx*
test.support.wait_process(pid, *, exitcode, timeout=None)

   Wait until process _pid_ completes and check that the process exit
   code is _exitcode_.

   Raise an "AssertionError" if the process exit code is not equal to
   _exitcode_.

   If the process runs longer than _timeout_ seconds ("SHORT_TIMEOUT"
   by default), kill the process and raise an "AssertionError". The
   timeout feature is not available on Windows.

   New in version 3.9.

test.support.calcobjsize(fmt)                *calcobjsize()..test.pyx*

   Return the size of the "PyObject" whose structure members are
   defined by _fmt_. The returned value includes the size of the
   Python object header and alignment.

test.support.calcvobjsize(fmt)              *calcvobjsize()..test.pyx*

   Return the size of the "PyVarObject" whose structure members are
   defined by _fmt_. The returned value includes the size of the
   Python object header and alignment.

test.support.checksizeof(test, o, size)      *checksizeof()..test.pyx*

   For testcase _test_, assert that the "sys.getsizeof" for _o_ plus
   the GC header size equals _size_.

                                      *anticipate_failure()..test.pyx*
@test.support.anticipate_failure(condition)

   A decorator to conditionally mark tests with
   "unittest.expectedFailure()". Any use of this decorator should have
   an associated comment identifying the relevant tracker issue.

                               *system_must_validate_cert()..test.pyx*
test.support.system_must_validate_cert(f)

   A decorator that skips the decorated test on TLS certification
   validation failures.

                                         *run_with_locale()..test.pyx*
@test.support.run_with_locale(catstr, *locales)

   A decorator for running a function in a different locale, correctly
   resetting it after it has finished.  _catstr_ is the locale
   category as a string (for example ""LC_ALL"").  The _locales_
   passed will be tried sequentially, and the first valid locale will
   be used.

@test.support.run_with_tz(tz)                *run_with_tz()..test.pyx*

   A decorator for running a function in a specific timezone,
   correctly resetting it after it has finished.

                                *requires_freebsd_version()..test.pyx*
@test.support.requires_freebsd_version(*min_version)

   Decorator for the minimum version when running test on FreeBSD.  If
   the FreeBSD version is less than the minimum, the test is skipped.

                                  *requires_linux_version()..test.pyx*
@test.support.requires_linux_version(*min_version)

   Decorator for the minimum version when running test on Linux.  If
   the Linux version is less than the minimum, the test is skipped.

                                    *requires_mac_version()..test.pyx*
@test.support.requires_mac_version(*min_version)

   Decorator for the minimum version when running test on macOS.  If
   the macOS version is less than the minimum, the test is skipped.

@test.support.requires_IEEE_754        *requires_IEEE_754()..test.pyx*

   Decorator for skipping tests on non-IEEE 754 platforms.

@test.support.requires_zlib                *requires_zlib()..test.pyx*

   Decorator for skipping tests if "zlib" doesn’t exist.

@test.support.requires_gzip                *requires_gzip()..test.pyx*

   Decorator for skipping tests if "gzip" doesn’t exist.

@test.support.requires_bz2                  *requires_bz2()..test.pyx*

   Decorator for skipping tests if "bz2" doesn’t exist.

@test.support.requires_lzma                *requires_lzma()..test.pyx*

   Decorator for skipping tests if "lzma" doesn’t exist.

                                       *requires_resource()..test.pyx*
@test.support.requires_resource(resource)

   Decorator for skipping tests if _resource_ is not available.

@test.support.requires_docstrings    *requires_docstrings()..test.pyx*

   Decorator for only running the test if "HAVE_DOCSTRINGS".

                                    *requires_limited_api()..test.pyx*
@test.support.requires_limited_api

   Decorator for only running the test if Limited C API is available.

@test.support.cpython_only                  *cpython_only()..test.pyx*

   Decorator for tests only applicable to CPython.

                                             *impl_detail()..test.pyx*
@test.support.impl_detail(msg=None, **guards)

   Decorator for invoking "check_impl_detail()" on _guards_.  If that
   returns "False", then uses _msg_ as the reason for skipping the
   test.

@test.support.no_tracing                      *no_tracing()..test.pyx*

   Decorator to temporarily turn off tracing for the duration of the
   test.

@test.support.refcount_test                *refcount_test()..test.pyx*

   Decorator for tests which involve reference counting.  The
   decorator does not run the test if it is not run by CPython.  Any
   trace function is unset for the duration of the test to prevent
   unexpected refcounts caused by the trace function.

                                              *bigmemtest()..test.pyx*
@test.support.bigmemtest(size, memuse, dry_run=True)

   Decorator for bigmem tests.

   _size_ is a requested size for the test (in arbitrary, test-
   interpreted units.)  _memuse_ is the number of bytes per unit for
   the test, or a good estimate of it.  For example, a test that needs
   two byte buffers, of 4 GiB each, could be decorated with
   "@bigmemtest(size=_4G, memuse=2)".

   The _size_ argument is normally passed to the decorated test method
   as an extra argument.  If _dry_run_ is "True", the value passed to
   the test method may be less than the requested value.  If _dry_run_
   is "False", it means the test doesn’t support dummy runs when "-M"
   is not specified.

@test.support.bigaddrspacetest          *bigaddrspacetest()..test.pyx*

   Decorator for tests that fill the address space.

                                      *check_syntax_error()..test.pyx*
test.support.check_syntax_error(testcase, statement, errtext='', *, lineno=None, offset=None)

   Test for syntax errors in _statement_ by attempting to compile
   _statement_. _testcase_ is the "unittest" instance for the test.
   _errtext_ is the regular expression which should match the string
   representation of the raised "SyntaxError".  If _lineno_ is not
   "None", compares to the line of the exception.  If _offset_ is not
   "None", compares to the offset of the exception.

                                        *open_urlresource()..test.pyx*
test.support.open_urlresource(url, *args, **kw)

   Open _url_.  If open fails, raises "TestFailed".

test.support.reap_children()               *reap_children()..test.pyx*

   Use this at the end of "test_main" whenever sub-processes are
   started. This will help ensure that no extra children (zombies)
   stick around to hog resources and create problems when looking for
   refleaks.

test.support.get_attribute(obj, name)      *get_attribute()..test.pyx*

   Get an attribute, raising "unittest.SkipTest" if "AttributeError"
   is raised.

                              *catch_unraisable_exception()..test.pyx*
test.support.catch_unraisable_exception()

   Context manager catching unraisable exception using
   "sys.unraisablehook()".

   Storing the exception value ("cm.unraisable.exc_value") creates a
   reference cycle. The reference cycle is broken explicitly when the
   context manager exits.

   Storing the object ("cm.unraisable.object") can resurrect it if it
   is set to an object which is being finalized. Exiting the context
   manager clears the stored object.

   Usage:
>
      with support.catch_unraisable_exception() as cm:
          # code creating an "unraisable exception"
          ...

          # check the unraisable exception: use cm.unraisable
          ...

      # cm.unraisable attribute no longer exists at this point
      # (to break a reference cycle)
<
   New in version 3.8.

                                      *load_package_tests()..test.pyx*
test.support.load_package_tests(pkg_dir, loader, standard_tests, pattern)

   Generic implementation of the "unittest" "load_tests" protocol for
   use in test packages.  _pkg_dir_ is the root directory of the
   package; _loader_, _standard_tests_, and _pattern_ are the
   arguments expected by "load_tests".  In simple cases, the test
   package’s "__init__.py" can be the following:
>
      import os
      from test.support import load_package_tests

      def load_tests(*args):
          return load_package_tests(os.path.dirname(__file__), *args)
<

                                     *detect_api_mismatch()..test.pyx*
test.support.detect_api_mismatch(ref_api, other_api, *, ignore=())

   Returns the set of attributes, functions or methods of _ref_api_
   not found on _other_api_, except for a defined list of items to be
   ignored in this check specified in _ignore_.

   By default this skips private attributes beginning with ‘_’ but
   includes all magic methods, i.e. those starting and ending in ‘__’.

   New in version 3.5.

                                                   *patch()..test.pyx*
test.support.patch(test_instance, object_to_patch, attr_name, new_value)

   Override _object_to_patch.attr_name_ with _new_value_.  Also add
   cleanup procedure to _test_instance_ to restore _object_to_patch_
   for _attr_name_.  The _attr_name_ should be a valid attribute for
   _object_to_patch_.

test.support.run_in_subinterp(code)     *run_in_subinterp()..test.pyx*

   Run _code_ in subinterpreter.  Raise "unittest.SkipTest" if
   "tracemalloc" is enabled.

                              *check_free_after_iterating()..test.pyx*
test.support.check_free_after_iterating(test, iter, cls, args=())

   Assert instances of _cls_ are deallocated after iterating.

                             *missing_compiler_executable()..test.pyx*
test.support.missing_compiler_executable(cmd_names=[])

   Check for the existence of the compiler executables whose names are
   listed in _cmd_names_ or all the compiler executables when
   _cmd_names_ is empty and return the first missing executable or
   "None" when none is found missing.

                                            *check__all__()..test.pyx*
test.support.check__all__(test_case, module, name_of_module=None, extra=(), not_exported=())

   Assert that the "__all__" variable of _module_ contains all public
   names.

   The module’s public names (its API) are detected automatically
   based on whether they match the public name convention and were
   defined in _module_.

   The _name_of_module_ argument can specify (as a string or tuple
   thereof) what module(s) an API could be defined in order to be
   detected as a public API. One case for this is when _module_
   imports part of its public API from other modules, possibly a C
   backend (like "csv" and its "_csv").

   The _extra_ argument can be a set of names that wouldn’t otherwise
   be automatically detected as “public”, like objects without a
   proper "__module__" attribute. If provided, it will be added to the
   automatically detected ones.

   The _not_exported_ argument can be a set of names that must not be
   treated as part of the public API even though their names indicate
   otherwise.

   Example use:
>
      import bar
      import foo
      import unittest
      from test import support

      class MiscTestCase(unittest.TestCase):
          def test__all__(self):
              support.check__all__(self, foo)

      class OtherTestCase(unittest.TestCase):
          def test__all__(self):
              extra = {'BAR_CONST', 'FOO_CONST'}
              not_exported = {'baz'}  # Undocumented name.
              # bar imports part of its API from _bar.
              support.check__all__(self, bar, ('bar', '_bar'),
                                   extra=extra, not_exported=not_exported)
<
   New in version 3.6.

              *skip_if_broken_multiprocessing_synchronize()..test.pyx*
test.support.skip_if_broken_multiprocessing_synchronize()

   Skip tests if the "multiprocessing.synchronize" module is missing,
   if there is no available semaphore implementation, or if creating a
   lock raises an "OSError".

   New in version 3.10.

                            *check_disallow_instantiation()..test.pyx*
test.support.check_disallow_instantiation(test_case, tp, *args, **kwds)

   Assert that type _tp_ cannot be instantiated using _args_ and
   _kwds_.

   New in version 3.10.

                               *adjust_int_max_str_digits()..test.pyx*
test.support.adjust_int_max_str_digits(max_digits)

   This function returns a context manager that will change the global
   "sys.set_int_max_str_digits()" setting for the duration of the
   context to allow execution of test code that needs a different
   limit on the number of digits when converting between an integer
   and string.

   New in version 3.11.

The "test.support" module defines the following classes:

                                       *SuppressCrashReport..test.pyx*
class test.support.SuppressCrashReport

   A context manager used to try to prevent crash dialog popups on
   tests that are expected to crash a subprocess.

   On Windows, it disables Windows Error Reporting dialogs using
   SetErrorMode.

   On UNIX, "resource.setrlimit()" is used to set
   "resource.RLIMIT_CORE"’s soft limit to 0 to prevent coredump file
   creation.

   On both platforms, the old value is restored by "__exit__()".

class test.support.SaveSignals                 *SaveSignals..test.pyx*

   Class to save and restore signal handlers registered by the Python
   signal handler.

   save(self)                              *SaveSignals.save()..test.pyx*

      Save the signal handlers to a dictionary mapping signal numbers
      to the current signal handler.

   restore(self)                        *SaveSignals.restore()..test.pyx*

      Set the signal numbers from the "save()" dictionary to the saved
      handler.

class test.support.Matcher                         *Matcher..test.pyx*

   matches(self, d, **kwargs)               *Matcher.matches()..test.pyx*

      Try to match a single dict with the supplied arguments.

   match_value(self, k, dv, v)          *Matcher.match_value()..test.pyx*

      Try to match a single stored value (_dv_) with a supplied value
      (_v_).


"test.support.socket_helper" — Utilities for socket tests
*********************************************************

The "test.support.socket_helper" module provides support for socket
tests.

New in version 3.9.

test.support.socket_helper.IPV6_ENABLED       *IPV6_ENABLED..test.pyx*

   Set to "True" if IPv6 is enabled on this host, "False" otherwise.

                                        *find_unused_port()..test.pyx*
test.support.socket_helper.find_unused_port(family=socket.AF_INET, socktype=socket.SOCK_STREAM)

   Returns an unused port that should be suitable for binding.  This
   is achieved by creating a temporary socket with the same family and
   type as the "sock" parameter (default is "AF_INET", "SOCK_STREAM"),
   and binding it to the specified host address (defaults to
   "0.0.0.0") with the port set to 0, eliciting an unused ephemeral
   port from the OS. The temporary socket is then closed and deleted,
   and the ephemeral port is returned.

   Either this method or "bind_port()" should be used for any tests
   where a server socket needs to be bound to a particular port for
   the duration of the test. Which one to use depends on whether the
   calling code is creating a Python socket, or if an unused port
   needs to be provided in a constructor or passed to an external
   program (i.e. the "-accept" argument to openssl’s s_server mode).
   Always prefer "bind_port()" over "find_unused_port()" where
   possible.  Using a hard coded port is discouraged since it can make
   multiple instances of the test impossible to run simultaneously,
   which is a problem for buildbots.

                                               *bind_port()..test.pyx*
test.support.socket_helper.bind_port(sock, host=HOST)

   Bind the socket to a free port and return the port number.  Relies
   on ephemeral ports in order to ensure we are using an unbound port.
   This is important as many tests may be running simultaneously,
   especially in a buildbot environment.  This method raises an
   exception if the "sock.family" is "AF_INET" and "sock.type" is
   "SOCK_STREAM", and the socket has "SO_REUSEADDR" or "SO_REUSEPORT"
   set on it. Tests should never set these socket options for TCP/IP
   sockets. The only case for setting these options is testing
   multicasting via multiple UDP sockets.

   Additionally, if the "SO_EXCLUSIVEADDRUSE" socket option is
   available (i.e. on Windows), it will be set on the socket.  This
   will prevent anyone else from binding to our host/port for the
   duration of the test.

                                        *bind_unix_socket()..test.pyx*
test.support.socket_helper.bind_unix_socket(sock, addr)

   Bind a Unix socket, raising "unittest.SkipTest" if
   "PermissionError" is raised.

                            *skip_unless_bind_unix_socket()..test.pyx*
@test.support.socket_helper.skip_unless_bind_unix_socket

   A decorator for running tests that require a functional "bind()"
   for Unix sockets.

                                      *transient_internet()..test.pyx*
test.support.socket_helper.transient_internet(resource_name, *, timeout=30.0, errnos=())

   A context manager that raises "ResourceDenied" when various issues
   with the internet connection manifest themselves as exceptions.


"test.support.script_helper" — Utilities for the Python execution tests
***********************************************************************

The "test.support.script_helper" module provides support for Python’s
script execution tests.

                        *interpreter_requires_environment()..test.pyx*
test.support.script_helper.interpreter_requires_environment()

   Return "True" if "sys.executable interpreter" requires environment
   variables in order to be able to run at all.

   This is designed to be used with "@unittest.skipIf()" to annotate
   tests that need to use an "assert_python*()" function to launch an
   isolated mode ("-I") or no environment mode ("-E") sub-interpreter
   process.

   A normal build & test does not run into this situation but it can
   happen when trying to run the standard library test suite from an
   interpreter that doesn’t have an obvious home with Python’s current
   home finding logic.

   Setting "PYTHONHOME" is one way to get most of the testsuite to run
   in that situation.  "PYTHONPATH" or "PYTHONUSERSITE" are other
   common environment variables that might impact whether or not the
   interpreter can start.

                                    *run_python_until_end()..test.pyx*
test.support.script_helper.run_python_until_end(*args, **env_vars)

   Set up the environment based on _env_vars_ for running the
   interpreter in a subprocess.  The values can include "__isolated",
   "__cleanenv", "__cwd", and "TERM".

   Changed in version 3.9: The function no longer strips whitespaces
   from _stderr_.

                                        *assert_python_ok()..test.pyx*
test.support.script_helper.assert_python_ok(*args, **env_vars)

   Assert that running the interpreter with _args_ and optional
   environment variables _env_vars_ succeeds ("rc == 0") and return a
   "(return code, stdout, stderr)" tuple.

   If the ___cleanenv_ keyword-only parameter is set, _env_vars_ is
   used as a fresh environment.

   Python is started in isolated mode (command line option "-I"),
   except if the ___isolated_ keyword-only parameter is set to
   "False".

   Changed in version 3.9: The function no longer strips whitespaces
   from _stderr_.

                                   *assert_python_failure()..test.pyx*
test.support.script_helper.assert_python_failure(*args, **env_vars)

   Assert that running the interpreter with _args_ and optional
   environment variables _env_vars_ fails ("rc != 0") and return a
   "(return code, stdout, stderr)" tuple.

   See "assert_python_ok()" for more options.

   Changed in version 3.9: The function no longer strips whitespaces
   from _stderr_.

                                            *spawn_python()..test.pyx*
test.support.script_helper.spawn_python(*args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, **kw)

   Run a Python subprocess with the given arguments.

   _kw_ is extra keyword args to pass to "subprocess.Popen()". Returns
   a "subprocess.Popen" object.

test.support.script_helper.kill_python(p)    *kill_python()..test.pyx*

   Run the given "subprocess.Popen" process until completion and
   return stdout.

                                             *make_script()..test.pyx*
test.support.script_helper.make_script(script_dir, script_basename, source, omit_suffix=False)

   Create script containing _source_ in path _script_dir_ and
   _script_basename_. If _omit_suffix_ is "False", append ".py" to the
   name.  Return the full script path.

                                         *make_zip_script()..test.pyx*
test.support.script_helper.make_zip_script(zip_dir, zip_basename, script_name, name_in_zip=None)

   Create zip file at _zip_dir_ and _zip_basename_ with extension
   "zip" which contains the files in _script_name_. _name_in_zip_ is
   the archive name. Return a tuple containing "(full path, full path
   of archive name)".

                                                *make_pkg()..test.pyx*
test.support.script_helper.make_pkg(pkg_dir, init_source='')

   Create a directory named _pkg_dir_ containing an "__init__" file
   with _init_source_ as its contents.

                                            *make_zip_pkg()..test.pyx*
test.support.script_helper.make_zip_pkg(zip_dir, zip_basename, pkg_name, script_basename, source, depth=1, compiled=False)

   Create a zip package directory with a path of _zip_dir_ and
   _zip_basename_ containing an empty "__init__" file and a file
   _script_basename_ containing the _source_.  If _compiled_ is
   "True", both source files will be compiled and added to the zip
   package.  Return a tuple of the full zip path and the archive name
   for the zip file.


"test.support.bytecode_helper" — Support tools for testing correct bytecode generation
**************************************************************************************

The "test.support.bytecode_helper" module provides support for testing
and inspecting bytecode generation.

New in version 3.9.

The module defines the following class:

                                          *BytecodeTestCase..test.pyx*
class test.support.bytecode_helper.BytecodeTestCase(unittest.TestCase)

   This class has custom assertion methods for inspecting bytecode.

              *BytecodeTestCase.get_disassembly_as_string()..test.pyx*
BytecodeTestCase.get_disassembly_as_string(co)

   Return the disassembly of _co_ as string.

                       *BytecodeTestCase.assertInBytecode()..test.pyx*
BytecodeTestCase.assertInBytecode(x, opname, argval=_UNSPECIFIED)

   Return instr if _opname_ is found, otherwise throws
   "AssertionError".

                    *BytecodeTestCase.assertNotInBytecode()..test.pyx*
BytecodeTestCase.assertNotInBytecode(x, opname, argval=_UNSPECIFIED)

   Throws "AssertionError" if _opname_ is found.


"test.support.threading_helper" — Utilities for threading tests
***************************************************************

The "test.support.threading_helper" module provides support for
threading tests.

New in version 3.10.

                                             *join_thread()..test.pyx*
test.support.threading_helper.join_thread(thread, timeout=None)

   Join a _thread_ within _timeout_.  Raise an "AssertionError" if
   thread is still alive after _timeout_ seconds.

                                            *reap_threads()..test.pyx*
@test.support.threading_helper.reap_threads

   Decorator to ensure the threads are cleaned up even if the test
   fails.

                                           *start_threads()..test.pyx*
test.support.threading_helper.start_threads(threads, unlock=None)

   Context manager to start _threads_, which is a sequence of threads.
   _unlock_ is a function called after the threads are started, even
   if an exception was raised; an example would be
   "threading.Event.set()". "start_threads" will attempt to join the
   started threads upon exit.

                                       *threading_cleanup()..test.pyx*
test.support.threading_helper.threading_cleanup(*original_values)

   Cleanup up threads not specified in _original_values_.  Designed to
   emit a warning if a test leaves running threads in the background.

                                         *threading_setup()..test.pyx*
test.support.threading_helper.threading_setup()

   Return current thread count and copy of dangling threads.

                                       *wait_threads_exit()..test.pyx*
test.support.threading_helper.wait_threads_exit(timeout=None)

   Context manager to wait until all threads created in the "with"
   statement exit.

                               *catch_threading_exception()..test.pyx*
test.support.threading_helper.catch_threading_exception()

   Context manager catching "threading.Thread" exception using
   "threading.excepthook()".

   Attributes set when an exception is caught:

   * "exc_type"

   * "exc_value"

   * "exc_traceback"

   * "thread"

   See "threading.excepthook()" documentation.

   These attributes are deleted at the context manager exit.

   Usage:
>
      with threading_helper.catch_threading_exception() as cm:
          # code spawning a thread which raises an exception
          ...

          # check the thread exception, use cm attributes:
          # exc_type, exc_value, exc_traceback, thread
          ...

      # exc_type, exc_value, exc_traceback, thread attributes of cm no longer
      # exists at this point
      # (to avoid reference cycles)
<
   New in version 3.8.


"test.support.os_helper" — Utilities for os tests
*************************************************

The "test.support.os_helper" module provides support for os tests.

New in version 3.10.

test.support.os_helper.FS_NONASCII             *FS_NONASCII..test.pyx*

   A non-ASCII character encodable by "os.fsencode()".

test.support.os_helper.SAVEDCWD                   *SAVEDCWD..test.pyx*

   Set to "os.getcwd()".

test.support.os_helper.TESTFN                       *TESTFN..test.pyx*

   Set to a name that is safe to use as the name of a temporary file.
   Any temporary file that is created should be closed and unlinked
   (removed).

test.support.os_helper.TESTFN_NONASCII     *TESTFN_NONASCII..test.pyx*

   Set to a filename containing the "FS_NONASCII" character, if it
   exists. This guarantees that if the filename exists, it can be
   encoded and decoded with the default filesystem encoding. This
   allows tests that require a non-ASCII filename to be easily skipped
   on platforms where they can’t work.

                                        *TESTFN_UNENCODABLE..test.pyx*
test.support.os_helper.TESTFN_UNENCODABLE

   Set to a filename (str type) that should not be able to be encoded
   by file system encoding in strict mode.  It may be "None" if it’s
   not possible to generate such a filename.

                                        *TESTFN_UNDECODABLE..test.pyx*
test.support.os_helper.TESTFN_UNDECODABLE

   Set to a filename (bytes type) that should not be able to be
   decoded by file system encoding in strict mode.  It may be "None"
   if it’s not possible to generate such a filename.

test.support.os_helper.TESTFN_UNICODE       *TESTFN_UNICODE..test.pyx*

   Set to a non-ASCII name for a temporary file.

                                       *EnvironmentVarGuard..test.pyx*
class test.support.os_helper.EnvironmentVarGuard

   Class used to temporarily set or unset environment variables.
   Instances can be used as a context manager and have a complete
   dictionary interface for querying/modifying the underlying
   "os.environ". After exit from the context manager all changes to
   environment variables done through this instance will be rolled
   back.

   Changed in version 3.1: Added dictionary interface.

class test.support.os_helper.FakePath(path)       *FakePath..test.pyx*

   Simple _path-like object_.  It implements the "__fspath__()" method
   which just returns the _path_ argument.  If _path_ is an exception,
   it will be raised in "__fspath__()".

                                 *EnvironmentVarGuard.set()..test.pyx*
EnvironmentVarGuard.set(envvar, value)

   Temporarily set the environment variable "envvar" to the value of
   "value".

                               *EnvironmentVarGuard.unset()..test.pyx*
EnvironmentVarGuard.unset(envvar)

   Temporarily unset the environment variable "envvar".

test.support.os_helper.can_symlink()         *can_symlink()..test.pyx*

   Return "True" if the OS supports symbolic links, "False" otherwise.

test.support.os_helper.can_xattr()             *can_xattr()..test.pyx*

   Return "True" if the OS supports xattr, "False" otherwise.

                                              *change_cwd()..test.pyx*
test.support.os_helper.change_cwd(path, quiet=False)

   A context manager that temporarily changes the current working
   directory to _path_ and yields the directory.

   If _quiet_ is "False", the context manager raises an exception on
   error.  Otherwise, it issues only a warning and keeps the current
   working directory the same.

                                       *create_empty_file()..test.pyx*
test.support.os_helper.create_empty_file(filename)

   Create an empty file with _filename_.  If it already exists,
   truncate it.

test.support.os_helper.fd_count()               *fd_count()..test.pyx*

   Count the number of open file descriptors.

                                  *fs_is_case_insensitive()..test.pyx*
test.support.os_helper.fs_is_case_insensitive(directory)

   Return "True" if the file system for _directory_ is case-
   insensitive.

test.support.os_helper.make_bad_fd()         *make_bad_fd()..test.pyx*

   Create an invalid file descriptor by opening and closing a
   temporary file, and returning its descriptor.

test.support.os_helper.rmdir(filename)             *rmdir()..test.pyx*

   Call "os.rmdir()" on _filename_.  On Windows platforms, this is
   wrapped with a wait loop that checks for the existence of the file,
   which is needed due to antivirus programs that can hold files open
   and prevent deletion.

test.support.os_helper.rmtree(path)               *rmtree()..test.pyx*

   Call "shutil.rmtree()" on _path_ or call "os.lstat()" and
   "os.rmdir()" to remove a path and its contents.  As with "rmdir()",
   on Windows platforms this is wrapped with a wait loop that checks
   for the existence of the files.

                                     *skip_unless_symlink()..test.pyx*
@test.support.os_helper.skip_unless_symlink

   A decorator for running tests that require support for symbolic
   links.

                                       *skip_unless_xattr()..test.pyx*
@test.support.os_helper.skip_unless_xattr

   A decorator for running tests that require support for xattr.

                                                *temp_cwd()..test.pyx*
test.support.os_helper.temp_cwd(name='tempcwd', quiet=False)

   A context manager that temporarily creates a new directory and
   changes the current working directory (CWD).

   The context manager creates a temporary directory in the current
   directory with name _name_ before temporarily changing the current
   working directory.  If _name_ is "None", the temporary directory is
   created using "tempfile.mkdtemp()".

   If _quiet_ is "False" and it is not possible to create or change
   the CWD, an error is raised.  Otherwise, only a warning is raised
   and the original CWD is used.

                                                *temp_dir()..test.pyx*
test.support.os_helper.temp_dir(path=None, quiet=False)

   A context manager that creates a temporary directory at _path_ and
   yields the directory.

   If _path_ is "None", the temporary directory is created using
   "tempfile.mkdtemp()".  If _quiet_ is "False", the context manager
   raises an exception on error.  Otherwise, if _path_ is specified
   and cannot be created, only a warning is issued.

test.support.os_helper.temp_umask(umask)      *temp_umask()..test.pyx*

   A context manager that temporarily sets the process umask.

test.support.os_helper.unlink(filename)           *unlink()..test.pyx*

   Call "os.unlink()" on _filename_.  As with "rmdir()", on Windows
   platforms, this is wrapped with a wait loop that checks for the
   existence of the file.


"test.support.import_helper" — Utilities for import tests
*********************************************************

The "test.support.import_helper" module provides support for import
tests.

New in version 3.10.

test.support.import_helper.forget(module_name)    *forget()..test.pyx*

   Remove the module named _module_name_ from "sys.modules" and delete
   any byte-compiled files of the module.

                                     *import_fresh_module()..test.pyx*
test.support.import_helper.import_fresh_module(name, fresh=(), blocked=(), deprecated=False)

   This function imports and returns a fresh copy of the named Python
   module by removing the named module from "sys.modules" before doing
   the import. Note that unlike "reload()", the original module is not
   affected by this operation.

   _fresh_ is an iterable of additional module names that are also
   removed from the "sys.modules" cache before doing the import.

   _blocked_ is an iterable of module names that are replaced with
   "None" in the module cache during the import to ensure that
   attempts to import them raise "ImportError".

   The named module and any modules named in the _fresh_ and _blocked_
   parameters are saved before starting the import and then reinserted
   into "sys.modules" when the fresh import is complete.

   Module and package deprecation messages are suppressed during this
   import if _deprecated_ is "True".

   This function will raise "ImportError" if the named module cannot
   be imported.

   Example use:
>
      # Get copies of the warnings module for testing without affecting the
      # version being used by the rest of the test suite. One copy uses the
      # C implementation, the other is forced to use the pure Python fallback
      # implementation
      py_warnings = import_fresh_module('warnings', blocked=['_warnings'])
      c_warnings = import_fresh_module('warnings', fresh=['_warnings'])
<
   New in version 3.1.

                                           *import_module()..test.pyx*
test.support.import_helper.import_module(name, deprecated=False, *, required_on=())

   This function imports and returns the named module. Unlike a normal
   import, this function raises "unittest.SkipTest" if the module
   cannot be imported.

   Module and package deprecation messages are suppressed during this
   import if _deprecated_ is "True".  If a module is required on a
   platform but optional for others, set _required_on_ to an iterable
   of platform prefixes which will be compared against "sys.platform".

   New in version 3.1.

                                           *modules_setup()..test.pyx*
test.support.import_helper.modules_setup()

   Return a copy of "sys.modules".

                                         *modules_cleanup()..test.pyx*
test.support.import_helper.modules_cleanup(oldmodules)

   Remove modules except for _oldmodules_ and "encodings" in order to
   preserve internal cache.

test.support.import_helper.unload(name)           *unload()..test.pyx*

   Delete _name_ from "sys.modules".

                                         *make_legacy_pyc()..test.pyx*
test.support.import_helper.make_legacy_pyc(source)

   Move a **PEP 3147**/**PEP 488** pyc file to its legacy pyc location
   and return the file system path to the legacy pyc file.  The
   _source_ value is the file system path to the source file.  It does
   not need to exist, however the PEP 3147/488 pyc file must exist.

                                               *CleanImport..test.pyx*
class test.support.import_helper.CleanImport(*module_names)

   A context manager to force import to return a new module reference.
   This is useful for testing module-level behaviors, such as the
   emission of a "DeprecationWarning" on import.  Example usage:
>
      with CleanImport('foo'):
          importlib.import_module('foo')  # New reference.
<

                                             *DirsOnSysPath..test.pyx*
class test.support.import_helper.DirsOnSysPath(*paths)

   A context manager to temporarily add directories to "sys.path".

   This makes a copy of "sys.path", appends any directories given as
   positional arguments, then reverts "sys.path" to the copied
   settings when the context ends.

   Note that _all_ "sys.path" modifications in the body of the context
   manager, including replacement of the object, will be reverted at
   the end of the block.


"test.support.warnings_helper" — Utilities for warnings tests
*************************************************************

The "test.support.warnings_helper" module provides support for
warnings tests.

New in version 3.10.

                                         *ignore_warnings()..test.pyx*
test.support.warnings_helper.ignore_warnings(*, category)

   Suppress warnings that are instances of _category_, which must be
   "Warning" or a subclass. Roughly equivalent to
   "warnings.catch_warnings()" with "warnings.simplefilter('ignore',
   category=category)". For example:
>
      @warning_helper.ignore_warnings(category=DeprecationWarning)
      def test_suppress_warning():
          # do something
<
   New in version 3.8.

                               *check_no_resource_warning()..test.pyx*
test.support.warnings_helper.check_no_resource_warning(testcase)

   Context manager to check that no "ResourceWarning" was raised.  You
   must remove the object which may emit "ResourceWarning" before the
   end of the context manager.

                                    *check_syntax_warning()..test.pyx*
test.support.warnings_helper.check_syntax_warning(testcase, statement, errtext='', *, lineno=1, offset=None)

   Test for syntax warning in _statement_ by attempting to compile
   _statement_. Test also that the "SyntaxWarning" is emitted only
   once, and that it will be converted to a "SyntaxError" when turned
   into error. _testcase_ is the "unittest" instance for the test.
   _errtext_ is the regular expression which should match the string
   representation of the emitted "SyntaxWarning" and raised
   "SyntaxError".  If _lineno_ is not "None", compares to the line of
   the warning and exception. If _offset_ is not "None", compares to
   the offset of the exception.

   New in version 3.8.

                                          *check_warnings()..test.pyx*
test.support.warnings_helper.check_warnings(*filters, quiet=True)

   A convenience wrapper for "warnings.catch_warnings()" that makes it
   easier to test that a warning was correctly raised.  It is
   approximately equivalent to calling
   "warnings.catch_warnings(record=True)" with
   "warnings.simplefilter()" set to "always" and with the option to
   automatically validate the results that are recorded.

   "check_warnings" accepts 2-tuples of the form "("message regexp",
   WarningCategory)" as positional arguments. If one or more _filters_
   are provided, or if the optional keyword argument _quiet_ is
   "False", it checks to make sure the warnings are as expected:  each
   specified filter must match at least one of the warnings raised by
   the enclosed code or the test fails, and if any warnings are raised
   that do not match any of the specified filters the test fails.  To
   disable the first of these checks, set _quiet_ to "True".

   If no arguments are specified, it defaults to:
>
      check_warnings(("", Warning), quiet=True)
<
   In this case all warnings are caught and no errors are raised.

   On entry to the context manager, a "WarningRecorder" instance is
   returned. The underlying warnings list from "catch_warnings()" is
   available via the recorder object’s "warnings" attribute.  As a
   convenience, the attributes of the object representing the most
   recent warning can also be accessed directly through the recorder
   object (see example below).  If no warning has been raised, then
   any of the attributes that would otherwise be expected on an object
   representing a warning will return "None".

   The recorder object also has a "reset()" method, which clears the
   warnings list.

   The context manager is designed to be used like this:
>
      with check_warnings(("assertion is always true", SyntaxWarning),
                          ("", UserWarning)):
          exec('assert(False, "Hey!")')
          warnings.warn(UserWarning("Hide me!"))
<
   In this case if either warning was not raised, or some other
   warning was raised, "check_warnings()" would raise an error.

   When a test needs to look more deeply into the warnings, rather
   than just checking whether or not they occurred, code like this can
   be used:
>
      with check_warnings(quiet=True) as w:
          warnings.warn("foo")
          assert str(w.args[0]) == "foo"
          warnings.warn("bar")
          assert str(w.args[0]) == "bar"
          assert str(w.warnings[0].args[0]) == "foo"
          assert str(w.warnings[1].args[0]) == "bar"
          w.reset()
          assert len(w.warnings) == 0
<
   Here all warnings will be caught, and the test code tests the
   captured warnings directly.

   Changed in version 3.2: New optional arguments _filters_ and
   _quiet_.

                                          *WarningsRecorder..test.pyx*
class test.support.warnings_helper.WarningsRecorder

   Class used to record warnings for unit tests. See documentation of
   "check_warnings()" above for more details.

vim:tw=78:ts=8:ft=help:norl: