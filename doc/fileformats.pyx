*fileformats.pyx*                             Last change: 2023 Sep 15

File Formats
************

The modules described in this chapter parse various miscellaneous file
formats that aren’t markup languages and are not related to e-mail.

* "csv" — CSV File Reading and Writing

  * Module Contents

    * "reader()"

    * "writer()"

    * "register_dialect()"

    * "unregister_dialect()"

    * "get_dialect()"

    * "list_dialects()"

    * "field_size_limit()"

    * "DictReader"

    * "DictWriter"

    * "Dialect"

    * "excel"

    * "excel_tab"

    * "unix_dialect"

    * "Sniffer"

      * "Sniffer.sniff()"

      * "Sniffer.has_header()"

    * "QUOTE_ALL"

    * "QUOTE_MINIMAL"

    * "QUOTE_NONNUMERIC"

    * "QUOTE_NONE"

    * "QUOTE_NOTNULL"

    * "QUOTE_STRINGS"

    * "Error"

  * Dialects and Formatting Parameters

    * "Dialect.delimiter"

    * "Dialect.doublequote"

    * "Dialect.escapechar"

    * "Dialect.lineterminator"

    * "Dialect.quotechar"

    * "Dialect.quoting"

    * "Dialect.skipinitialspace"

    * "Dialect.strict"

  * Reader Objects

    * "csvreader.__next__()"

    * "csvreader.dialect"

    * "csvreader.line_num"

    * "DictReader.fieldnames"

  * Writer Objects

    * "csvwriter.writerow()"

    * "csvwriter.writerows()"

    * "csvwriter.dialect"

    * "DictWriter.writeheader()"

  * Examples

* "configparser" — Configuration file parser

  * Quick Start

  * Supported Datatypes

  * Fallback Values

  * Supported INI File Structure

  * Interpolation of values

    * "BasicInterpolation"

    * "ExtendedInterpolation"

  * Mapping Protocol Access

  * Customizing Parser Behaviour

    * "ConfigParser.BOOLEAN_STATES"

    * "ConfigParser.SECTCRE"

  * Legacy API Examples

  * ConfigParser Objects

    * "ConfigParser"

      * "ConfigParser.defaults()"

      * "ConfigParser.sections()"

      * "ConfigParser.add_section()"

      * "ConfigParser.has_section()"

      * "ConfigParser.options()"

      * "ConfigParser.has_option()"

      * "ConfigParser.read()"

      * "ConfigParser.read_file()"

      * "ConfigParser.read_string()"

      * "ConfigParser.read_dict()"

      * "ConfigParser.get()"

      * "ConfigParser.getint()"

      * "ConfigParser.getfloat()"

      * "ConfigParser.getboolean()"

      * "ConfigParser.items()"

      * "ConfigParser.set()"

      * "ConfigParser.write()"

      * "ConfigParser.remove_option()"

      * "ConfigParser.remove_section()"

      * "ConfigParser.optionxform()"

    * "MAX_INTERPOLATION_DEPTH"

  * RawConfigParser Objects

    * "RawConfigParser"

      * "RawConfigParser.add_section()"

      * "RawConfigParser.set()"

  * Exceptions

    * "Error"

    * "NoSectionError"

    * "DuplicateSectionError"

    * "DuplicateOptionError"

    * "NoOptionError"

    * "InterpolationError"

    * "InterpolationDepthError"

    * "InterpolationMissingOptionError"

    * "InterpolationSyntaxError"

    * "MissingSectionHeaderError"

    * "ParsingError"

* "tomllib" — Parse TOML files

  * "load()"

  * "loads()"

  * "TOMLDecodeError"

  * Examples

  * Conversion Table

* "netrc" — netrc file processing

  * "netrc"

  * "NetrcParseError"

    * "NetrcParseError.msg"

    * "NetrcParseError.filename"

    * "NetrcParseError.lineno"

  * netrc Objects

    * "netrc.authenticators()"

    * "netrc.__repr__()"

    * "netrc.hosts"

    * "netrc.macros"

* "plistlib" — Generate and parse Apple ".plist" files

  * "load()"

  * "loads()"

  * "dump()"

  * "dumps()"

  * "UID"

  * "FMT_XML"

  * "FMT_BINARY"

  * Examples

vim:tw=78:ts=8:ft=help:norl: