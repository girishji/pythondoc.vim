*windows.pyx*                                 Last change: 2023 Sep 15

MS Windows Specific Services
****************************

This chapter describes modules that are only available on MS Windows
platforms.

* "msvcrt" — Useful routines from the MS VC++ runtime

  * File Operations

    * "locking()"

    * "LK_LOCK"

    * "LK_RLCK"

    * "LK_NBLCK"

    * "LK_NBRLCK"

    * "LK_UNLCK"

    * "setmode()"

    * "open_osfhandle()"

    * "get_osfhandle()"

  * Console I/O

    * "kbhit()"

    * "getch()"

    * "getwch()"

    * "getche()"

    * "getwche()"

    * "putch()"

    * "putwch()"

    * "ungetch()"

    * "ungetwch()"

  * Other Functions

    * "heapmin()"

* "winreg" — Windows registry access

  * Functions

    * "CloseKey()"

    * "ConnectRegistry()"

    * "CreateKey()"

    * "CreateKeyEx()"

    * "DeleteKey()"

    * "DeleteKeyEx()"

    * "DeleteValue()"

    * "EnumKey()"

    * "EnumValue()"

    * "ExpandEnvironmentStrings()"

    * "FlushKey()"

    * "LoadKey()"

    * "OpenKey()"

    * "OpenKeyEx()"

    * "QueryInfoKey()"

    * "QueryValue()"

    * "QueryValueEx()"

    * "SaveKey()"

    * "SetValue()"

    * "SetValueEx()"

    * "DisableReflectionKey()"

    * "EnableReflectionKey()"

    * "QueryReflectionKey()"

  * Constants

    * HKEY_* Constants

      * "HKEY_CLASSES_ROOT"

      * "HKEY_CURRENT_USER"

      * "HKEY_LOCAL_MACHINE"

      * "HKEY_USERS"

      * "HKEY_PERFORMANCE_DATA"

      * "HKEY_CURRENT_CONFIG"

      * "HKEY_DYN_DATA"

    * Access Rights

      * "KEY_ALL_ACCESS"

      * "KEY_WRITE"

      * "KEY_READ"

      * "KEY_EXECUTE"

      * "KEY_QUERY_VALUE"

      * "KEY_SET_VALUE"

      * "KEY_CREATE_SUB_KEY"

      * "KEY_ENUMERATE_SUB_KEYS"

      * "KEY_NOTIFY"

      * "KEY_CREATE_LINK"

      * 64-bit Specific

        * "KEY_WOW64_64KEY"

        * "KEY_WOW64_32KEY"

    * Value Types

      * "REG_BINARY"

      * "REG_DWORD"

      * "REG_DWORD_LITTLE_ENDIAN"

      * "REG_DWORD_BIG_ENDIAN"

      * "REG_EXPAND_SZ"

      * "REG_LINK"

      * "REG_MULTI_SZ"

      * "REG_NONE"

      * "REG_QWORD"

      * "REG_QWORD_LITTLE_ENDIAN"

      * "REG_RESOURCE_LIST"

      * "REG_FULL_RESOURCE_DESCRIPTOR"

      * "REG_RESOURCE_REQUIREMENTS_LIST"

      * "REG_SZ"

  * Registry Handle Objects

    * "PyHKEY.Close()"

    * "PyHKEY.Detach()"

    * "PyHKEY.__enter__()"

    * "PyHKEY.__exit__()"

* "winsound" — Sound-playing interface for Windows

  * "Beep()"

  * "PlaySound()"

  * "MessageBeep()"

  * "SND_FILENAME"

  * "SND_ALIAS"

  * "SND_LOOP"

  * "SND_MEMORY"

  * "SND_PURGE"

  * "SND_ASYNC"

  * "SND_NODEFAULT"

  * "SND_NOSTOP"

  * "SND_NOWAIT"

  * "MB_ICONASTERISK"

  * "MB_ICONEXCLAMATION"

  * "MB_ICONHAND"

  * "MB_ICONQUESTION"

  * "MB_OK"

vim:tw=78:ts=8:ft=help:norl: