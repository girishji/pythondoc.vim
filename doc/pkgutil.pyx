*pkgutil.pyx*                                 Last change: 2023 Sep 15

"pkgutil" — Package extension utility
*************************************

**Source code:** Lib/pkgutil.py

======================================================================

This module provides utilities for the import system, in particular
package support.

                                             *ModuleInfo..pkgutil.pyx*
class pkgutil.ModuleInfo(module_finder, name, ispkg)

   A namedtuple that holds a brief summary of a module’s info.

   New in version 3.6.

pkgutil.extend_path(path, name)           *extend_path()..pkgutil.pyx*

   Extend the search path for the modules which comprise a package.
   Intended use is to place the following code in a package’s
   "__init__.py":
>
      from pkgutil import extend_path
      __path__ = extend_path(__path__, __name__)
<
   For each directory on "sys.path" that has a subdirectory that
   matches the package name, add the subdirectory to the package’s
   "__path__".  This is useful if one wants to distribute different
   parts of a single logical package as multiple directories.

   It also looks for "*.pkg" files beginning where "*" matches the
   _name_ argument.  This feature is similar to "*.pth" files (see the
   "site" module for more information), except that it doesn’t
   special-case lines starting with "import".  A "*.pkg" file is
   trusted at face value: apart from checking for duplicates, all
   entries found in a "*.pkg" file are added to the path, regardless
   of whether they exist on the filesystem.  (This is a feature.)

   If the input path is not a list (as is the case for frozen
   packages) it is returned unchanged.  The input path is not
   modified; an extended copy is returned.  Items are only appended to
   the copy at the end.

   It is assumed that "sys.path" is a sequence.  Items of "sys.path"
   that are not strings referring to existing directories are ignored.
   Unicode items on "sys.path" that cause errors when used as
   filenames may cause this function to raise an exception (in line
   with "os.path.isdir()" behavior).

pkgutil.find_loader(fullname)             *find_loader()..pkgutil.pyx*

   Retrieve a module _loader_ for the given _fullname_.

   This is a backwards compatibility wrapper around
   "importlib.util.find_spec()" that converts most failures to
   "ImportError" and only returns the loader rather than the full
   "importlib.machinery.ModuleSpec".

   Changed in version 3.3: Updated to be based directly on "importlib"
   rather than relying on the package internal **PEP 302** import
   emulation.

   Changed in version 3.4: Updated to be based on **PEP 451**

   Deprecated since version 3.12, will be removed in version 3.14: Use
   "importlib.util.find_spec()" instead.

pkgutil.get_importer(path_item)          *get_importer()..pkgutil.pyx*

   Retrieve a _finder_ for the given _path_item_.

   The returned finder is cached in "sys.path_importer_cache" if it
   was newly created by a path hook.

   The cache (or part of it) can be cleared manually if a rescan of
   "sys.path_hooks" is necessary.

   Changed in version 3.3: Updated to be based directly on "importlib"
   rather than relying on the package internal **PEP 302** import
   emulation.

pkgutil.get_loader(module_or_name)         *get_loader()..pkgutil.pyx*

   Get a _loader_ object for _module_or_name_.

   If the module or package is accessible via the normal import
   mechanism, a wrapper around the relevant part of that machinery is
   returned.  Returns "None" if the module cannot be found or
   imported.  If the named module is not already imported, its
   containing package (if any) is imported, in order to establish the
   package "__path__".

   Changed in version 3.3: Updated to be based directly on "importlib"
   rather than relying on the package internal **PEP 302** import
   emulation.

   Changed in version 3.4: Updated to be based on **PEP 451**

   Deprecated since version 3.12, will be removed in version 3.14: Use
   "importlib.util.find_spec()" instead.

pkgutil.iter_importers(fullname='')    *iter_importers()..pkgutil.pyx*

   Yield _finder_ objects for the given module name.

   If fullname contains a "'.'", the finders will be for the package
   containing fullname, otherwise they will be all registered top
   level finders (i.e. those on both "sys.meta_path" and
   "sys.path_hooks").

   If the named module is in a package, that package is imported as a
   side effect of invoking this function.

   If no module name is specified, all top level finders are produced.

   Changed in version 3.3: Updated to be based directly on "importlib"
   rather than relying on the package internal **PEP 302** import
   emulation.

                                         *iter_modules()..pkgutil.pyx*
pkgutil.iter_modules(path=None, prefix='')

   Yields "ModuleInfo" for all submodules on _path_, or, if _path_ is
   "None", all top-level modules on "sys.path".

   _path_ should be either "None" or a list of paths to look for
   modules in.

   _prefix_ is a string to output on the front of every module name on
   output.

   Note:

     Only works for a _finder_ which defines an "iter_modules()"
     method. This interface is non-standard, so the module also
     provides implementations for "importlib.machinery.FileFinder" and
     "zipimport.zipimporter".

   Changed in version 3.3: Updated to be based directly on "importlib"
   rather than relying on the package internal **PEP 302** import
   emulation.

                                        *walk_packages()..pkgutil.pyx*
pkgutil.walk_packages(path=None, prefix='', onerror=None)

   Yields "ModuleInfo" for all modules recursively on _path_, or, if
   _path_ is "None", all accessible modules.

   _path_ should be either "None" or a list of paths to look for
   modules in.

   _prefix_ is a string to output on the front of every module name on
   output.

   Note that this function must import all _packages_ (_not_ all
   modules!) on the given _path_, in order to access the "__path__"
   attribute to find submodules.

   _onerror_ is a function which gets called with one argument (the
   name of the package which was being imported) if any exception
   occurs while trying to import a package.  If no _onerror_ function
   is supplied, "ImportError"s are caught and ignored, while all other
   exceptions are propagated, terminating the search.

   Examples:
>
      # list all modules python can access
      walk_packages()

      # list all submodules of ctypes
      walk_packages(ctypes.__path__, ctypes.__name__ + '.')
<
   Note:

     Only works for a _finder_ which defines an "iter_modules()"
     method. This interface is non-standard, so the module also
     provides implementations for "importlib.machinery.FileFinder" and
     "zipimport.zipimporter".

   Changed in version 3.3: Updated to be based directly on "importlib"
   rather than relying on the package internal **PEP 302** import
   emulation.

pkgutil.get_data(package, resource)          *get_data()..pkgutil.pyx*

   Get a resource from a package.

   This is a wrapper for the _loader_ "get_data" API.  The _package_
   argument should be the name of a package, in standard module format
   ("foo.bar").  The _resource_ argument should be in the form of a
   relative filename, using "/" as the path separator.  The parent
   directory name ".." is not allowed, and nor is a rooted name
   (starting with a "/").

   The function returns a binary string that is the contents of the
   specified resource.

   For packages located in the filesystem, which have already been
   imported, this is the rough equivalent of:
>
      d = os.path.dirname(sys.modules[package].__file__)
      data = open(os.path.join(d, resource), 'rb').read()
<
   If the package cannot be located or loaded, or it uses a _loader_
   which does not support "get_data", then "None" is returned.  In
   particular, the _loader_ for _namespace packages_ does not support
   "get_data".

pkgutil.resolve_name(name)               *resolve_name()..pkgutil.pyx*

   Resolve a name to an object.

   This functionality is used in numerous places in the standard
   library (see bpo-12915) - and equivalent functionality is also in
   widely used third-party packages such as setuptools, Django and
   Pyramid.

   It is expected that _name_ will be a string in one of the following
   formats, where W is shorthand for a valid Python identifier and dot
   stands for a literal period in these pseudo-regexes:

   * "W(.W)*"

   * "W(.W)*:(W(.W)*)?"

   The first form is intended for backward compatibility only. It
   assumes that some part of the dotted name is a package, and the
   rest is an object somewhere within that package, possibly nested
   inside other objects. Because the place where the package stops and
   the object hierarchy starts can’t be inferred by inspection,
   repeated attempts to import must be done with this form.

   In the second form, the caller makes the division point clear
   through the provision of a single colon: the dotted name to the
   left of the colon is a package to be imported, and the dotted name
   to the right is the object hierarchy within that package. Only one
   import is needed in this form. If it ends with the colon, then a
   module object is returned.

   The function will return an object (which might be a module), or
   raise one of the following exceptions:

   "ValueError" – if _name_ isn’t in a recognised format.

   "ImportError" – if an import failed when it shouldn’t have.

   "AttributeError" – If a failure occurred when traversing the object
   hierarchy within the imported package to get to the desired object.

   New in version 3.9.

vim:tw=78:ts=8:ft=help:norl: