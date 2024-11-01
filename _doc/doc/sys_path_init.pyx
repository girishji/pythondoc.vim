*sys_path_init.pyx*                           Last change: 2023 Sep 15

The initialization of the "sys.path" module search path
*******************************************************

A module search path is initialized when Python starts. This module
search path may be accessed at "sys.path".

The first entry in the module search path is the directory that
contains the input script, if there is one. Otherwise, the first entry
is the current directory, which is the case when executing the
interactive shell, a "-c" command, or "-m" module.

The "PYTHONPATH" environment variable is often used to add directories
to the search path. If this environment variable is found then the
contents are added to the module search path.

Note:

  "PYTHONPATH" will affect all installed Python versions/environments.
  Be wary of setting this in your shell profile or global environment
  variables. The "site" module offers more nuanced techniques as
  mentioned below.

The next items added are the directories containing standard Python
modules as well as any _extension module_s that these modules depend
on. Extension modules are ".pyd" files on Windows and ".so" files on
other platforms. The directory with the platform-independent Python
modules is called "prefix". The directory with the extension modules
is called "exec_prefix".

The "PYTHONHOME" environment variable may be used to set the "prefix"
and "exec_prefix" locations. Otherwise these directories are found by
using the Python executable as a starting point and then looking for
various ‘landmark’ files and directories. Note that any symbolic links
are followed so the real Python executable location is used as the
search starting point. The Python executable location is called
"home".

Once "home" is determined, the "prefix" directory is found by first
looking for "python_majorversion__minorversion_.zip"
("python311.zip"). On Windows the zip archive is searched for in
"home" and on Unix the archive is expected to be in "lib". Note that
the expected zip archive location is added to the module search path
even if the archive does not exist. If no archive was found, Python on
Windows will continue the search for "prefix" by looking for
"Lib\os.py". Python on Unix will look for
"lib/python_majorversion_._minorversion_/os.py"
("lib/python3.11/os.py"). On Windows "prefix" and "exec_prefix" are
the same, however on other platforms
"lib/python_majorversion_._minorversion_/lib-dynload" ("lib/python3.11
/lib-dynload") is searched for and used as an anchor for
"exec_prefix". On some platforms "lib" may be "lib64" or another
value, see "sys.platlibdir" and "PYTHONPLATLIBDIR".

Once found, "prefix" and "exec_prefix" are available at "sys.prefix"
and "sys.exec_prefix" respectively.

Finally, the "site" module is processed and "site-packages"
directories are added to the module search path. A common way to
customize the search path is to create "sitecustomize" or
"usercustomize" modules as described in the "site" module
documentation.

Note:

  Certain command line options may further affect path calculations.
  See "-E", "-I", "-s" and "-S" for further details.


Virtual environments
====================

If Python is run in a virtual environment (as described at Virtual
Environments and Packages) then "prefix" and "exec_prefix" are
specific to the virtual environment.

If a "pyvenv.cfg" file is found alongside the main executable, or in
the directory one level above the executable, the following variations
apply:

* If "home" is an absolute path and "PYTHONHOME" is not set, this path
  is used instead of the path to the main executable when deducing
  "prefix" and "exec_prefix".


_pth files
==========

To completely override "sys.path" create a "._pth" file with the same
name as the shared library or executable ("python._pth" or
"python311._pth"). The shared library path is always known on Windows,
however it may not be available on other platforms. In the "._pth"
file specify one line for each path to add to "sys.path". The file
based on the shared library name overrides the one based on the
executable, which allows paths to be restricted for any program
loading the runtime if desired.

When the file exists, all registry and environment variables are
ignored, isolated mode is enabled, and "site" is not imported unless
one line in the file specifies "import site". Blank paths and lines
starting with "#" are ignored. Each path may be absolute or relative
to the location of the file. Import statements other than to "site"
are not permitted, and arbitrary code cannot be specified.

Note that ".pth" files (without leading underscore) will be processed
normally by the "site" module when "import site" has been specified.


Embedded Python
===============

If Python is embedded within another application
"Py_InitializeFromConfig()" and the "PyConfig" structure can be used
to initialize Python. The path specific details are described at
Python Path Configuration.

See also:

  * Finding modules for detailed Windows notes.

  * Using Python on Unix platforms for Unix details.

vim:tw=78:ts=8:ft=help:norl: