*operator.pyx*                                Last change: 2023 Sep 15

"operator" — Standard operators as functions
********************************************

**Source code:** Lib/operator.py

======================================================================

The "operator" module exports a set of efficient functions
corresponding to the intrinsic operators of Python.  For example,
"operator.add(x, y)" is equivalent to the expression "x+y". Many
function names are those used for special methods, without the double
underscores.  For backward compatibility, many of these have a variant
with the double underscores kept. The variants without the double
underscores are preferred for clarity.

The functions fall into categories that perform object comparisons,
logical operations, mathematical operations and sequence operations.

The object comparison functions are useful for all objects, and are
named after the rich comparison operators they support:

operator.lt(a, b)                                 *lt()..operator.pyx*
operator.le(a, b)                                 *le()..operator.pyx*
operator.eq(a, b)                                 *eq()..operator.pyx*
operator.ne(a, b)                                 *ne()..operator.pyx*
operator.ge(a, b)                                 *ge()..operator.pyx*
operator.gt(a, b)                                 *gt()..operator.pyx*
operator.__lt__(a, b)                         *__lt__()..operator.pyx*
operator.__le__(a, b)                         *__le__()..operator.pyx*
operator.__eq__(a, b)                         *__eq__()..operator.pyx*
operator.__ne__(a, b)                         *__ne__()..operator.pyx*
operator.__ge__(a, b)                         *__ge__()..operator.pyx*
operator.__gt__(a, b)                         *__gt__()..operator.pyx*

   Perform “rich comparisons” between _a_ and _b_. Specifically,
   "lt(a, b)" is equivalent to "a < b", "le(a, b)" is equivalent to "a
   <= b", "eq(a, b)" is equivalent to "a == b", "ne(a, b)" is
   equivalent to "a != b", "gt(a, b)" is equivalent to "a > b" and
   "ge(a, b)" is equivalent to "a >= b".  Note that these functions
   can return any value, which may or may not be interpretable as a
   Boolean value.  See Comparisons for more information about rich
   comparisons.

The logical operations are also generally applicable to all objects,
and support truth tests, identity tests, and boolean operations:

operator.not_(obj)                              *not_()..operator.pyx*
operator.__not__(obj)                        *__not__()..operator.pyx*

   Return the outcome of "not" _obj_.  (Note that there is no
   "__not__()" method for object instances; only the interpreter core
   defines this operation.  The result is affected by the "__bool__()"
   and "__len__()" methods.)

operator.truth(obj)                            *truth()..operator.pyx*

   Return "True" if _obj_ is true, and "False" otherwise.  This is
   equivalent to using the "bool" constructor.

operator.is_(a, b)                               *is_()..operator.pyx*

   Return "a is b".  Tests object identity.

operator.is_not(a, b)                         *is_not()..operator.pyx*

   Return "a is not b".  Tests object identity.

The mathematical and bitwise operations are the most numerous:

operator.abs(obj)                                *abs()..operator.pyx*
operator.__abs__(obj)                        *__abs__()..operator.pyx*

   Return the absolute value of _obj_.

operator.add(a, b)                               *add()..operator.pyx*
operator.__add__(a, b)                       *__add__()..operator.pyx*

   Return "a + b", for _a_ and _b_ numbers.

operator.and_(a, b)                             *and_()..operator.pyx*
operator.__and__(a, b)                       *__and__()..operator.pyx*

   Return the bitwise and of _a_ and _b_.

operator.floordiv(a, b)                     *floordiv()..operator.pyx*
operator.__floordiv__(a, b)             *__floordiv__()..operator.pyx*

   Return "a // b".

operator.index(a)                              *index()..operator.pyx*
operator.__index__(a)                      *__index__()..operator.pyx*

   Return _a_ converted to an integer.  Equivalent to "a.__index__()".

   Changed in version 3.10: The result always has exact type "int".
   Previously, the result could have been an instance of a subclass of
   "int".

operator.inv(obj)                                *inv()..operator.pyx*
operator.invert(obj)                          *invert()..operator.pyx*
operator.__inv__(obj)                        *__inv__()..operator.pyx*
operator.__invert__(obj)                  *__invert__()..operator.pyx*

   Return the bitwise inverse of the number _obj_.  This is equivalent
   to "~obj".

operator.lshift(a, b)                         *lshift()..operator.pyx*
operator.__lshift__(a, b)                 *__lshift__()..operator.pyx*

   Return _a_ shifted left by _b_.

operator.mod(a, b)                               *mod()..operator.pyx*
operator.__mod__(a, b)                       *__mod__()..operator.pyx*

   Return "a % b".

operator.mul(a, b)                               *mul()..operator.pyx*
operator.__mul__(a, b)                       *__mul__()..operator.pyx*

   Return "a * b", for _a_ and _b_ numbers.

operator.matmul(a, b)                         *matmul()..operator.pyx*
operator.__matmul__(a, b)                 *__matmul__()..operator.pyx*

   Return "a @ b".

   New in version 3.5.

operator.neg(obj)                                *neg()..operator.pyx*
operator.__neg__(obj)                        *__neg__()..operator.pyx*

   Return _obj_ negated ("-obj").

operator.or_(a, b)                               *or_()..operator.pyx*
operator.__or__(a, b)                         *__or__()..operator.pyx*

   Return the bitwise or of _a_ and _b_.

operator.pos(obj)                                *pos()..operator.pyx*
operator.__pos__(obj)                        *__pos__()..operator.pyx*

   Return _obj_ positive ("+obj").

operator.pow(a, b)                               *pow()..operator.pyx*
operator.__pow__(a, b)                       *__pow__()..operator.pyx*

   Return "a ** b", for _a_ and _b_ numbers.

operator.rshift(a, b)                         *rshift()..operator.pyx*
operator.__rshift__(a, b)                 *__rshift__()..operator.pyx*

   Return _a_ shifted right by _b_.

operator.sub(a, b)                               *sub()..operator.pyx*
operator.__sub__(a, b)                       *__sub__()..operator.pyx*

   Return "a - b".

operator.truediv(a, b)                       *truediv()..operator.pyx*
operator.__truediv__(a, b)               *__truediv__()..operator.pyx*

   Return "a / b" where 2/3 is .66 rather than 0.  This is also known
   as “true” division.

operator.xor(a, b)                               *xor()..operator.pyx*
operator.__xor__(a, b)                       *__xor__()..operator.pyx*

   Return the bitwise exclusive or of _a_ and _b_.

Operations which work with sequences (some of them with mappings too)
include:

operator.concat(a, b)                         *concat()..operator.pyx*
operator.__concat__(a, b)                 *__concat__()..operator.pyx*

   Return "a + b" for _a_ and _b_ sequences.

operator.contains(a, b)                     *contains()..operator.pyx*
operator.__contains__(a, b)             *__contains__()..operator.pyx*

   Return the outcome of the test "b in a". Note the reversed
   operands.

operator.countOf(a, b)                       *countOf()..operator.pyx*

   Return the number of occurrences of _b_ in _a_.

operator.delitem(a, b)                       *delitem()..operator.pyx*
operator.__delitem__(a, b)               *__delitem__()..operator.pyx*

   Remove the value of _a_ at index _b_.

operator.getitem(a, b)                       *getitem()..operator.pyx*
operator.__getitem__(a, b)               *__getitem__()..operator.pyx*

   Return the value of _a_ at index _b_.

operator.indexOf(a, b)                       *indexOf()..operator.pyx*

   Return the index of the first of occurrence of _b_ in _a_.

operator.setitem(a, b, c)                    *setitem()..operator.pyx*
operator.__setitem__(a, b, c)            *__setitem__()..operator.pyx*

   Set the value of _a_ at index _b_ to _c_.

operator.length_hint(obj, default=0)     *length_hint()..operator.pyx*

   Return an estimated length for the object _obj_. First try to
   return its actual length, then an estimate using
   "object.__length_hint__()", and finally return the default value.

   New in version 3.4.

The following operation works with callables:

operator.call(obj, /, *args, **kwargs)          *call()..operator.pyx*

                                            *__call__()..operator.pyx*
operator.__call__(obj, /, *args, **kwargs)

   Return "obj(*args, **kwargs)".

   New in version 3.11.

The "operator" module also defines tools for generalized attribute and
item lookups.  These are useful for making fast field extractors as
arguments for "map()", "sorted()", "itertools.groupby()", or other
functions that expect a function argument.

operator.attrgetter(attr)                 *attrgetter()..operator.pyx*
operator.attrgetter(*attrs)

   Return a callable object that fetches _attr_ from its operand. If
   more than one attribute is requested, returns a tuple of
   attributes. The attribute names can also contain dots. For example:

   * After "f = attrgetter('name')", the call "f(b)" returns "b.name".

   * After "f = attrgetter('name', 'date')", the call "f(b)" returns
     "(b.name, b.date)".

   * After "f = attrgetter('name.first', 'name.last')", the call
     "f(b)" returns "(b.name.first, b.name.last)".

   Equivalent to:
>
      def attrgetter(*items):
          if any(not isinstance(item, str) for item in items):
              raise TypeError('attribute name must be a string')
          if len(items) == 1:
              attr = items[0]
              def g(obj):
                  return resolve_attr(obj, attr)
          else:
              def g(obj):
                  return tuple(resolve_attr(obj, attr) for attr in items)
          return g

      def resolve_attr(obj, attr):
          for name in attr.split("."):
              obj = getattr(obj, name)
          return obj
<
operator.itemgetter(item)                 *itemgetter()..operator.pyx*
operator.itemgetter(*items)

   Return a callable object that fetches _item_ from its operand using
   the operand’s "__getitem__()" method.  If multiple items are
   specified, returns a tuple of lookup values.  For example:

   * After "f = itemgetter(2)", the call "f(r)" returns "r[2]".

   * After "g = itemgetter(2, 5, 3)", the call "g(r)" returns "(r[2],
     r[5], r[3])".

   Equivalent to:
>
      def itemgetter(*items):
          if len(items) == 1:
              item = items[0]
              def g(obj):
                  return obj[item]
          else:
              def g(obj):
                  return tuple(obj[item] for item in items)
          return g
<
   The items can be any type accepted by the operand’s "__getitem__()"
   method.  Dictionaries accept any _hashable_ value.  Lists, tuples,
   and strings accept an index or a slice:

   >>> itemgetter(1)('ABCDEFG')
   'B'
   >>> itemgetter(1, 3, 5)('ABCDEFG')
   ('B', 'D', 'F')
   >>> itemgetter(slice(2, None))('ABCDEFG')
   'CDEFG'
   >>> soldier = dict(rank='captain', name='dotterbart')
   >>> itemgetter('rank')(soldier)
   'captain'

   Example of using "itemgetter()" to retrieve specific fields from a
   tuple record:

   >>> inventory = [('apple', 3), ('banana', 2), ('pear', 5), ('orange', 1)]
   >>> getcount = itemgetter(1)
   >>> list(map(getcount, inventory))
   [3, 2, 5, 1]
   >>> sorted(inventory, key=getcount)
   [('orange', 1), ('banana', 2), ('apple', 3), ('pear', 5)]

                                        *methodcaller()..operator.pyx*
operator.methodcaller(name, /, *args, **kwargs)

   Return a callable object that calls the method _name_ on its
   operand.  If additional arguments and/or keyword arguments are
   given, they will be given to the method as well.  For example:

   * After "f = methodcaller('name')", the call "f(b)" returns
     "b.name()".

   * After "f = methodcaller('name', 'foo', bar=1)", the call "f(b)"
     returns "b.name('foo', bar=1)".

   Equivalent to:
>
      def methodcaller(name, /, *args, **kwargs):
          def caller(obj):
              return getattr(obj, name)(*args, **kwargs)
          return caller
<

Mapping Operators to Functions
==============================

This table shows how abstract operations correspond to operator
symbols in the Python syntax and the functions in the "operator"
module.

+-------------------------+---------------------------+-----------------------------------------+
| Operation               | Syntax                    | Function                                |
|=========================|===========================|=========================================|
| Addition                | "a + b"                   | "add(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Concatenation           | "seq1 + seq2"             | "concat(seq1, seq2)"                    |
+-------------------------+---------------------------+-----------------------------------------+
| Containment Test        | "obj in seq"              | "contains(seq, obj)"                    |
+-------------------------+---------------------------+-----------------------------------------+
| Division                | "a / b"                   | "truediv(a, b)"                         |
+-------------------------+---------------------------+-----------------------------------------+
| Division                | "a // b"                  | "floordiv(a, b)"                        |
+-------------------------+---------------------------+-----------------------------------------+
| Bitwise And             | "a & b"                   | "and_(a, b)"                            |
+-------------------------+---------------------------+-----------------------------------------+
| Bitwise Exclusive Or    | "a ^ b"                   | "xor(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Bitwise Inversion       | "~ a"                     | "invert(a)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Bitwise Or              | "a | b"                   | "or_(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Exponentiation          | "a ** b"                  | "pow(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Identity                | "a is b"                  | "is_(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Identity                | "a is not b"              | "is_not(a, b)"                          |
+-------------------------+---------------------------+-----------------------------------------+
| Indexed Assignment      | "obj[k] = v"              | "setitem(obj, k, v)"                    |
+-------------------------+---------------------------+-----------------------------------------+
| Indexed Deletion        | "del obj[k]"              | "delitem(obj, k)"                       |
+-------------------------+---------------------------+-----------------------------------------+
| Indexing                | "obj[k]"                  | "getitem(obj, k)"                       |
+-------------------------+---------------------------+-----------------------------------------+
| Left Shift              | "a << b"                  | "lshift(a, b)"                          |
+-------------------------+---------------------------+-----------------------------------------+
| Modulo                  | "a % b"                   | "mod(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Multiplication          | "a * b"                   | "mul(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Matrix Multiplication   | "a @ b"                   | "matmul(a, b)"                          |
+-------------------------+---------------------------+-----------------------------------------+
| Negation (Arithmetic)   | "- a"                     | "neg(a)"                                |
+-------------------------+---------------------------+-----------------------------------------+
| Negation (Logical)      | "not a"                   | "not_(a)"                               |
+-------------------------+---------------------------+-----------------------------------------+
| Positive                | "+ a"                     | "pos(a)"                                |
+-------------------------+---------------------------+-----------------------------------------+
| Right Shift             | "a >> b"                  | "rshift(a, b)"                          |
+-------------------------+---------------------------+-----------------------------------------+
| Slice Assignment        | "seq[i:j] = values"       | "setitem(seq, slice(i, j), values)"     |
+-------------------------+---------------------------+-----------------------------------------+
| Slice Deletion          | "del seq[i:j]"            | "delitem(seq, slice(i, j))"             |
+-------------------------+---------------------------+-----------------------------------------+
| Slicing                 | "seq[i:j]"                | "getitem(seq, slice(i, j))"             |
+-------------------------+---------------------------+-----------------------------------------+
| String Formatting       | "s % obj"                 | "mod(s, obj)"                           |
+-------------------------+---------------------------+-----------------------------------------+
| Subtraction             | "a - b"                   | "sub(a, b)"                             |
+-------------------------+---------------------------+-----------------------------------------+
| Truth Test              | "obj"                     | "truth(obj)"                            |
+-------------------------+---------------------------+-----------------------------------------+
| Ordering                | "a < b"                   | "lt(a, b)"                              |
+-------------------------+---------------------------+-----------------------------------------+
| Ordering                | "a <= b"                  | "le(a, b)"                              |
+-------------------------+---------------------------+-----------------------------------------+
| Equality                | "a == b"                  | "eq(a, b)"                              |
+-------------------------+---------------------------+-----------------------------------------+
| Difference              | "a != b"                  | "ne(a, b)"                              |
+-------------------------+---------------------------+-----------------------------------------+
| Ordering                | "a >= b"                  | "ge(a, b)"                              |
+-------------------------+---------------------------+-----------------------------------------+
| Ordering                | "a > b"                   | "gt(a, b)"                              |
+-------------------------+---------------------------+-----------------------------------------+


In-place Operators
==================

Many operations have an “in-place” version.  Listed below are
functions providing a more primitive access to in-place operators than
the usual syntax does; for example, the _statement_ "x += y" is
equivalent to "x = operator.iadd(x, y)".  Another way to put it is to
say that "z = operator.iadd(x, y)" is equivalent to the compound
statement "z = x; z += y".

In those examples, note that when an in-place method is called, the
computation and assignment are performed in two separate steps.  The
in-place functions listed below only do the first step, calling the
in-place method.  The second step, assignment, is not handled.

For immutable targets such as strings, numbers, and tuples, the
updated value is computed, but not assigned back to the input
variable:

>>> a = 'hello'
>>> iadd(a, ' world')
'hello world'
>>> a
'hello'

For mutable targets such as lists and dictionaries, the in-place
method will perform the update, so no subsequent assignment is
necessary:

>>> s = ['h', 'e', 'l', 'l', 'o']
>>> iadd(s, [' ', 'w', 'o', 'r', 'l', 'd'])
['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
>>> s
['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']

operator.iadd(a, b)                             *iadd()..operator.pyx*
operator.__iadd__(a, b)                     *__iadd__()..operator.pyx*

   "a = iadd(a, b)" is equivalent to "a += b".

operator.iand(a, b)                             *iand()..operator.pyx*
operator.__iand__(a, b)                     *__iand__()..operator.pyx*

   "a = iand(a, b)" is equivalent to "a &= b".

operator.iconcat(a, b)                       *iconcat()..operator.pyx*
operator.__iconcat__(a, b)               *__iconcat__()..operator.pyx*

   "a = iconcat(a, b)" is equivalent to "a += b" for _a_ and _b_
   sequences.

operator.ifloordiv(a, b)                   *ifloordiv()..operator.pyx*
operator.__ifloordiv__(a, b)           *__ifloordiv__()..operator.pyx*

   "a = ifloordiv(a, b)" is equivalent to "a //= b".

operator.ilshift(a, b)                       *ilshift()..operator.pyx*
operator.__ilshift__(a, b)               *__ilshift__()..operator.pyx*

   "a = ilshift(a, b)" is equivalent to "a <<= b".

operator.imod(a, b)                             *imod()..operator.pyx*
operator.__imod__(a, b)                     *__imod__()..operator.pyx*

   "a = imod(a, b)" is equivalent to "a %= b".

operator.imul(a, b)                             *imul()..operator.pyx*
operator.__imul__(a, b)                     *__imul__()..operator.pyx*

   "a = imul(a, b)" is equivalent to "a *= b".

operator.imatmul(a, b)                       *imatmul()..operator.pyx*
operator.__imatmul__(a, b)               *__imatmul__()..operator.pyx*

   "a = imatmul(a, b)" is equivalent to "a @= b".

   New in version 3.5.

operator.ior(a, b)                               *ior()..operator.pyx*
operator.__ior__(a, b)                       *__ior__()..operator.pyx*

   "a = ior(a, b)" is equivalent to "a |= b".

operator.ipow(a, b)                             *ipow()..operator.pyx*
operator.__ipow__(a, b)                     *__ipow__()..operator.pyx*

   "a = ipow(a, b)" is equivalent to "a **= b".

operator.irshift(a, b)                       *irshift()..operator.pyx*
operator.__irshift__(a, b)               *__irshift__()..operator.pyx*

   "a = irshift(a, b)" is equivalent to "a >>= b".

operator.isub(a, b)                             *isub()..operator.pyx*
operator.__isub__(a, b)                     *__isub__()..operator.pyx*

   "a = isub(a, b)" is equivalent to "a -= b".

operator.itruediv(a, b)                     *itruediv()..operator.pyx*
operator.__itruediv__(a, b)             *__itruediv__()..operator.pyx*

   "a = itruediv(a, b)" is equivalent to "a /= b".

operator.ixor(a, b)                             *ixor()..operator.pyx*
operator.__ixor__(a, b)                     *__ixor__()..operator.pyx*

   "a = ixor(a, b)" is equivalent to "a ^= b".

vim:tw=78:ts=8:ft=help:norl: