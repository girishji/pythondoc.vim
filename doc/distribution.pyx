*distribution.pyx*                            Last change: 2023 Sep 15

Software Packaging and Distribution
***********************************

These libraries help you with publishing and installing Python
software. While these modules are designed to work in conjunction with
the Python Package Index, they can also be used with a local index
server, or without any index server at all.

* "ensurepip" — Bootstrapping the "pip" installer

  * Command line interface

  * Module API

    * "version()"

    * "bootstrap()"

* "venv" — Creation of virtual environments

  * Creating virtual environments

  * How venvs work

  * API

    * "EnvBuilder"

      * "EnvBuilder.create()"

      * "EnvBuilder.ensure_directories()"

      * "EnvBuilder.create_configuration()"

      * "EnvBuilder.setup_python()"

      * "EnvBuilder.setup_scripts()"

      * "EnvBuilder.upgrade_dependencies()"

      * "EnvBuilder.post_setup()"

      * "EnvBuilder.install_scripts()"

    * "create()"

  * An example of extending "EnvBuilder"

* "zipapp" — Manage executable Python zip archives

  * Basic Example

  * Command-Line Interface

  * Python API

    * "create_archive()"

    * "get_interpreter()"

  * Examples

  * Specifying the Interpreter

  * Creating Standalone Applications with zipapp

    * Caveats

  * The Python Zip Application Archive Format

vim:tw=78:ts=8:ft=help:norl: