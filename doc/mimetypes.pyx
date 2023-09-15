*mimetypes.pyx*                               Last change: 2023 Sep 15

"mimetypes" — Map filenames to MIME types
*****************************************

**Source code:** Lib/mimetypes.py

======================================================================

The "mimetypes" module converts between a filename or URL and the MIME
type associated with the filename extension.  Conversions are provided
from filename to MIME type and from MIME type to filename extension;
encodings are not supported for the latter conversion.

The module provides one class and a number of convenience functions.
The functions are the normal interface to this module, but some
applications may be interested in the class as well.

The functions described below provide the primary interface for this
module.  If the module has not been initialized, they will call
"init()" if they rely on the information "init()" sets up.

mimetypes.guess_type(url, strict=True)   *guess_type()..mimetypes.pyx*

   Guess the type of a file based on its filename, path or URL, given
   by _url_. URL can be a string or a _path-like object_.

   The return value is a tuple "(type, encoding)" where _type_ is
   "None" if the type can’t be guessed (missing or unknown suffix) or
   a string of the form "'type/subtype'", usable for a MIME _content-
   type_ header.

   _encoding_ is "None" for no encoding or the name of the program
   used to encode (e.g. **compress** or **gzip**). The encoding is
   suitable for use as a _Content-Encoding_ header, **not** as a
   _Content-Transfer-Encoding_ header. The mappings are table driven.
   Encoding suffixes are case sensitive; type suffixes are first tried
   case sensitively, then case insensitively.

   The optional _strict_ argument is a flag specifying whether the
   list of known MIME types is limited to only the official types
   registered with IANA. When _strict_ is "True" (the default), only
   the IANA types are supported; when _strict_ is "False", some
   additional non-standard but commonly used MIME types are also
   recognized.

   Changed in version 3.8: Added support for url being a _path-like
   object_.

                               *guess_all_extensions()..mimetypes.pyx*
mimetypes.guess_all_extensions(type, strict=True)

   Guess the extensions for a file based on its MIME type, given by
   _type_. The return value is a list of strings giving all possible
   filename extensions, including the leading dot ("'.'").  The
   extensions are not guaranteed to have been associated with any
   particular data stream, but would be mapped to the MIME type _type_
   by "guess_type()".

   The optional _strict_ argument has the same meaning as with the
   "guess_type()" function.

                                    *guess_extension()..mimetypes.pyx*
mimetypes.guess_extension(type, strict=True)

   Guess the extension for a file based on its MIME type, given by
   _type_. The return value is a string giving a filename extension,
   including the leading dot ("'.'").  The extension is not guaranteed
   to have been associated with any particular data stream, but would
   be mapped to the MIME type _type_ by "guess_type()".  If no
   extension can be guessed for _type_, "None" is returned.

   The optional _strict_ argument has the same meaning as with the
   "guess_type()" function.

Some additional functions and data items are available for controlling
the behavior of the module.

mimetypes.init(files=None)                     *init()..mimetypes.pyx*

   Initialize the internal data structures.  If given, _files_ must be
   a sequence of file names which should be used to augment the
   default type map.  If omitted, the file names to use are taken from
   "knownfiles"; on Windows, the current registry settings are loaded.
   Each file named in _files_ or "knownfiles" takes precedence over
   those named before it.  Calling "init()" repeatedly is allowed.

   Specifying an empty list for _files_ will prevent the system
   defaults from being applied: only the well-known values will be
   present from a built-in list.

   If _files_ is "None" the internal data structure is completely
   rebuilt to its initial default value. This is a stable operation
   and will produce the same results when called multiple times.

   Changed in version 3.2: Previously, Windows registry settings were
   ignored.

                                    *read_mime_types()..mimetypes.pyx*
mimetypes.read_mime_types(filename)

   Load the type map given in the file _filename_, if it exists.  The
   type map is returned as a dictionary mapping filename extensions,
   including the leading dot ("'.'"), to strings of the form
   "'type/subtype'".  If the file _filename_ does not exist or cannot
   be read, "None" is returned.

                                           *add_type()..mimetypes.pyx*
mimetypes.add_type(type, ext, strict=True)

   Add a mapping from the MIME type _type_ to the extension _ext_.
   When the extension is already known, the new type will replace the
   old one. When the type is already known the extension will be added
   to the list of known extensions.

   When _strict_ is "True" (the default), the mapping will be added to
   the official MIME types, otherwise to the non-standard ones.

mimetypes.inited                               *inited..mimetypes.pyx*

   Flag indicating whether or not the global data structures have been
   initialized. This is set to "True" by "init()".

mimetypes.knownfiles                       *knownfiles..mimetypes.pyx*

   List of type map file names commonly installed.  These files are
   typically named "mime.types" and are installed in different
   locations by different packages.

mimetypes.suffix_map                       *suffix_map..mimetypes.pyx*

   Dictionary mapping suffixes to suffixes.  This is used to allow
   recognition of encoded files for which the encoding and the type
   are indicated by the same extension.  For example, the ".tgz"
   extension is mapped to ".tar.gz" to allow the encoding and type to
   be recognized separately.

mimetypes.encodings_map                 *encodings_map..mimetypes.pyx*

   Dictionary mapping filename extensions to encoding types.

mimetypes.types_map                         *types_map..mimetypes.pyx*

   Dictionary mapping filename extensions to MIME types.

mimetypes.common_types                   *common_types..mimetypes.pyx*

   Dictionary mapping filename extensions to non-standard, but
   commonly found MIME types.

An example usage of the module:
>
   >>> import mimetypes
   >>> mimetypes.init()
   >>> mimetypes.knownfiles
   ['/etc/mime.types', '/etc/httpd/mime.types', ... ]
   >>> mimetypes.suffix_map['.tgz']
   '.tar.gz'
   >>> mimetypes.encodings_map['.gz']
   'gzip'
   >>> mimetypes.types_map['.tgz']
   'application/x-tar-gz'
<

MimeTypes Objects
=================

The "MimeTypes" class may be useful for applications which may want
more than one MIME-type database; it provides an interface similar to
the one of the "mimetypes" module.

                                            *MimeTypes..mimetypes.pyx*
class mimetypes.MimeTypes(filenames=(), strict=True)

   This class represents a MIME-types database.  By default, it
   provides access to the same database as the rest of this module.
   The initial database is a copy of that provided by the module, and
   may be extended by loading additional "mime.types"-style files into
   the database using the "read()" or "readfp()" methods.  The mapping
   dictionaries may also be cleared before loading additional data if
   the default data is not desired.

   The optional _filenames_ parameter can be used to cause additional
   files to be loaded “on top” of the default database.

   suffix_map                       *MimeTypes.suffix_map..mimetypes.pyx*

      Dictionary mapping suffixes to suffixes.  This is used to allow
      recognition of encoded files for which the encoding and the type
      are indicated by the same extension.  For example, the ".tgz"
      extension is mapped to ".tar.gz" to allow the encoding and type
      to be recognized separately.  This is initially a copy of the
      global "suffix_map" defined in the module.

   encodings_map                 *MimeTypes.encodings_map..mimetypes.pyx*

      Dictionary mapping filename extensions to encoding types.  This
      is initially a copy of the global "encodings_map" defined in the
      module.

   types_map                         *MimeTypes.types_map..mimetypes.pyx*

      Tuple containing two dictionaries, mapping filename extensions
      to MIME types: the first dictionary is for the non-standards
      types and the second one is for the standard types. They are
      initialized by "common_types" and "types_map".

   types_map_inv                 *MimeTypes.types_map_inv..mimetypes.pyx*

      Tuple containing two dictionaries, mapping MIME types to a list
      of filename extensions: the first dictionary is for the non-
      standards types and the second one is for the standard types.
      They are initialized by "common_types" and "types_map".

                          *MimeTypes.guess_extension()..mimetypes.pyx*
   guess_extension(type, strict=True)

      Similar to the "guess_extension()" function, using the tables
      stored as part of the object.

   guess_type(url, strict=True)   *MimeTypes.guess_type()..mimetypes.pyx*

      Similar to the "guess_type()" function, using the tables stored
      as part of the object.

                     *MimeTypes.guess_all_extensions()..mimetypes.pyx*
   guess_all_extensions(type, strict=True)

      Similar to the "guess_all_extensions()" function, using the
      tables stored as part of the object.

   read(filename, strict=True)          *MimeTypes.read()..mimetypes.pyx*

      Load MIME information from a file named _filename_.  This uses
      "readfp()" to parse the file.

      If _strict_ is "True", information will be added to list of
      standard types, else to the list of non-standard types.

   readfp(fp, strict=True)            *MimeTypes.readfp()..mimetypes.pyx*

      Load MIME type information from an open file _fp_.  The file
      must have the format of the standard "mime.types" files.

      If _strict_ is "True", information will be added to the list of
      standard types, else to the list of non-standard types.

                    *MimeTypes.read_windows_registry()..mimetypes.pyx*
   read_windows_registry(strict=True)

      Load MIME type information from the Windows registry.

      Availability: Windows.

      If _strict_ is "True", information will be added to the list of
      standard types, else to the list of non-standard types.

      New in version 3.2.

vim:tw=78:ts=8:ft=help:norl: