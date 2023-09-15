*howto-cporting.pyx*                          Last change: 2023 Sep 15

Porting Extension Modules to Python 3
*************************************

We recommend the following resources for porting extension modules to
Python 3:

* The Migrating C extensions chapter from _Supporting Python 3: An in-
  depth guide_, a book on moving from Python 2 to Python 3 in general,
  guides the reader through porting an extension module.

* The Porting guide from the _py3c_ project provides opinionated
  suggestions with supporting code.

* The Cython and CFFI libraries offer abstractions over Python’s C
  API. Extensions generally need to be re-written to use one of them,
  but the library then handles differences between various Python
  versions and implementations.

vim:tw=78:ts=8:ft=help:norl: