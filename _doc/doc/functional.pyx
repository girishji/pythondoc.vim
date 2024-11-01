*functional.pyx*                              Last change: 2023 Sep 15

Functional Programming Modules
******************************

The modules described in this chapter provide functions and classes
that support a functional programming style, and general operations on
callables.

The following modules are documented in this chapter:

* "itertools" — Functions creating iterators for efficient looping

  * Itertool functions

    * "accumulate()"

    * "batched()"

    * "chain()"

      * "chain.from_iterable()"

    * "combinations()"

    * "combinations_with_replacement()"

    * "compress()"

    * "count()"

    * "cycle()"

    * "dropwhile()"

    * "filterfalse()"

    * "groupby()"

    * "islice()"

    * "pairwise()"

    * "permutations()"

    * "product()"

    * "repeat()"

    * "starmap()"

    * "takewhile()"

    * "tee()"

    * "zip_longest()"

  * Itertools Recipes

* "functools" — Higher-order functions and operations on callable
  objects

  * "cache()"

  * "cached_property()"

  * "cmp_to_key()"

  * "lru_cache()"

  * "total_ordering()"

  * "partial()"

  * "partialmethod"

  * "reduce()"

  * "singledispatch()"

  * "singledispatchmethod"

  * "update_wrapper()"

  * "wraps()"

  * "partial" Objects

    * "partial.func"

    * "partial.args"

    * "partial.keywords"

* "operator" — Standard operators as functions

  * "lt()"

  * "le()"

  * "eq()"

  * "ne()"

  * "ge()"

  * "gt()"

  * "__lt__()"

  * "__le__()"

  * "__eq__()"

  * "__ne__()"

  * "__ge__()"

  * "__gt__()"

  * "not_()"

  * "__not__()"

  * "truth()"

  * "is_()"

  * "is_not()"

  * "abs()"

  * "__abs__()"

  * "add()"

  * "__add__()"

  * "and_()"

  * "__and__()"

  * "floordiv()"

  * "__floordiv__()"

  * "index()"

  * "__index__()"

  * "inv()"

  * "invert()"

  * "__inv__()"

  * "__invert__()"

  * "lshift()"

  * "__lshift__()"

  * "mod()"

  * "__mod__()"

  * "mul()"

  * "__mul__()"

  * "matmul()"

  * "__matmul__()"

  * "neg()"

  * "__neg__()"

  * "or_()"

  * "__or__()"

  * "pos()"

  * "__pos__()"

  * "pow()"

  * "__pow__()"

  * "rshift()"

  * "__rshift__()"

  * "sub()"

  * "__sub__()"

  * "truediv()"

  * "__truediv__()"

  * "xor()"

  * "__xor__()"

  * "concat()"

  * "__concat__()"

  * "contains()"

  * "__contains__()"

  * "countOf()"

  * "delitem()"

  * "__delitem__()"

  * "getitem()"

  * "__getitem__()"

  * "indexOf()"

  * "setitem()"

  * "__setitem__()"

  * "length_hint()"

  * "call()"

  * "__call__()"

  * "attrgetter()"

  * "itemgetter()"

  * "methodcaller()"

  * Mapping Operators to Functions

  * In-place Operators

    * "iadd()"

    * "__iadd__()"

    * "iand()"

    * "__iand__()"

    * "iconcat()"

    * "__iconcat__()"

    * "ifloordiv()"

    * "__ifloordiv__()"

    * "ilshift()"

    * "__ilshift__()"

    * "imod()"

    * "__imod__()"

    * "imul()"

    * "__imul__()"

    * "imatmul()"

    * "__imatmul__()"

    * "ior()"

    * "__ior__()"

    * "ipow()"

    * "__ipow__()"

    * "irshift()"

    * "__irshift__()"

    * "isub()"

    * "__isub__()"

    * "itruediv()"

    * "__itruediv__()"

    * "ixor()"

    * "__ixor__()"

vim:tw=78:ts=8:ft=help:norl: