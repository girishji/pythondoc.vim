*keyword.pyx*                                 Last change: 2023 Sep 15

"keyword" — Testing for Python keywords
***************************************

**Source code:** Lib/keyword.py

======================================================================

This module allows a Python program to determine if a string is a
keyword or soft keyword.

keyword.iskeyword(s)                        *iskeyword()..keyword.pyx*

   Return "True" if _s_ is a Python keyword.

keyword.kwlist                                   *kwlist..keyword.pyx*

   Sequence containing all the keywords defined for the interpreter.
   If any keywords are defined to only be active when particular
   "__future__" statements are in effect, these will be included as
   well.

keyword.issoftkeyword(s)                *issoftkeyword()..keyword.pyx*

   Return "True" if _s_ is a Python soft keyword.

   New in version 3.9.

keyword.softkwlist                           *softkwlist..keyword.pyx*

   Sequence containing all the soft keywords defined for the
   interpreter.  If any soft keywords are defined to only be active
   when particular "__future__" statements are in effect, these will
   be included as well.

   New in version 3.9.

vim:tw=78:ts=8:ft=help:norl: