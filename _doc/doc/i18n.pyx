*i18n.pyx*                                    Last change: 2023 Sep 15

Internationalization
********************

The modules described in this chapter help you write software that is
independent of language and locale by providing mechanisms for
selecting a language to be used in  program messages or by tailoring
output to match local conventions.

The list of modules described in this chapter is:

* "gettext" — Multilingual internationalization services

  * GNU **gettext** API

    * "bindtextdomain()"

    * "textdomain()"

    * "gettext()"

    * "dgettext()"

    * "ngettext()"

    * "dngettext()"

    * "pgettext()"

    * "dpgettext()"

    * "npgettext()"

    * "dnpgettext()"

  * Class-based API

    * "find()"

    * "translation()"

    * "install()"

    * The "NullTranslations" class

      * "NullTranslations"

        * "NullTranslations._parse()"

        * "NullTranslations.add_fallback()"

        * "NullTranslations.gettext()"

        * "NullTranslations.ngettext()"

        * "NullTranslations.pgettext()"

        * "NullTranslations.npgettext()"

        * "NullTranslations.info()"

        * "NullTranslations.charset()"

        * "NullTranslations.install()"

    * The "GNUTranslations" class

      * "GNUTranslations"

        * "GNUTranslations.gettext()"

        * "GNUTranslations.ngettext()"

        * "GNUTranslations.pgettext()"

        * "GNUTranslations.npgettext()"

    * Solaris message catalog support

    * The Catalog constructor

  * Internationalizing your programs and modules

    * Localizing your module

    * Localizing your application

    * Changing languages on the fly

    * Deferred translations

  * Acknowledgements

* "locale" — Internationalization services

  * "Error"

  * "setlocale()"

  * "localeconv()"

  * "nl_langinfo()"

  * "CODESET"

  * "D_T_FMT"

  * "D_FMT"

  * "T_FMT"

  * "T_FMT_AMPM"

  * "RADIXCHAR"

  * "THOUSEP"

  * "YESEXPR"

  * "NOEXPR"

  * "CRNCYSTR"

  * "ERA"

  * "ERA_D_T_FMT"

  * "ERA_D_FMT"

  * "ERA_T_FMT"

  * "ALT_DIGITS"

  * "getdefaultlocale()"

  * "getlocale()"

  * "getpreferredencoding()"

  * "getencoding()"

  * "normalize()"

  * "strcoll()"

  * "strxfrm()"

  * "format_string()"

  * "currency()"

  * "str()"

  * "delocalize()"

  * "localize()"

  * "atof()"

  * "atoi()"

  * "LC_CTYPE"

  * "LC_COLLATE"

  * "LC_TIME"

  * "LC_MONETARY"

  * "LC_MESSAGES"

  * "LC_NUMERIC"

  * "LC_ALL"

  * "CHAR_MAX"

  * Background, details, hints, tips and caveats

  * For extension writers and programs that embed Python

  * Access to message catalogs

    * "gettext()"

    * "dgettext()"

    * "dcgettext()"

    * "textdomain()"

    * "bindtextdomain()"

vim:tw=78:ts=8:ft=help:norl: