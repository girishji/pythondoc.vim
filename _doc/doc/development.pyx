*development.pyx*                             Last change: 2023 Sep 15

Development Tools
*****************

The modules described in this chapter help you write software.  For
example, the "pydoc" module takes a module and generates documentation
based on the module’s contents.  The "doctest" and "unittest" modules
contains frameworks for writing unit tests that automatically exercise
code and verify that the expected output is produced.

The list of modules described in this chapter is:

* "typing" — Support for type hints

  * Relevant PEPs

  * Type aliases

  * NewType

  * Annotating callable objects

  * Generics

  * Annotating tuples

  * The type of class objects

  * User-defined generic types

  * The "Any" type

  * Nominal vs structural subtyping

  * Module contents

    * Special typing primitives

      * Special types

        * "Any"

        * "AnyStr"

        * "LiteralString"

        * "Never"

        * "NoReturn"

        * "Self"

        * "TypeAlias"

      * Special forms

        * "Union"

        * "Optional"

        * "Concatenate"

        * "Literal"

        * "ClassVar"

        * "Final"

        * "Required"

        * "NotRequired"

        * "Annotated"

        * "TypeGuard"

        * "Unpack"

      * Building generic types and type aliases

        * "Generic"

        * "TypeVar"

          * "TypeVar.__name__"

          * "TypeVar.__covariant__"

          * "TypeVar.__contravariant__"

          * "TypeVar.__infer_variance__"

          * "TypeVar.__bound__"

          * "TypeVar.__constraints__"

        * "TypeVarTuple"

          * "TypeVarTuple.__name__"

        * "ParamSpec"

          * "ParamSpec.args"

          * "ParamSpec.kwargs"

          * "ParamSpec.__name__"

        * "ParamSpecArgs"

        * "ParamSpecKwargs"

        * "TypeAliasType"

          * "TypeAliasType.__name__"

          * "TypeAliasType.__module__"

          * "TypeAliasType.__type_params__"

          * "TypeAliasType.__value__"

      * Other special directives

        * "NamedTuple"

        * "NewType"

          * "NewType.__module__"

          * "NewType.__name__"

          * "NewType.__supertype__"

        * "Protocol"

        * "runtime_checkable()"

        * "TypedDict"

          * "TypedDict.__total__"

          * "TypedDict.__required_keys__"

          * "TypedDict.__optional_keys__"

    * Protocols

      * "SupportsAbs"

      * "SupportsBytes"

      * "SupportsComplex"

      * "SupportsFloat"

      * "SupportsIndex"

      * "SupportsInt"

      * "SupportsRound"

    * ABCs for working with IO

      * "IO"

      * "TextIO"

      * "BinaryIO"

    * Functions and decorators

      * "cast()"

      * "assert_type()"

      * "assert_never()"

      * "reveal_type()"

      * "dataclass_transform()"

      * "overload()"

      * "get_overloads()"

      * "clear_overloads()"

      * "final()"

      * "no_type_check()"

      * "no_type_check_decorator()"

      * "override()"

      * "type_check_only()"

    * Introspection helpers

      * "get_type_hints()"

      * "get_origin()"

      * "get_args()"

      * "get_protocol_members()"

      * "is_protocol()"

      * "is_typeddict()"

      * "ForwardRef"

    * Constant

      * "TYPE_CHECKING"

    * Deprecated aliases

      * Aliases to built-in types

        * "Dict"

        * "List"

        * "Set"

        * "FrozenSet"

        * "Tuple"

        * "Type"

      * Aliases to types in "collections"

        * "DefaultDict"

        * "OrderedDict"

        * "ChainMap"

        * "Counter"

        * "Deque"

      * Aliases to other concrete types

        * "Pattern"

        * "Match"

        * "Text"

      * Aliases to container ABCs in "collections.abc"

        * "AbstractSet"

        * "ByteString"

        * "Collection"

        * "Container"

        * "ItemsView"

        * "KeysView"

        * "Mapping"

        * "MappingView"

        * "MutableMapping"

        * "MutableSequence"

        * "MutableSet"

        * "Sequence"

        * "ValuesView"

      * Aliases to asynchronous ABCs in "collections.abc"

        * "Coroutine"

        * "AsyncGenerator"

        * "AsyncIterable"

        * "AsyncIterator"

        * "Awaitable"

      * Aliases to other ABCs in "collections.abc"

        * "Iterable"

        * "Iterator"

        * "Callable"

        * "Generator"

        * "Hashable"

        * "Reversible"

        * "Sized"

      * Aliases to "contextlib" ABCs

        * "ContextManager"

        * "AsyncContextManager"

  * Deprecation Timeline of Major Features

* "pydoc" — Documentation generator and online help system

* Python Development Mode

  * Effects of the Python Development Mode

  * ResourceWarning Example

  * Bad file descriptor error example

* "doctest" — Test interactive Python examples

  * Simple Usage: Checking Examples in Docstrings

  * Simple Usage: Checking Examples in a Text File

  * How It Works

    * Which Docstrings Are Examined?

    * How are Docstring Examples Recognized?

    * What’s the Execution Context?

    * What About Exceptions?

    * Option Flags

      * "DONT_ACCEPT_TRUE_FOR_1"

      * "DONT_ACCEPT_BLANKLINE"

      * "NORMALIZE_WHITESPACE"

      * "ELLIPSIS"

      * "IGNORE_EXCEPTION_DETAIL"

      * "SKIP"

      * "COMPARISON_FLAGS"

      * "REPORT_UDIFF"

      * "REPORT_CDIFF"

      * "REPORT_NDIFF"

      * "REPORT_ONLY_FIRST_FAILURE"

      * "FAIL_FAST"

      * "REPORTING_FLAGS"

      * "register_optionflag()"

    * Directives

    * Warnings

  * Basic API

    * "testfile()"

    * "testmod()"

    * "run_docstring_examples()"

  * Unittest API

    * "DocFileSuite()"

    * "DocTestSuite()"

    * "set_unittest_reportflags()"

  * Advanced API

    * DocTest Objects

      * "DocTest"

        * "DocTest.examples"

        * "DocTest.globs"

        * "DocTest.name"

        * "DocTest.filename"

        * "DocTest.lineno"

        * "DocTest.docstring"

    * Example Objects

      * "Example"

        * "Example.source"

        * "Example.want"

        * "Example.exc_msg"

        * "Example.lineno"

        * "Example.indent"

        * "Example.options"

    * DocTestFinder objects

      * "DocTestFinder"

        * "DocTestFinder.find()"

    * DocTestParser objects

      * "DocTestParser"

        * "DocTestParser.get_doctest()"

        * "DocTestParser.get_examples()"

        * "DocTestParser.parse()"

    * TestResults objects

      * "TestResults"

        * "TestResults.failed"

        * "TestResults.attempted"

        * "TestResults.skipped"

    * DocTestRunner objects

      * "DocTestRunner"

        * "DocTestRunner.report_start()"

        * "DocTestRunner.report_success()"

        * "DocTestRunner.report_failure()"

        * "DocTestRunner.report_unexpected_exception()"

        * "DocTestRunner.run()"

        * "DocTestRunner.summarize()"

        * "DocTestRunner.tries"

        * "DocTestRunner.failures"

        * "DocTestRunner.skips"

    * OutputChecker objects

      * "OutputChecker"

        * "OutputChecker.check_output()"

        * "OutputChecker.output_difference()"

  * Debugging

    * "script_from_examples()"

    * "testsource()"

    * "debug()"

    * "debug_src()"

    * "DebugRunner"

    * "DocTestFailure"

      * "DocTestFailure.test"

      * "DocTestFailure.example"

      * "DocTestFailure.got"

    * "UnexpectedException"

      * "UnexpectedException.test"

      * "UnexpectedException.example"

      * "UnexpectedException.exc_info"

  * Soapbox

* "unittest" — Unit testing framework

  * Basic example

  * Command-Line Interface

    * Command-line options

  * Test Discovery

  * Organizing test code

  * Re-using old test code

  * Skipping tests and expected failures

    * "skip()"

    * "skipIf()"

    * "skipUnless()"

    * "expectedFailure()"

    * "SkipTest"

  * Distinguishing test iterations using subtests

  * Classes and functions

    * Test cases

      * "TestCase"

        * "TestCase.setUp()"

        * "TestCase.tearDown()"

        * "TestCase.setUpClass()"

        * "TestCase.tearDownClass()"

        * "TestCase.run()"

        * "TestCase.skipTest()"

        * "TestCase.subTest()"

        * "TestCase.debug()"

        * "TestCase.assertEqual()"

        * "TestCase.assertNotEqual()"

        * "TestCase.assertTrue()"

        * "TestCase.assertFalse()"

        * "TestCase.assertIs()"

        * "TestCase.assertIsNot()"

        * "TestCase.assertIsNone()"

        * "TestCase.assertIsNotNone()"

        * "TestCase.assertIn()"

        * "TestCase.assertNotIn()"

        * "TestCase.assertIsInstance()"

        * "TestCase.assertNotIsInstance()"

        * "TestCase.assertRaises()"

        * "TestCase.assertRaisesRegex()"

        * "TestCase.assertWarns()"

        * "TestCase.assertWarnsRegex()"

        * "TestCase.assertLogs()"

        * "TestCase.records"

        * "TestCase.output"

        * "TestCase.assertNoLogs()"

        * "TestCase.assertAlmostEqual()"

        * "TestCase.assertNotAlmostEqual()"

        * "TestCase.assertGreater()"

        * "TestCase.assertGreaterEqual()"

        * "TestCase.assertLess()"

        * "TestCase.assertLessEqual()"

        * "TestCase.assertRegex()"

        * "TestCase.assertNotRegex()"

        * "TestCase.assertCountEqual()"

        * "TestCase.addTypeEqualityFunc()"

        * "TestCase.assertMultiLineEqual()"

        * "TestCase.assertSequenceEqual()"

        * "TestCase.assertListEqual()"

        * "TestCase.assertTupleEqual()"

        * "TestCase.assertSetEqual()"

        * "TestCase.assertDictEqual()"

        * "TestCase.fail()"

        * "TestCase.failureException"

        * "TestCase.longMessage"

        * "TestCase.maxDiff"

        * "TestCase.countTestCases()"

        * "TestCase.defaultTestResult()"

        * "TestCase.id()"

        * "TestCase.shortDescription()"

        * "TestCase.addCleanup()"

        * "TestCase.enterContext()"

        * "TestCase.doCleanups()"

        * "TestCase.addClassCleanup()"

        * "TestCase.enterClassContext()"

        * "TestCase.doClassCleanups()"

      * "IsolatedAsyncioTestCase"

        * "IsolatedAsyncioTestCase.asyncSetUp()"

        * "IsolatedAsyncioTestCase.asyncTearDown()"

        * "IsolatedAsyncioTestCase.addAsyncCleanup()"

        * "IsolatedAsyncioTestCase.enterAsyncContext()"

        * "IsolatedAsyncioTestCase.run()"

      * "FunctionTestCase"

    * Grouping tests

      * "TestSuite"

        * "TestSuite.addTest()"

        * "TestSuite.addTests()"

        * "TestSuite.run()"

        * "TestSuite.debug()"

        * "TestSuite.countTestCases()"

        * "TestSuite.__iter__()"

    * Loading and running tests

      * "TestLoader"

        * "TestLoader.errors"

        * "TestLoader.loadTestsFromTestCase()"

        * "TestLoader.loadTestsFromModule()"

        * "TestLoader.loadTestsFromName()"

        * "TestLoader.loadTestsFromNames()"

        * "TestLoader.getTestCaseNames()"

        * "TestLoader.discover()"

        * "TestLoader.testMethodPrefix"

        * "TestLoader.sortTestMethodsUsing"

        * "TestLoader.suiteClass"

        * "TestLoader.testNamePatterns"

      * "TestResult"

        * "TestResult.errors"

        * "TestResult.failures"

        * "TestResult.skipped"

        * "TestResult.expectedFailures"

        * "TestResult.unexpectedSuccesses"

        * "TestResult.collectedDurations"

        * "TestResult.shouldStop"

        * "TestResult.testsRun"

        * "TestResult.buffer"

        * "TestResult.failfast"

        * "TestResult.tb_locals"

        * "TestResult.wasSuccessful()"

        * "TestResult.stop()"

        * "TestResult.startTest()"

        * "TestResult.stopTest()"

        * "TestResult.startTestRun()"

        * "TestResult.stopTestRun()"

        * "TestResult.addError()"

        * "TestResult.addFailure()"

        * "TestResult.addSuccess()"

        * "TestResult.addSkip()"

        * "TestResult.addExpectedFailure()"

        * "TestResult.addUnexpectedSuccess()"

        * "TestResult.addSubTest()"

        * "TestResult.addDuration()"

      * "TextTestResult"

      * "defaultTestLoader"

      * "TextTestRunner"

        * "TextTestRunner._makeResult()"

        * "TextTestRunner.run()"

      * "main()"

      * load_tests Protocol

  * Class and Module Fixtures

    * setUpClass and tearDownClass

    * setUpModule and tearDownModule

      * "addModuleCleanup()"

      * "enterModuleContext()"

      * "doModuleCleanups()"

  * Signal Handling

    * "installHandler()"

    * "registerResult()"

    * "removeResult()"

    * "removeHandler()"

* "unittest.mock" — mock object library

  * Quick Guide

  * The Mock Class

    * "Mock"

      * "Mock.assert_called()"

      * "Mock.assert_called_once()"

      * "Mock.assert_called_with()"

      * "Mock.assert_called_once_with()"

      * "Mock.assert_any_call()"

      * "Mock.assert_has_calls()"

      * "Mock.assert_not_called()"

      * "Mock.reset_mock()"

      * "Mock.mock_add_spec()"

      * "Mock.attach_mock()"

      * "Mock.configure_mock()"

      * "Mock.__dir__()"

      * "Mock._get_child_mock()"

      * "Mock.called"

      * "Mock.call_count"

      * "Mock.return_value"

      * "Mock.side_effect"

      * "Mock.call_args"

      * "Mock.call_args_list"

      * "Mock.method_calls"

      * "Mock.mock_calls"

      * "Mock.__class__"

    * "NonCallableMock"

    * "PropertyMock"

    * "AsyncMock"

      * "AsyncMock.assert_awaited()"

      * "AsyncMock.assert_awaited_once()"

      * "AsyncMock.assert_awaited_with()"

      * "AsyncMock.assert_awaited_once_with()"

      * "AsyncMock.assert_any_await()"

      * "AsyncMock.assert_has_awaits()"

      * "AsyncMock.assert_not_awaited()"

      * "AsyncMock.reset_mock()"

      * "AsyncMock.await_count"

      * "AsyncMock.await_args"

      * "AsyncMock.await_args_list"

    * "ThreadingMock"

      * "ThreadingMock.wait_until_called()"

      * "ThreadingMock.wait_until_any_call_with()"

      * "ThreadingMock.DEFAULT_TIMEOUT"

    * Calling

    * Deleting Attributes

    * Mock names and the name attribute

    * Attaching Mocks as Attributes

  * The patchers

    * patch

      * "patch()"

    * patch.object

      * "patch.object()"

    * patch.dict

      * "patch.dict()"

    * patch.multiple

      * "patch.multiple()"

    * patch methods: start and stop

      * "patch.stopall()"

    * patch builtins

    * TEST_PREFIX

    * Nesting Patch Decorators

    * Where to patch

    * Patching Descriptors and Proxy Objects

  * MagicMock and magic method support

    * Mocking Magic Methods

    * Magic Mock

      * "MagicMock"

      * "NonCallableMagicMock"

  * Helpers

    * sentinel

      * "sentinel"

    * DEFAULT

      * "DEFAULT"

    * call

      * "call()"

        * "call.call_list()"

    * create_autospec

      * "create_autospec()"

    * ANY

      * "ANY"

    * FILTER_DIR

      * "FILTER_DIR"

    * mock_open

      * "mock_open()"

    * Autospeccing

    * Sealing mocks

      * "seal()"

* "unittest.mock" — getting started

  * Using Mock

    * Mock Patching Methods

    * Mock for Method Calls on an Object

    * Mocking Classes

    * Naming your mocks

    * Tracking all Calls

    * Setting Return Values and Attributes

    * Raising exceptions with mocks

    * Side effect functions and iterables

    * Mocking asynchronous iterators

    * Mocking asynchronous context manager

    * Creating a Mock from an Existing Object

    * Using side_effect to return per file content

  * Patch Decorators

  * Further Examples

    * Mocking chained calls

    * Partial mocking

    * Mocking a Generator Method

    * Applying the same patch to every test method

    * Mocking Unbound Methods

    * Checking multiple calls with mock

    * Coping with mutable arguments

    * Nesting Patches

    * Mocking a dictionary with MagicMock

    * Mock subclasses and their attributes

    * Mocking imports with patch.dict

    * Tracking order of calls and less verbose call assertions

    * More complex argument matching

* "test" — Regression tests package for Python

  * Writing Unit Tests for the "test" package

  * Running tests using the command-line interface

* "test.support" — Utilities for the Python test suite

  * "TestFailed"

  * "ResourceDenied"

  * "verbose"

  * "is_jython"

  * "is_android"

  * "unix_shell"

  * "LOOPBACK_TIMEOUT"

  * "INTERNET_TIMEOUT"

  * "SHORT_TIMEOUT"

  * "LONG_TIMEOUT"

  * "PGO"

  * "PIPE_MAX_SIZE"

  * "Py_DEBUG"

  * "SOCK_MAX_SIZE"

  * "TEST_SUPPORT_DIR"

  * "TEST_HOME_DIR"

  * "TEST_DATA_DIR"

  * "MAX_Py_ssize_t"

  * "max_memuse"

  * "real_max_memuse"

  * "MISSING_C_DOCSTRINGS"

  * "HAVE_DOCSTRINGS"

  * "TEST_HTTP_URL"

  * "ALWAYS_EQ"

  * "NEVER_EQ"

  * "LARGEST"

  * "SMALLEST"

  * "busy_retry()"

  * "sleeping_retry()"

  * "is_resource_enabled()"

  * "python_is_optimized()"

  * "with_pymalloc()"

  * "requires()"

  * "sortdict()"

  * "findfile()"

  * "match_test()"

  * "set_match_tests()"

  * "run_unittest()"

  * "run_doctest()"

  * "get_pagesize()"

  * "setswitchinterval()"

  * "check_impl_detail()"

  * "set_memlimit()"

  * "record_original_stdout()"

  * "get_original_stdout()"

  * "args_from_interpreter_flags()"

  * "optim_args_from_interpreter_flags()"

  * "captured_stdin()"

  * "captured_stdout()"

  * "captured_stderr()"

  * "disable_faulthandler()"

  * "gc_collect()"

  * "disable_gc()"

  * "swap_attr()"

  * "swap_item()"

  * "flush_std_streams()"

  * "print_warning()"

  * "wait_process()"

  * "calcobjsize()"

  * "calcvobjsize()"

  * "checksizeof()"

  * "anticipate_failure()"

  * "system_must_validate_cert()"

  * "run_with_locale()"

  * "run_with_tz()"

  * "requires_freebsd_version()"

  * "requires_linux_version()"

  * "requires_mac_version()"

  * "requires_IEEE_754()"

  * "requires_zlib()"

  * "requires_gzip()"

  * "requires_bz2()"

  * "requires_lzma()"

  * "requires_resource()"

  * "requires_docstrings()"

  * "requires_limited_api()"

  * "cpython_only()"

  * "impl_detail()"

  * "no_tracing()"

  * "refcount_test()"

  * "bigmemtest()"

  * "bigaddrspacetest()"

  * "check_syntax_error()"

  * "open_urlresource()"

  * "reap_children()"

  * "get_attribute()"

  * "catch_unraisable_exception()"

  * "load_package_tests()"

  * "detect_api_mismatch()"

  * "patch()"

  * "run_in_subinterp()"

  * "check_free_after_iterating()"

  * "missing_compiler_executable()"

  * "check__all__()"

  * "skip_if_broken_multiprocessing_synchronize()"

  * "check_disallow_instantiation()"

  * "adjust_int_max_str_digits()"

  * "SuppressCrashReport"

  * "SaveSignals"

    * "SaveSignals.save()"

    * "SaveSignals.restore()"

  * "Matcher"

    * "Matcher.matches()"

    * "Matcher.match_value()"

* "test.support.socket_helper" — Utilities for socket tests

  * "IPV6_ENABLED"

  * "find_unused_port()"

  * "bind_port()"

  * "bind_unix_socket()"

  * "skip_unless_bind_unix_socket()"

  * "transient_internet()"

* "test.support.script_helper" — Utilities for the Python execution
  tests

  * "interpreter_requires_environment()"

  * "run_python_until_end()"

  * "assert_python_ok()"

  * "assert_python_failure()"

  * "spawn_python()"

  * "kill_python()"

  * "make_script()"

  * "make_zip_script()"

  * "make_pkg()"

  * "make_zip_pkg()"

* "test.support.bytecode_helper" — Support tools for testing correct
  bytecode generation

  * "BytecodeTestCase"

    * "BytecodeTestCase.get_disassembly_as_string()"

    * "BytecodeTestCase.assertInBytecode()"

    * "BytecodeTestCase.assertNotInBytecode()"

* "test.support.threading_helper" — Utilities for threading tests

  * "join_thread()"

  * "reap_threads()"

  * "start_threads()"

  * "threading_cleanup()"

  * "threading_setup()"

  * "wait_threads_exit()"

  * "catch_threading_exception()"

* "test.support.os_helper" — Utilities for os tests

  * "FS_NONASCII"

  * "SAVEDCWD"

  * "TESTFN"

  * "TESTFN_NONASCII"

  * "TESTFN_UNENCODABLE"

  * "TESTFN_UNDECODABLE"

  * "TESTFN_UNICODE"

  * "EnvironmentVarGuard"

    * "EnvironmentVarGuard.set()"

    * "EnvironmentVarGuard.unset()"

  * "FakePath"

  * "can_symlink()"

  * "can_xattr()"

  * "change_cwd()"

  * "create_empty_file()"

  * "fd_count()"

  * "fs_is_case_insensitive()"

  * "make_bad_fd()"

  * "rmdir()"

  * "rmtree()"

  * "skip_unless_symlink()"

  * "skip_unless_xattr()"

  * "temp_cwd()"

  * "temp_dir()"

  * "temp_umask()"

  * "unlink()"

* "test.support.import_helper" — Utilities for import tests

  * "forget()"

  * "import_fresh_module()"

  * "import_module()"

  * "modules_setup()"

  * "modules_cleanup()"

  * "unload()"

  * "make_legacy_pyc()"

  * "CleanImport"

  * "DirsOnSysPath"

* "test.support.warnings_helper" — Utilities for warnings tests

  * "ignore_warnings()"

  * "check_no_resource_warning()"

  * "check_syntax_warning()"

  * "check_warnings()"

  * "WarningsRecorder"

vim:tw=78:ts=8:ft=help:norl: