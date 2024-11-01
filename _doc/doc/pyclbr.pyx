*pyclbr.pyx*                                  Last change: 2023 Sep 15

"pyclbr" — Python module browser support
****************************************

**Source code:** Lib/pyclbr.py

======================================================================

The "pyclbr" module provides limited information about the functions,
classes, and methods defined in a Python-coded module.  The
information is sufficient to implement a module browser.  The
information is extracted from the Python source code rather than by
importing the module, so this module is safe to use with untrusted
code. This restriction makes it impossible to use this module with
modules not implemented in Python, including all standard and optional
extension modules.

pyclbr.readmodule(module, path=None)        *readmodule()..pyclbr.pyx*

   Return a dictionary mapping module-level class names to class
   descriptors.  If possible, descriptors for imported base classes
   are included.  Parameter _module_ is a string with the name of the
   module to read; it may be the name of a module within a package.
   If given, _path_ is a sequence of directory paths prepended to
   "sys.path", which is used to locate the module source code.

   This function is the original interface and is only kept for back
   compatibility.  It returns a filtered version of the following.

                                         *readmodule_ex()..pyclbr.pyx*
pyclbr.readmodule_ex(module, path=None)

   Return a dictionary-based tree containing a function or class
   descriptors for each function and class defined in the module with
   a "def" or "class" statement.  The returned dictionary maps module-
   level function and class names to their descriptors.  Nested
   objects are entered into the children dictionary of their parent.
   As with readmodule, _module_ names the module to be read and _path_
   is prepended to sys.path.  If the module being read is a package,
   the returned dictionary has a key "'__path__'" whose value is a
   list containing the package search path.

New in version 3.7: Descriptors for nested definitions.  They are
accessed through the new children attribute.  Each has a new parent
attribute.

The descriptors returned by these functions are instances of Function
and Class classes.  Users are not expected to create instances of
these classes.


Function Objects
================

Class "Function" instances describe functions defined by def
statements.  They have the following attributes:

Function.file                              *Function.file..pyclbr.pyx*

   Name of the file in which the function is defined.

Function.module                          *Function.module..pyclbr.pyx*

   The name of the module defining the function described.

Function.name                              *Function.name..pyclbr.pyx*

   The name of the function.

Function.lineno                          *Function.lineno..pyclbr.pyx*

   The line number in the file where the definition starts.

Function.parent                          *Function.parent..pyclbr.pyx*

   For top-level functions, None.  For nested functions, the parent.

   New in version 3.7.

Function.children                      *Function.children..pyclbr.pyx*

   A dictionary mapping names to descriptors for nested functions and
   classes.

   New in version 3.7.

Function.is_async                      *Function.is_async..pyclbr.pyx*

   "True" for functions that are defined with the "async" prefix,
   "False" otherwise.

   New in version 3.10.


Class Objects
=============

Class "Class" instances describe classes defined by class statements.
They have the same attributes as Functions and two more.

Class.file                                    *Class.file..pyclbr.pyx*

   Name of the file in which the class is defined.

Class.module                                *Class.module..pyclbr.pyx*

   The name of the module defining the class described.

Class.name                                    *Class.name..pyclbr.pyx*

   The name of the class.

Class.lineno                                *Class.lineno..pyclbr.pyx*

   The line number in the file where the definition starts.

Class.parent                                *Class.parent..pyclbr.pyx*

   For top-level classes, None.  For nested classes, the parent.

   New in version 3.7.

Class.children                            *Class.children..pyclbr.pyx*

   A dictionary mapping names to descriptors for nested functions and
   classes.

   New in version 3.7.

Class.super                                  *Class.super..pyclbr.pyx*

   A list of "Class" objects which describe the immediate base classes
   of the class being described.  Classes which are named as
   superclasses but which are not discoverable by "readmodule_ex()"
   are listed as a string with the class name instead of as "Class"
   objects.

Class.methods                              *Class.methods..pyclbr.pyx*

   A dictionary mapping method names to line numbers.  This can be
   derived from the newer children dictionary, but remains for back-
   compatibility.

vim:tw=78:ts=8:ft=help:norl: