*allos.pyx*                                   Last change: 2023 Sep 15

Generic Operating System Services
*********************************

The modules described in this chapter provide interfaces to operating
system features that are available on (almost) all operating systems,
such as files and a clock.  The interfaces are generally modeled after
the Unix or C interfaces, but they are available on most other systems
as well.  Here’s an overview:

* "os" — Miscellaneous operating system interfaces

  * "error"

  * "name"

  * File Names, Command Line Arguments, and Environment Variables

  * Python UTF-8 Mode

  * Process Parameters

    * "ctermid()"

    * "environ"

    * "environb"

    * "fsencode()"

    * "fsdecode()"

    * "fspath()"

    * "PathLike"

      * "PathLike.__fspath__()"

    * "getenv()"

    * "getenvb()"

    * "get_exec_path()"

    * "getegid()"

    * "geteuid()"

    * "getgid()"

    * "getgrouplist()"

    * "getgroups()"

    * "getlogin()"

    * "getpgid()"

    * "getpgrp()"

    * "getpid()"

    * "getppid()"

    * "getpriority()"

    * "PRIO_PROCESS"

    * "PRIO_PGRP"

    * "PRIO_USER"

    * "PRIO_DARWIN_THREAD"

    * "PRIO_DARWIN_PROCESS"

    * "PRIO_DARWIN_BG"

    * "PRIO_DARWIN_NONUI"

    * "getresuid()"

    * "getresgid()"

    * "getuid()"

    * "initgroups()"

    * "putenv()"

    * "setegid()"

    * "seteuid()"

    * "setgid()"

    * "setgroups()"

    * "setns()"

    * "setpgrp()"

    * "setpgid()"

    * "setpriority()"

    * "setregid()"

    * "setresgid()"

    * "setresuid()"

    * "setreuid()"

    * "getsid()"

    * "setsid()"

    * "setuid()"

    * "strerror()"

    * "supports_bytes_environ"

    * "umask()"

    * "uname()"

    * "unsetenv()"

    * "unshare()"

    * "CLONE_FILES"

    * "CLONE_FS"

    * "CLONE_NEWCGROUP"

    * "CLONE_NEWIPC"

    * "CLONE_NEWNET"

    * "CLONE_NEWNS"

    * "CLONE_NEWPID"

    * "CLONE_NEWTIME"

    * "CLONE_NEWUSER"

    * "CLONE_NEWUTS"

    * "CLONE_SIGHAND"

    * "CLONE_SYSVSEM"

    * "CLONE_THREAD"

    * "CLONE_VM"

  * File Object Creation

    * "fdopen()"

  * File Descriptor Operations

    * "close()"

    * "closerange()"

    * "copy_file_range()"

    * "device_encoding()"

    * "dup()"

    * "dup2()"

    * "fchmod()"

    * "fchown()"

    * "fdatasync()"

    * "fpathconf()"

    * "fstat()"

    * "fstatvfs()"

    * "fsync()"

    * "ftruncate()"

    * "get_blocking()"

    * "isatty()"

    * "lockf()"

    * "F_LOCK"

    * "F_TLOCK"

    * "F_ULOCK"

    * "F_TEST"

    * "login_tty()"

    * "lseek()"

    * "SEEK_SET"

    * "SEEK_CUR"

    * "SEEK_END"

    * "SEEK_HOLE"

    * "SEEK_DATA"

    * "open()"

    * "O_RDONLY"

    * "O_WRONLY"

    * "O_RDWR"

    * "O_APPEND"

    * "O_CREAT"

    * "O_EXCL"

    * "O_TRUNC"

    * "O_DSYNC"

    * "O_RSYNC"

    * "O_SYNC"

    * "O_NDELAY"

    * "O_NONBLOCK"

    * "O_NOCTTY"

    * "O_CLOEXEC"

    * "O_BINARY"

    * "O_NOINHERIT"

    * "O_SHORT_LIVED"

    * "O_TEMPORARY"

    * "O_RANDOM"

    * "O_SEQUENTIAL"

    * "O_TEXT"

    * "O_EVTONLY"

    * "O_FSYNC"

    * "O_SYMLINK"

    * "O_NOFOLLOW_ANY"

    * "O_ASYNC"

    * "O_DIRECT"

    * "O_DIRECTORY"

    * "O_NOFOLLOW"

    * "O_NOATIME"

    * "O_PATH"

    * "O_TMPFILE"

    * "O_SHLOCK"

    * "O_EXLOCK"

    * "openpty()"

    * "pipe()"

    * "pipe2()"

    * "posix_fallocate()"

    * "posix_fadvise()"

    * "POSIX_FADV_NORMAL"

    * "POSIX_FADV_SEQUENTIAL"

    * "POSIX_FADV_RANDOM"

    * "POSIX_FADV_NOREUSE"

    * "POSIX_FADV_WILLNEED"

    * "POSIX_FADV_DONTNEED"

    * "pread()"

    * "preadv()"

    * "RWF_NOWAIT"

    * "RWF_HIPRI"

    * "pwrite()"

    * "pwritev()"

    * "RWF_DSYNC"

    * "RWF_SYNC"

    * "RWF_APPEND"

    * "read()"

    * "sendfile()"

    * "SF_NODISKIO"

    * "SF_MNOWAIT"

    * "SF_SYNC"

    * "SF_NOCACHE"

    * "set_blocking()"

    * "splice()"

    * "SPLICE_F_MOVE"

    * "SPLICE_F_NONBLOCK"

    * "SPLICE_F_MORE"

    * "readv()"

    * "tcgetpgrp()"

    * "tcsetpgrp()"

    * "ttyname()"

    * "write()"

    * "writev()"

    * Querying the size of a terminal

      * "get_terminal_size()"

      * "terminal_size"

        * "terminal_size.columns"

        * "terminal_size.lines"

    * Inheritance of File Descriptors

      * "get_inheritable()"

      * "set_inheritable()"

      * "get_handle_inheritable()"

      * "set_handle_inheritable()"

  * Files and Directories

    * "access()"

    * "F_OK"

    * "R_OK"

    * "W_OK"

    * "X_OK"

    * "chdir()"

    * "chflags()"

    * "chmod()"

    * "chown()"

    * "chroot()"

    * "fchdir()"

    * "getcwd()"

    * "getcwdb()"

    * "lchflags()"

    * "lchmod()"

    * "lchown()"

    * "link()"

    * "listdir()"

    * "listdrives()"

    * "listmounts()"

    * "listvolumes()"

    * "lstat()"

    * "mkdir()"

    * "makedirs()"

    * "mkfifo()"

    * "mknod()"

    * "major()"

    * "minor()"

    * "makedev()"

    * "pathconf()"

    * "pathconf_names"

    * "readlink()"

    * "remove()"

    * "removedirs()"

    * "rename()"

    * "renames()"

    * "replace()"

    * "rmdir()"

    * "scandir()"

      * "scandir.close()"

    * "DirEntry"

      * "DirEntry.name"

      * "DirEntry.path"

      * "DirEntry.inode()"

      * "DirEntry.is_dir()"

      * "DirEntry.is_file()"

      * "DirEntry.is_symlink()"

      * "DirEntry.is_junction()"

      * "DirEntry.stat()"

    * "stat()"

    * "stat_result"

      * "stat_result.st_mode"

      * "stat_result.st_ino"

      * "stat_result.st_dev"

      * "stat_result.st_nlink"

      * "stat_result.st_uid"

      * "stat_result.st_gid"

      * "stat_result.st_size"

      * "stat_result.st_atime"

      * "stat_result.st_mtime"

      * "stat_result.st_ctime"

      * "stat_result.st_atime_ns"

      * "stat_result.st_mtime_ns"

      * "stat_result.st_ctime_ns"

      * "stat_result.st_birthtime"

      * "stat_result.st_birthtime_ns"

      * "stat_result.st_blocks"

      * "stat_result.st_blksize"

      * "stat_result.st_rdev"

      * "stat_result.st_flags"

      * "stat_result.st_gen"

      * "stat_result.st_fstype"

      * "stat_result.st_rsize"

      * "stat_result.st_creator"

      * "stat_result.st_type"

      * "stat_result.st_file_attributes"

      * "stat_result.st_reparse_tag"

    * "statvfs()"

    * "supports_dir_fd"

    * "supports_effective_ids"

    * "supports_fd"

    * "supports_follow_symlinks"

    * "symlink()"

    * "sync()"

    * "truncate()"

    * "unlink()"

    * "utime()"

    * "walk()"

    * "fwalk()"

    * "memfd_create()"

    * "MFD_CLOEXEC"

    * "MFD_ALLOW_SEALING"

    * "MFD_HUGETLB"

    * "MFD_HUGE_SHIFT"

    * "MFD_HUGE_MASK"

    * "MFD_HUGE_64KB"

    * "MFD_HUGE_512KB"

    * "MFD_HUGE_1MB"

    * "MFD_HUGE_2MB"

    * "MFD_HUGE_8MB"

    * "MFD_HUGE_16MB"

    * "MFD_HUGE_32MB"

    * "MFD_HUGE_256MB"

    * "MFD_HUGE_512MB"

    * "MFD_HUGE_1GB"

    * "MFD_HUGE_2GB"

    * "MFD_HUGE_16GB"

    * "eventfd()"

    * "eventfd_read()"

    * "eventfd_write()"

    * "EFD_CLOEXEC"

    * "EFD_NONBLOCK"

    * "EFD_SEMAPHORE"

    * Linux extended attributes

      * "getxattr()"

      * "listxattr()"

      * "removexattr()"

      * "setxattr()"

      * "XATTR_SIZE_MAX"

      * "XATTR_CREATE"

      * "XATTR_REPLACE"

  * Process Management

    * "abort()"

    * "add_dll_directory()"

    * "execl()"

    * "execle()"

    * "execlp()"

    * "execlpe()"

    * "execv()"

    * "execve()"

    * "execvp()"

    * "execvpe()"

    * "_exit()"

    * "EX_OK"

    * "EX_USAGE"

    * "EX_DATAERR"

    * "EX_NOINPUT"

    * "EX_NOUSER"

    * "EX_NOHOST"

    * "EX_UNAVAILABLE"

    * "EX_SOFTWARE"

    * "EX_OSERR"

    * "EX_OSFILE"

    * "EX_CANTCREAT"

    * "EX_IOERR"

    * "EX_TEMPFAIL"

    * "EX_PROTOCOL"

    * "EX_NOPERM"

    * "EX_CONFIG"

    * "EX_NOTFOUND"

    * "fork()"

    * "forkpty()"

    * "kill()"

    * "killpg()"

    * "nice()"

    * "pidfd_open()"

    * "PIDFD_NONBLOCK"

    * "plock()"

    * "popen()"

    * "posix_spawn()"

    * "POSIX_SPAWN_OPEN"

    * "POSIX_SPAWN_CLOSE"

    * "POSIX_SPAWN_DUP2"

    * "posix_spawnp()"

    * "register_at_fork()"

    * "spawnl()"

    * "spawnle()"

    * "spawnlp()"

    * "spawnlpe()"

    * "spawnv()"

    * "spawnve()"

    * "spawnvp()"

    * "spawnvpe()"

    * "P_NOWAIT"

    * "P_NOWAITO"

    * "P_WAIT"

    * "P_DETACH"

    * "P_OVERLAY"

    * "startfile()"

    * "system()"

    * "times()"

    * "wait()"

    * "waitid()"

    * "waitpid()"

    * "wait3()"

    * "wait4()"

    * "P_PID"

    * "P_PGID"

    * "P_ALL"

    * "P_PIDFD"

    * "WCONTINUED"

    * "WEXITED"

    * "WSTOPPED"

    * "WUNTRACED"

    * "WNOHANG"

    * "WNOWAIT"

    * "CLD_EXITED"

    * "CLD_KILLED"

    * "CLD_DUMPED"

    * "CLD_TRAPPED"

    * "CLD_STOPPED"

    * "CLD_CONTINUED"

    * "waitstatus_to_exitcode()"

    * "WCOREDUMP()"

    * "WIFCONTINUED()"

    * "WIFSTOPPED()"

    * "WIFSIGNALED()"

    * "WIFEXITED()"

    * "WEXITSTATUS()"

    * "WSTOPSIG()"

    * "WTERMSIG()"

  * Interface to the scheduler

    * "SCHED_OTHER"

    * "SCHED_BATCH"

    * "SCHED_IDLE"

    * "SCHED_SPORADIC"

    * "SCHED_FIFO"

    * "SCHED_RR"

    * "SCHED_RESET_ON_FORK"

    * "sched_param"

      * "sched_param.sched_priority"

    * "sched_get_priority_min()"

    * "sched_get_priority_max()"

    * "sched_setscheduler()"

    * "sched_getscheduler()"

    * "sched_setparam()"

    * "sched_getparam()"

    * "sched_rr_get_interval()"

    * "sched_yield()"

    * "sched_setaffinity()"

    * "sched_getaffinity()"

  * Miscellaneous System Information

    * "confstr()"

    * "confstr_names"

    * "cpu_count()"

    * "getloadavg()"

    * "sysconf()"

    * "sysconf_names"

    * "curdir"

    * "pardir"

    * "sep"

    * "altsep"

    * "extsep"

    * "pathsep"

    * "defpath"

    * "linesep"

    * "devnull"

    * "RTLD_LAZY"

    * "RTLD_NOW"

    * "RTLD_GLOBAL"

    * "RTLD_LOCAL"

    * "RTLD_NODELETE"

    * "RTLD_NOLOAD"

    * "RTLD_DEEPBIND"

  * Random numbers

    * "getrandom()"

    * "urandom()"

    * "GRND_NONBLOCK"

    * "GRND_RANDOM"

* "io" — Core tools for working with streams

  * Overview

    * Text I/O

    * Binary I/O

    * Raw I/O

  * Text Encoding

    * Opt-in EncodingWarning

  * High-level Module Interface

    * "DEFAULT_BUFFER_SIZE"

    * "open()"

    * "open_code()"

    * "text_encoding()"

    * "BlockingIOError"

    * "UnsupportedOperation"

  * Class hierarchy

    * I/O Base Classes

      * "IOBase"

        * "IOBase.close()"

        * "IOBase.closed"

        * "IOBase.fileno()"

        * "IOBase.flush()"

        * "IOBase.isatty()"

        * "IOBase.readable()"

        * "IOBase.readline()"

        * "IOBase.readlines()"

        * "IOBase.seek()"

        * "IOBase.seekable()"

        * "IOBase.tell()"

        * "IOBase.truncate()"

        * "IOBase.writable()"

        * "IOBase.writelines()"

        * "IOBase.__del__()"

      * "RawIOBase"

        * "RawIOBase.read()"

        * "RawIOBase.readall()"

        * "RawIOBase.readinto()"

        * "RawIOBase.write()"

      * "BufferedIOBase"

        * "BufferedIOBase.raw"

        * "BufferedIOBase.detach()"

        * "BufferedIOBase.read()"

        * "BufferedIOBase.read1()"

        * "BufferedIOBase.readinto()"

        * "BufferedIOBase.readinto1()"

        * "BufferedIOBase.write()"

    * Raw File I/O

      * "FileIO"

        * "FileIO.mode"

        * "FileIO.name"

    * Buffered Streams

      * "BytesIO"

        * "BytesIO.getbuffer()"

        * "BytesIO.getvalue()"

        * "BytesIO.read1()"

        * "BytesIO.readinto1()"

      * "BufferedReader"

        * "BufferedReader.peek()"

        * "BufferedReader.read()"

        * "BufferedReader.read1()"

      * "BufferedWriter"

        * "BufferedWriter.flush()"

        * "BufferedWriter.write()"

      * "BufferedRandom"

      * "BufferedRWPair"

    * Text I/O

      * "TextIOBase"

        * "TextIOBase.encoding"

        * "TextIOBase.errors"

        * "TextIOBase.newlines"

        * "TextIOBase.buffer"

        * "TextIOBase.detach()"

        * "TextIOBase.read()"

        * "TextIOBase.readline()"

        * "TextIOBase.seek()"

        * "TextIOBase.tell()"

        * "TextIOBase.write()"

      * "TextIOWrapper"

        * "TextIOWrapper.line_buffering"

        * "TextIOWrapper.write_through"

        * "TextIOWrapper.reconfigure()"

        * "TextIOWrapper.seek()"

        * "TextIOWrapper.tell()"

      * "StringIO"

        * "StringIO.getvalue()"

      * "IncrementalNewlineDecoder"

  * Performance

    * Binary I/O

    * Text I/O

    * Multi-threading

    * Reentrancy

* "time" — Time access and conversions

  * Functions

    * "asctime()"

    * "pthread_getcpuclockid()"

    * "clock_getres()"

    * "clock_gettime()"

    * "clock_gettime_ns()"

    * "clock_settime()"

    * "clock_settime_ns()"

    * "ctime()"

    * "get_clock_info()"

    * "gmtime()"

    * "localtime()"

    * "mktime()"

    * "monotonic()"

    * "monotonic_ns()"

    * "perf_counter()"

    * "perf_counter_ns()"

    * "process_time()"

    * "process_time_ns()"

    * "sleep()"

    * "strftime()"

    * "strptime()"

    * "struct_time"

    * "time()"

    * "time_ns()"

    * "thread_time()"

    * "thread_time_ns()"

    * "tzset()"

  * Clock ID Constants

    * "CLOCK_BOOTTIME"

    * "CLOCK_HIGHRES"

    * "CLOCK_MONOTONIC"

    * "CLOCK_MONOTONIC_RAW"

    * "CLOCK_PROCESS_CPUTIME_ID"

    * "CLOCK_PROF"

    * "CLOCK_TAI"

    * "CLOCK_THREAD_CPUTIME_ID"

    * "CLOCK_UPTIME"

    * "CLOCK_UPTIME_RAW"

    * "CLOCK_REALTIME"

  * Timezone Constants

    * "altzone"

    * "daylight"

    * "timezone"

    * "tzname"

* "argparse" — Parser for command-line options, arguments and sub-
  commands

  * Core Functionality

  * Quick Links for add_argument()

  * Example

    * Creating a parser

    * Adding arguments

    * Parsing arguments

  * ArgumentParser objects

    * "ArgumentParser"

    * prog

    * usage

    * description

    * epilog

    * parents

    * formatter_class

      * "RawDescriptionHelpFormatter"

      * "RawTextHelpFormatter"

      * "ArgumentDefaultsHelpFormatter"

      * "MetavarTypeHelpFormatter"

    * prefix_chars

    * fromfile_prefix_chars

    * argument_default

    * allow_abbrev

    * conflict_handler

    * add_help

    * exit_on_error

  * The add_argument() method

    * "ArgumentParser.add_argument()"

    * name or flags

    * action

    * nargs

    * const

    * default

    * type

    * choices

    * required

    * help

    * metavar

    * dest

    * Action classes

      * "Action"

  * The parse_args() method

    * "ArgumentParser.parse_args()"

    * Option value syntax

    * Invalid arguments

    * Arguments containing "-"

    * Argument abbreviations (prefix matching)

    * Beyond "sys.argv"

    * The Namespace object

      * "Namespace"

  * Other utilities

    * Sub-commands

      * "ArgumentParser.add_subparsers()"

    * FileType objects

      * "FileType"

    * Argument groups

      * "ArgumentParser.add_argument_group()"

    * Mutual exclusion

      * "ArgumentParser.add_mutually_exclusive_group()"

    * Parser defaults

      * "ArgumentParser.set_defaults()"

      * "ArgumentParser.get_default()"

    * Printing help

      * "ArgumentParser.print_usage()"

      * "ArgumentParser.print_help()"

      * "ArgumentParser.format_usage()"

      * "ArgumentParser.format_help()"

    * Partial parsing

      * "ArgumentParser.parse_known_args()"

    * Customizing file parsing

      * "ArgumentParser.convert_arg_line_to_args()"

    * Exiting methods

      * "ArgumentParser.exit()"

      * "ArgumentParser.error()"

    * Intermixed parsing

      * "ArgumentParser.parse_intermixed_args()"

      * "ArgumentParser.parse_known_intermixed_args()"

  * Upgrading optparse code

  * Exceptions

    * "ArgumentError"

    * "ArgumentTypeError"

* "getopt" — C-style parser for command line options

  * "getopt()"

  * "gnu_getopt()"

  * "GetoptError"

  * "error"

* "logging" — Logging facility for Python

  * Logger Objects

    * "Logger"

      * "Logger.propagate"

      * "Logger.setLevel()"

      * "Logger.isEnabledFor()"

      * "Logger.getEffectiveLevel()"

      * "Logger.getChild()"

      * "Logger.getChildren()"

      * "Logger.debug()"

      * "Logger.info()"

      * "Logger.warning()"

      * "Logger.error()"

      * "Logger.critical()"

      * "Logger.log()"

      * "Logger.exception()"

      * "Logger.addFilter()"

      * "Logger.removeFilter()"

      * "Logger.filter()"

      * "Logger.addHandler()"

      * "Logger.removeHandler()"

      * "Logger.findCaller()"

      * "Logger.handle()"

      * "Logger.makeRecord()"

      * "Logger.hasHandlers()"

  * Logging Levels

    * "NOTSET"

    * "DEBUG"

    * "INFO"

    * "WARNING"

    * "ERROR"

    * "CRITICAL"

  * Handler Objects

    * "Handler"

      * "Handler.__init__()"

      * "Handler.createLock()"

      * "Handler.acquire()"

      * "Handler.release()"

      * "Handler.setLevel()"

      * "Handler.setFormatter()"

      * "Handler.addFilter()"

      * "Handler.removeFilter()"

      * "Handler.filter()"

      * "Handler.flush()"

      * "Handler.close()"

      * "Handler.handle()"

      * "Handler.handleError()"

      * "Handler.format()"

      * "Handler.emit()"

  * Formatter Objects

    * "Formatter"

      * "Formatter.format()"

      * "Formatter.formatTime()"

      * "Formatter.formatException()"

      * "Formatter.formatStack()"

    * "BufferingFormatter"

      * "BufferingFormatter.formatHeader()"

      * "BufferingFormatter.formatFooter()"

      * "BufferingFormatter.format()"

  * Filter Objects

    * "Filter"

      * "Filter.filter()"

  * LogRecord Objects

    * "LogRecord"

      * "LogRecord.getMessage()"

  * LogRecord attributes

  * LoggerAdapter Objects

    * "LoggerAdapter"

      * "LoggerAdapter.process()"

      * "LoggerAdapter.manager"

      * "LoggerAdapter._log"

  * Thread Safety

  * Module-Level Functions

    * "getLogger()"

    * "getLoggerClass()"

    * "getLogRecordFactory()"

    * "debug()"

    * "info()"

    * "warning()"

    * "error()"

    * "critical()"

    * "exception()"

    * "log()"

    * "disable()"

    * "addLevelName()"

    * "getLevelNamesMapping()"

    * "getLevelName()"

    * "getHandlerByName()"

    * "getHandlerNames()"

    * "makeLogRecord()"

    * "basicConfig()"

    * "shutdown()"

    * "setLoggerClass()"

    * "setLogRecordFactory()"

  * Module-Level Attributes

    * "lastResort"

  * Integration with the warnings module

    * "captureWarnings()"

* "logging.config" — Logging configuration

  * Configuration functions

    * "dictConfig()"

    * "fileConfig()"

    * "listen()"

    * "stopListening()"

  * Security considerations

  * Configuration dictionary schema

    * Dictionary Schema Details

    * Incremental Configuration

    * Object connections

    * User-defined objects

    * Handler configuration order

    * Access to external objects

    * Access to internal objects

    * Import resolution and custom importers

    * Configuring QueueHandler and QueueListener

  * Configuration file format

* "logging.handlers" — Logging handlers

  * StreamHandler

    * "StreamHandler"

      * "StreamHandler.emit()"

      * "StreamHandler.flush()"

      * "StreamHandler.setStream()"

      * "StreamHandler.terminator"

  * FileHandler

    * "FileHandler"

      * "FileHandler.close()"

      * "FileHandler.emit()"

  * NullHandler

    * "NullHandler"

      * "NullHandler.emit()"

      * "NullHandler.handle()"

      * "NullHandler.createLock()"

  * WatchedFileHandler

    * "WatchedFileHandler"

      * "WatchedFileHandler.reopenIfNeeded()"

      * "WatchedFileHandler.emit()"

  * BaseRotatingHandler

    * "BaseRotatingHandler"

      * "BaseRotatingHandler.namer"

      * "BaseRotatingHandler.rotator"

      * "BaseRotatingHandler.rotation_filename()"

      * "BaseRotatingHandler.rotate()"

  * RotatingFileHandler

    * "RotatingFileHandler"

      * "RotatingFileHandler.doRollover()"

      * "RotatingFileHandler.emit()"

  * TimedRotatingFileHandler

    * "TimedRotatingFileHandler"

      * "TimedRotatingFileHandler.doRollover()"

      * "TimedRotatingFileHandler.emit()"

      * "TimedRotatingFileHandler.getFilesToDelete()"

  * SocketHandler

    * "SocketHandler"

      * "SocketHandler.close()"

      * "SocketHandler.emit()"

      * "SocketHandler.handleError()"

      * "SocketHandler.makeSocket()"

      * "SocketHandler.makePickle()"

      * "SocketHandler.send()"

      * "SocketHandler.createSocket()"

  * DatagramHandler

    * "DatagramHandler"

      * "DatagramHandler.emit()"

      * "DatagramHandler.makeSocket()"

      * "DatagramHandler.send()"

  * SysLogHandler

    * "SysLogHandler"

      * "SysLogHandler.close()"

      * "SysLogHandler.createSocket()"

      * "SysLogHandler.emit()"

      * "SysLogHandler.encodePriority()"

      * "SysLogHandler.mapPriority()"

  * NTEventLogHandler

    * "NTEventLogHandler"

      * "NTEventLogHandler.close()"

      * "NTEventLogHandler.emit()"

      * "NTEventLogHandler.getEventCategory()"

      * "NTEventLogHandler.getEventType()"

      * "NTEventLogHandler.getMessageID()"

  * SMTPHandler

    * "SMTPHandler"

      * "SMTPHandler.emit()"

      * "SMTPHandler.getSubject()"

  * MemoryHandler

    * "BufferingHandler"

      * "BufferingHandler.emit()"

      * "BufferingHandler.flush()"

      * "BufferingHandler.shouldFlush()"

    * "MemoryHandler"

      * "MemoryHandler.close()"

      * "MemoryHandler.flush()"

      * "MemoryHandler.setTarget()"

      * "MemoryHandler.shouldFlush()"

  * HTTPHandler

    * "HTTPHandler"

      * "HTTPHandler.mapLogRecord()"

      * "HTTPHandler.emit()"

  * QueueHandler

    * "QueueHandler"

      * "QueueHandler.emit()"

      * "QueueHandler.prepare()"

      * "QueueHandler.enqueue()"

      * "QueueHandler.listener"

  * QueueListener

    * "QueueListener"

      * "QueueListener.dequeue()"

      * "QueueListener.prepare()"

      * "QueueListener.handle()"

      * "QueueListener.start()"

      * "QueueListener.stop()"

      * "QueueListener.enqueue_sentinel()"

* "getpass" — Portable password input

  * "getpass()"

  * "GetPassWarning"

  * "getuser()"

* "curses" — Terminal handling for character-cell displays

  * Functions

    * "error"

    * "baudrate()"

    * "beep()"

    * "can_change_color()"

    * "cbreak()"

    * "color_content()"

    * "color_pair()"

    * "curs_set()"

    * "def_prog_mode()"

    * "def_shell_mode()"

    * "delay_output()"

    * "doupdate()"

    * "echo()"

    * "endwin()"

    * "erasechar()"

    * "filter()"

    * "flash()"

    * "flushinp()"

    * "getmouse()"

    * "getsyx()"

    * "getwin()"

    * "has_colors()"

    * "has_extended_color_support()"

    * "has_ic()"

    * "has_il()"

    * "has_key()"

    * "halfdelay()"

    * "init_color()"

    * "init_pair()"

    * "initscr()"

    * "is_term_resized()"

    * "isendwin()"

    * "keyname()"

    * "killchar()"

    * "longname()"

    * "meta()"

    * "mouseinterval()"

    * "mousemask()"

    * "napms()"

    * "newpad()"

    * "newwin()"

    * "nl()"

    * "nocbreak()"

    * "noecho()"

    * "nonl()"

    * "noqiflush()"

    * "noraw()"

    * "pair_content()"

    * "pair_number()"

    * "putp()"

    * "qiflush()"

    * "raw()"

    * "reset_prog_mode()"

    * "reset_shell_mode()"

    * "resetty()"

    * "resize_term()"

    * "resizeterm()"

    * "savetty()"

    * "get_escdelay()"

    * "set_escdelay()"

    * "get_tabsize()"

    * "set_tabsize()"

    * "setsyx()"

    * "setupterm()"

    * "start_color()"

    * "termattrs()"

    * "termname()"

    * "tigetflag()"

    * "tigetnum()"

    * "tigetstr()"

    * "tparm()"

    * "typeahead()"

    * "unctrl()"

    * "ungetch()"

    * "update_lines_cols()"

    * "unget_wch()"

    * "ungetmouse()"

    * "use_env()"

    * "use_default_colors()"

    * "wrapper()"

  * Window Objects

    * "window.addch()"

    * "window.addnstr()"

    * "window.addstr()"

    * "window.attroff()"

    * "window.attron()"

    * "window.attrset()"

    * "window.bkgd()"

    * "window.bkgdset()"

    * "window.border()"

    * "window.box()"

    * "window.chgat()"

    * "window.clear()"

    * "window.clearok()"

    * "window.clrtobot()"

    * "window.clrtoeol()"

    * "window.cursyncup()"

    * "window.delch()"

    * "window.deleteln()"

    * "window.derwin()"

    * "window.echochar()"

    * "window.enclose()"

    * "window.encoding"

    * "window.erase()"

    * "window.getbegyx()"

    * "window.getbkgd()"

    * "window.getch()"

    * "window.get_wch()"

    * "window.getkey()"

    * "window.getmaxyx()"

    * "window.getparyx()"

    * "window.getstr()"

    * "window.getyx()"

    * "window.hline()"

    * "window.idcok()"

    * "window.idlok()"

    * "window.immedok()"

    * "window.inch()"

    * "window.insch()"

    * "window.insdelln()"

    * "window.insertln()"

    * "window.insnstr()"

    * "window.insstr()"

    * "window.instr()"

    * "window.is_linetouched()"

    * "window.is_wintouched()"

    * "window.keypad()"

    * "window.leaveok()"

    * "window.move()"

    * "window.mvderwin()"

    * "window.mvwin()"

    * "window.nodelay()"

    * "window.notimeout()"

    * "window.noutrefresh()"

    * "window.overlay()"

    * "window.overwrite()"

    * "window.putwin()"

    * "window.redrawln()"

    * "window.redrawwin()"

    * "window.refresh()"

    * "window.resize()"

    * "window.scroll()"

    * "window.scrollok()"

    * "window.setscrreg()"

    * "window.standend()"

    * "window.standout()"

    * "window.subpad()"

    * "window.subwin()"

    * "window.syncdown()"

    * "window.syncok()"

    * "window.syncup()"

    * "window.timeout()"

    * "window.touchline()"

    * "window.touchwin()"

    * "window.untouchwin()"

    * "window.vline()"

  * Constants

    * "ERR"

    * "OK"

    * "version"

    * "__version__"

    * "ncurses_version"

    * "COLORS"

    * "COLOR_PAIRS"

    * "COLS"

    * "LINES"

    * "A_ALTCHARSET"

    * "A_BLINK"

    * "A_BOLD"

    * "A_DIM"

    * "A_INVIS"

    * "A_ITALIC"

    * "A_NORMAL"

    * "A_PROTECT"

    * "A_REVERSE"

    * "A_STANDOUT"

    * "A_UNDERLINE"

    * "A_HORIZONTAL"

    * "A_LEFT"

    * "A_LOW"

    * "A_RIGHT"

    * "A_TOP"

    * "A_VERTICAL"

    * "A_ATTRIBUTES"

    * "A_CHARTEXT"

    * "A_COLOR"

    * "KEY_MIN"

    * "KEY_BREAK"

    * "KEY_DOWN"

    * "KEY_UP"

    * "KEY_LEFT"

    * "KEY_RIGHT"

    * "KEY_HOME"

    * "KEY_BACKSPACE"

    * "KEY_F0"

    * "KEY_Fn"

    * "KEY_DL"

    * "KEY_IL"

    * "KEY_DC"

    * "KEY_IC"

    * "KEY_EIC"

    * "KEY_CLEAR"

    * "KEY_EOS"

    * "KEY_EOL"

    * "KEY_SF"

    * "KEY_SR"

    * "KEY_NPAGE"

    * "KEY_PPAGE"

    * "KEY_STAB"

    * "KEY_CTAB"

    * "KEY_CATAB"

    * "KEY_ENTER"

    * "KEY_SRESET"

    * "KEY_RESET"

    * "KEY_PRINT"

    * "KEY_LL"

    * "KEY_A1"

    * "KEY_A3"

    * "KEY_B2"

    * "KEY_C1"

    * "KEY_C3"

    * "KEY_BTAB"

    * "KEY_BEG"

    * "KEY_CANCEL"

    * "KEY_CLOSE"

    * "KEY_COMMAND"

    * "KEY_COPY"

    * "KEY_CREATE"

    * "KEY_END"

    * "KEY_EXIT"

    * "KEY_FIND"

    * "KEY_HELP"

    * "KEY_MARK"

    * "KEY_MESSAGE"

    * "KEY_MOVE"

    * "KEY_NEXT"

    * "KEY_OPEN"

    * "KEY_OPTIONS"

    * "KEY_PREVIOUS"

    * "KEY_REDO"

    * "KEY_REFERENCE"

    * "KEY_REFRESH"

    * "KEY_REPLACE"

    * "KEY_RESTART"

    * "KEY_RESUME"

    * "KEY_SAVE"

    * "KEY_SBEG"

    * "KEY_SCANCEL"

    * "KEY_SCOMMAND"

    * "KEY_SCOPY"

    * "KEY_SCREATE"

    * "KEY_SDC"

    * "KEY_SDL"

    * "KEY_SELECT"

    * "KEY_SEND"

    * "KEY_SEOL"

    * "KEY_SEXIT"

    * "KEY_SFIND"

    * "KEY_SHELP"

    * "KEY_SHOME"

    * "KEY_SIC"

    * "KEY_SLEFT"

    * "KEY_SMESSAGE"

    * "KEY_SMOVE"

    * "KEY_SNEXT"

    * "KEY_SOPTIONS"

    * "KEY_SPREVIOUS"

    * "KEY_SPRINT"

    * "KEY_SREDO"

    * "KEY_SREPLACE"

    * "KEY_SRIGHT"

    * "KEY_SRSUME"

    * "KEY_SSAVE"

    * "KEY_SSUSPEND"

    * "KEY_SUNDO"

    * "KEY_SUSPEND"

    * "KEY_UNDO"

    * "KEY_MOUSE"

    * "KEY_RESIZE"

    * "KEY_MAX"

    * "ACS_BBSS"

    * "ACS_BLOCK"

    * "ACS_BOARD"

    * "ACS_BSBS"

    * "ACS_BSSB"

    * "ACS_BSSS"

    * "ACS_BTEE"

    * "ACS_BULLET"

    * "ACS_CKBOARD"

    * "ACS_DARROW"

    * "ACS_DEGREE"

    * "ACS_DIAMOND"

    * "ACS_GEQUAL"

    * "ACS_HLINE"

    * "ACS_LANTERN"

    * "ACS_LARROW"

    * "ACS_LEQUAL"

    * "ACS_LLCORNER"

    * "ACS_LRCORNER"

    * "ACS_LTEE"

    * "ACS_NEQUAL"

    * "ACS_PI"

    * "ACS_PLMINUS"

    * "ACS_PLUS"

    * "ACS_RARROW"

    * "ACS_RTEE"

    * "ACS_S1"

    * "ACS_S3"

    * "ACS_S7"

    * "ACS_S9"

    * "ACS_SBBS"

    * "ACS_SBSB"

    * "ACS_SBSS"

    * "ACS_SSBB"

    * "ACS_SSBS"

    * "ACS_SSSB"

    * "ACS_SSSS"

    * "ACS_STERLING"

    * "ACS_TTEE"

    * "ACS_UARROW"

    * "ACS_ULCORNER"

    * "ACS_URCORNER"

    * "ACS_VLINE"

    * "BUTTONn_PRESSED"

    * "BUTTONn_RELEASED"

    * "BUTTONn_CLICKED"

    * "BUTTONn_DOUBLE_CLICKED"

    * "BUTTONn_TRIPLE_CLICKED"

    * "BUTTON_SHIFT"

    * "BUTTON_CTRL"

    * "BUTTON_ALT"

    * "COLOR_BLACK"

    * "COLOR_BLUE"

    * "COLOR_CYAN"

    * "COLOR_GREEN"

    * "COLOR_MAGENTA"

    * "COLOR_RED"

    * "COLOR_WHITE"

    * "COLOR_YELLOW"

* "curses.textpad" — Text input widget for curses programs

  * "rectangle()"

  * Textbox objects

    * "Textbox"

      * "Textbox.edit()"

      * "Textbox.do_command()"

      * "Textbox.gather()"

      * "Textbox.stripspaces"

* "curses.ascii" — Utilities for ASCII characters

  * "NUL"

  * "SOH"

  * "STX"

  * "ETX"

  * "EOT"

  * "ENQ"

  * "ACK"

  * "BEL"

  * "BS"

  * "TAB"

  * "HT"

  * "LF"

  * "NL"

  * "VT"

  * "FF"

  * "CR"

  * "SO"

  * "SI"

  * "DLE"

  * "DC1"

  * "DC2"

  * "DC3"

  * "DC4"

  * "NAK"

  * "SYN"

  * "ETB"

  * "CAN"

  * "EM"

  * "SUB"

  * "ESC"

  * "FS"

  * "GS"

  * "RS"

  * "US"

  * "SP"

  * "DEL"

  * "isalnum()"

  * "isalpha()"

  * "isascii()"

  * "isblank()"

  * "iscntrl()"

  * "isdigit()"

  * "isgraph()"

  * "islower()"

  * "isprint()"

  * "ispunct()"

  * "isspace()"

  * "isupper()"

  * "isxdigit()"

  * "isctrl()"

  * "ismeta()"

  * "ascii()"

  * "ctrl()"

  * "alt()"

  * "unctrl()"

  * "controlnames"

* "curses.panel" — A panel stack extension for curses

  * Functions

    * "bottom_panel()"

    * "new_panel()"

    * "top_panel()"

    * "update_panels()"

  * Panel Objects

    * "Panel.above()"

    * "Panel.below()"

    * "Panel.bottom()"

    * "Panel.hidden()"

    * "Panel.hide()"

    * "Panel.move()"

    * "Panel.replace()"

    * "Panel.set_userptr()"

    * "Panel.show()"

    * "Panel.top()"

    * "Panel.userptr()"

    * "Panel.window()"

* "platform" —  Access to underlying platform’s identifying data

  * Cross Platform

    * "architecture()"

    * "machine()"

    * "node()"

    * "platform()"

    * "processor()"

    * "python_build()"

    * "python_compiler()"

    * "python_branch()"

    * "python_implementation()"

    * "python_revision()"

    * "python_version()"

    * "python_version_tuple()"

    * "release()"

    * "system()"

    * "system_alias()"

    * "version()"

    * "uname()"

  * Java Platform

    * "java_ver()"

  * Windows Platform

    * "win32_ver()"

    * "win32_edition()"

    * "win32_is_iot()"

  * macOS Platform

    * "mac_ver()"

  * Unix Platforms

    * "libc_ver()"

  * Linux Platforms

    * "freedesktop_os_release()"

* "errno" — Standard errno system symbols

  * "errorcode"

  * "EPERM"

  * "ENOENT"

  * "ESRCH"

  * "EINTR"

  * "EIO"

  * "ENXIO"

  * "E2BIG"

  * "ENOEXEC"

  * "EBADF"

  * "ECHILD"

  * "EAGAIN"

  * "ENOMEM"

  * "EACCES"

  * "EFAULT"

  * "ENOTBLK"

  * "EBUSY"

  * "EEXIST"

  * "EXDEV"

  * "ENODEV"

  * "ENOTDIR"

  * "EISDIR"

  * "EINVAL"

  * "ENFILE"

  * "EMFILE"

  * "ENOTTY"

  * "ETXTBSY"

  * "EFBIG"

  * "ENOSPC"

  * "ESPIPE"

  * "EROFS"

  * "EMLINK"

  * "EPIPE"

  * "EDOM"

  * "ERANGE"

  * "EDEADLK"

  * "ENAMETOOLONG"

  * "ENOLCK"

  * "ENOSYS"

  * "ENOTEMPTY"

  * "ELOOP"

  * "EWOULDBLOCK"

  * "ENOMSG"

  * "EIDRM"

  * "ECHRNG"

  * "EL2NSYNC"

  * "EL3HLT"

  * "EL3RST"

  * "ELNRNG"

  * "EUNATCH"

  * "ENOCSI"

  * "EL2HLT"

  * "EBADE"

  * "EBADR"

  * "EXFULL"

  * "ENOANO"

  * "EBADRQC"

  * "EBADSLT"

  * "EDEADLOCK"

  * "EBFONT"

  * "ENOSTR"

  * "ENODATA"

  * "ETIME"

  * "ENOSR"

  * "ENONET"

  * "ENOPKG"

  * "EREMOTE"

  * "ENOLINK"

  * "EADV"

  * "ESRMNT"

  * "ECOMM"

  * "EPROTO"

  * "EMULTIHOP"

  * "EDOTDOT"

  * "EBADMSG"

  * "EOVERFLOW"

  * "ENOTUNIQ"

  * "EBADFD"

  * "EREMCHG"

  * "ELIBACC"

  * "ELIBBAD"

  * "ELIBSCN"

  * "ELIBMAX"

  * "ELIBEXEC"

  * "EILSEQ"

  * "ERESTART"

  * "ESTRPIPE"

  * "EUSERS"

  * "ENOTSOCK"

  * "EDESTADDRREQ"

  * "EMSGSIZE"

  * "EPROTOTYPE"

  * "ENOPROTOOPT"

  * "EPROTONOSUPPORT"

  * "ESOCKTNOSUPPORT"

  * "EOPNOTSUPP"

  * "ENOTSUP"

  * "EPFNOSUPPORT"

  * "EAFNOSUPPORT"

  * "EADDRINUSE"

  * "EADDRNOTAVAIL"

  * "ENETDOWN"

  * "ENETUNREACH"

  * "ENETRESET"

  * "ECONNABORTED"

  * "ECONNRESET"

  * "ENOBUFS"

  * "EISCONN"

  * "ENOTCONN"

  * "ESHUTDOWN"

  * "ETOOMANYREFS"

  * "ETIMEDOUT"

  * "ECONNREFUSED"

  * "EHOSTDOWN"

  * "EHOSTUNREACH"

  * "EALREADY"

  * "EINPROGRESS"

  * "ESTALE"

  * "EUCLEAN"

  * "ENOTNAM"

  * "ENAVAIL"

  * "EISNAM"

  * "EREMOTEIO"

  * "EDQUOT"

  * "EQFULL"

  * "ENOTCAPABLE"

  * "ECANCELED"

  * "EOWNERDEAD"

  * "ENOTRECOVERABLE"

* "ctypes" — A foreign function library for Python

  * ctypes tutorial

    * Loading dynamic link libraries

    * Accessing functions from loaded dlls

    * Calling functions

    * Fundamental data types

    * Calling functions, continued

    * Calling variadic functions

    * Calling functions with your own custom data types

    * Specifying the required argument types (function prototypes)

    * Return types

    * Passing pointers (or: passing parameters by reference)

    * Structures and unions

    * Structure/union alignment and byte order

    * Bit fields in structures and unions

    * Arrays

    * Pointers

    * Type conversions

    * Incomplete Types

    * Callback functions

    * Accessing values exported from dlls

    * Surprises

    * Variable-sized data types

  * ctypes reference

    * Finding shared libraries

    * Loading shared libraries

      * "CDLL"

      * "OleDLL"

      * "WinDLL"

      * "PyDLL"

        * "PyDLL._handle"

        * "PyDLL._name"

      * "LibraryLoader"

        * "LibraryLoader.LoadLibrary()"

    * Foreign functions

      * "_FuncPtr"

        * "_FuncPtr.restype"

        * "_FuncPtr.argtypes"

        * "_FuncPtr.errcheck"

      * "ArgumentError"

    * Function prototypes

      * "CFUNCTYPE()"

      * "WINFUNCTYPE()"

      * "PYFUNCTYPE()"

    * Utility functions

      * "addressof()"

      * "alignment()"

      * "byref()"

      * "cast()"

      * "create_string_buffer()"

      * "create_unicode_buffer()"

      * "DllCanUnloadNow()"

      * "DllGetClassObject()"

      * "find_library()"

      * "find_msvcrt()"

      * "FormatError()"

      * "GetLastError()"

      * "get_errno()"

      * "get_last_error()"

      * "memmove()"

      * "memset()"

      * "POINTER()"

      * "pointer()"

      * "resize()"

      * "set_errno()"

      * "set_last_error()"

      * "sizeof()"

      * "string_at()"

      * "WinError()"

      * "wstring_at()"

    * Data types

      * "_CData"

        * "_CData.from_buffer()"

        * "_CData.from_buffer_copy()"

        * "_CData.from_address()"

        * "_CData.from_param()"

        * "_CData.in_dll()"

        * "_CData._b_base_"

        * "_CData._b_needsfree_"

        * "_CData._objects"

    * Fundamental data types

      * "_SimpleCData"

        * "_SimpleCData.value"

      * "c_byte"

      * "c_char"

      * "c_char_p"

      * "c_double"

      * "c_longdouble"

      * "c_float"

      * "c_int"

      * "c_int8"

      * "c_int16"

      * "c_int32"

      * "c_int64"

      * "c_long"

      * "c_longlong"

      * "c_short"

      * "c_size_t"

      * "c_ssize_t"

      * "c_time_t"

      * "c_ubyte"

      * "c_uint"

      * "c_uint8"

      * "c_uint16"

      * "c_uint32"

      * "c_uint64"

      * "c_ulong"

      * "c_ulonglong"

      * "c_ushort"

      * "c_void_p"

      * "c_wchar"

      * "c_wchar_p"

      * "c_bool"

      * "HRESULT"

      * "py_object"

    * Structured data types

      * "Union"

      * "BigEndianUnion"

      * "LittleEndianUnion"

      * "BigEndianStructure"

      * "LittleEndianStructure"

      * "Structure"

        * "Structure._fields_"

        * "Structure._pack_"

        * "Structure._anonymous_"

    * Arrays and pointers

      * "Array"

        * "Array._length_"

        * "Array._type_"

      * "_Pointer"

        * "_Pointer._type_"

        * "_Pointer.contents"

vim:tw=78:ts=8:ft=help:norl: