*codeop.pyx*                                  Last change: 2023 Sep 15

"codeop" — Compile Python code
******************************

**Source code:** Lib/codeop.py

======================================================================

The "codeop" module provides utilities upon which the Python read-
eval-print loop can be emulated, as is done in the "code" module.  As
a result, you probably don’t want to use the module directly; if you
want to include such a loop in your program you probably want to use
the "code" module instead.

There are two parts to this job:

1. Being able to tell if a line of input completes a Python statement:
   in short, telling whether to print ‘">>>"’ or ‘"..."’ next.

2. Remembering which future statements the user has entered, so
   subsequent input can be compiled with these in effect.

The "codeop" module provides a way of doing each of these things, and
a way of doing them both.

To do just the former:

                                       *compile_command()..codeop.pyx*
codeop.compile_command(source, filename='<input>', symbol='single')

   Tries to compile _source_, which should be a string of Python code
   and return a code object if _source_ is valid Python code.  In that
   case, the filename attribute of the code object will be _filename_,
   which defaults to "'<input>'".  Returns "None" if _source_ is _not_
   valid Python code, but is a prefix of valid Python code.

   If there is a problem with _source_, an exception will be raised.
   "SyntaxError" is raised if there is invalid Python syntax, and
   "OverflowError" or "ValueError" if there is an invalid literal.

   The _symbol_ argument determines whether _source_ is compiled as a
   statement ("'single'", the default), as a sequence of _statement_
   ("'exec'") or as an _expression_ ("'eval'").  Any other value will
   cause "ValueError" to be raised.

   Note:

     It is possible (but not likely) that the parser stops parsing
     with a successful outcome before reaching the end of the source;
     in this case, trailing symbols may be ignored instead of causing
     an error.  For example, a backslash followed by two newlines may
     be followed by arbitrary garbage. This will be fixed once the API
     for the parser is better.

class codeop.Compile                             *Compile..codeop.pyx*

   Instances of this class have "__call__()" methods identical in
   signature to the built-in function "compile()", but with the
   difference that if the instance compiles program text containing a
   "__future__" statement, the instance ‘remembers’ and compiles all
   subsequent program texts with the statement in force.

class codeop.CommandCompiler             *CommandCompiler..codeop.pyx*

   Instances of this class have "__call__()" methods identical in
   signature to "compile_command()"; the difference is that if the
   instance compiles program text containing a "__future__" statement,
   the instance ‘remembers’ and compiles all subsequent program texts
   with the statement in force.

vim:tw=78:ts=8:ft=help:norl: