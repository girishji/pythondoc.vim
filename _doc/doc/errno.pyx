*errno.pyx*                                   Last change: 2023 Sep 15

"errno" — Standard errno system symbols
***************************************

======================================================================

This module makes available standard "errno" system symbols. The value
of each symbol is the corresponding integer value. The names and
descriptions are borrowed from "linux/include/errno.h", which should
be all-inclusive.

errno.errorcode                                 *errorcode..errno.pyx*

   Dictionary providing a mapping from the errno value to the string
   name in the underlying system.  For instance,
   "errno.errorcode[errno.EPERM]" maps to "'EPERM'".

To translate a numeric error code to an error message, use
"os.strerror()".

Of the following list, symbols that are not used on the current
platform are not defined by the module.  The specific list of defined
symbols is available as "errno.errorcode.keys()".  Symbols available
can include:

errno.EPERM                                         *EPERM..errno.pyx*

   Operation not permitted. This error is mapped to the exception
   "PermissionError".

errno.ENOENT                                       *ENOENT..errno.pyx*

   No such file or directory. This error is mapped to the exception
   "FileNotFoundError".

errno.ESRCH                                         *ESRCH..errno.pyx*

   No such process. This error is mapped to the exception
   "ProcessLookupError".

errno.EINTR                                         *EINTR..errno.pyx*

   Interrupted system call. This error is mapped to the exception
   "InterruptedError".

errno.EIO                                             *EIO..errno.pyx*

   I/O error

errno.ENXIO                                         *ENXIO..errno.pyx*

   No such device or address

errno.E2BIG                                         *E2BIG..errno.pyx*

   Arg list too long

errno.ENOEXEC                                     *ENOEXEC..errno.pyx*

   Exec format error

errno.EBADF                                         *EBADF..errno.pyx*

   Bad file number

errno.ECHILD                                       *ECHILD..errno.pyx*

   No child processes. This error is mapped to the exception
   "ChildProcessError".

errno.EAGAIN                                       *EAGAIN..errno.pyx*

   Try again. This error is mapped to the exception "BlockingIOError".

errno.ENOMEM                                       *ENOMEM..errno.pyx*

   Out of memory

errno.EACCES                                       *EACCES..errno.pyx*

   Permission denied.  This error is mapped to the exception
   "PermissionError".

errno.EFAULT                                       *EFAULT..errno.pyx*

   Bad address

errno.ENOTBLK                                     *ENOTBLK..errno.pyx*

   Block device required

errno.EBUSY                                         *EBUSY..errno.pyx*

   Device or resource busy

errno.EEXIST                                       *EEXIST..errno.pyx*

   File exists. This error is mapped to the exception
   "FileExistsError".

errno.EXDEV                                         *EXDEV..errno.pyx*

   Cross-device link

errno.ENODEV                                       *ENODEV..errno.pyx*

   No such device

errno.ENOTDIR                                     *ENOTDIR..errno.pyx*

   Not a directory. This error is mapped to the exception
   "NotADirectoryError".

errno.EISDIR                                       *EISDIR..errno.pyx*

   Is a directory. This error is mapped to the exception
   "IsADirectoryError".

errno.EINVAL                                       *EINVAL..errno.pyx*

   Invalid argument

errno.ENFILE                                       *ENFILE..errno.pyx*

   File table overflow

errno.EMFILE                                       *EMFILE..errno.pyx*

   Too many open files

errno.ENOTTY                                       *ENOTTY..errno.pyx*

   Not a typewriter

errno.ETXTBSY                                     *ETXTBSY..errno.pyx*

   Text file busy

errno.EFBIG                                         *EFBIG..errno.pyx*

   File too large

errno.ENOSPC                                       *ENOSPC..errno.pyx*

   No space left on device

errno.ESPIPE                                       *ESPIPE..errno.pyx*

   Illegal seek

errno.EROFS                                         *EROFS..errno.pyx*

   Read-only file system

errno.EMLINK                                       *EMLINK..errno.pyx*

   Too many links

errno.EPIPE                                         *EPIPE..errno.pyx*

   Broken pipe. This error is mapped to the exception
   "BrokenPipeError".

errno.EDOM                                           *EDOM..errno.pyx*

   Math argument out of domain of func

errno.ERANGE                                       *ERANGE..errno.pyx*

   Math result not representable

errno.EDEADLK                                     *EDEADLK..errno.pyx*

   Resource deadlock would occur

errno.ENAMETOOLONG                           *ENAMETOOLONG..errno.pyx*

   File name too long

errno.ENOLCK                                       *ENOLCK..errno.pyx*

   No record locks available

errno.ENOSYS                                       *ENOSYS..errno.pyx*

   Function not implemented

errno.ENOTEMPTY                                 *ENOTEMPTY..errno.pyx*

   Directory not empty

errno.ELOOP                                         *ELOOP..errno.pyx*

   Too many symbolic links encountered

errno.EWOULDBLOCK                             *EWOULDBLOCK..errno.pyx*

   Operation would block. This error is mapped to the exception
   "BlockingIOError".

errno.ENOMSG                                       *ENOMSG..errno.pyx*

   No message of desired type

errno.EIDRM                                         *EIDRM..errno.pyx*

   Identifier removed

errno.ECHRNG                                       *ECHRNG..errno.pyx*

   Channel number out of range

errno.EL2NSYNC                                   *EL2NSYNC..errno.pyx*

   Level 2 not synchronized

errno.EL3HLT                                       *EL3HLT..errno.pyx*

   Level 3 halted

errno.EL3RST                                       *EL3RST..errno.pyx*

   Level 3 reset

errno.ELNRNG                                       *ELNRNG..errno.pyx*

   Link number out of range

errno.EUNATCH                                     *EUNATCH..errno.pyx*

   Protocol driver not attached

errno.ENOCSI                                       *ENOCSI..errno.pyx*

   No CSI structure available

errno.EL2HLT                                       *EL2HLT..errno.pyx*

   Level 2 halted

errno.EBADE                                         *EBADE..errno.pyx*

   Invalid exchange

errno.EBADR                                         *EBADR..errno.pyx*

   Invalid request descriptor

errno.EXFULL                                       *EXFULL..errno.pyx*

   Exchange full

errno.ENOANO                                       *ENOANO..errno.pyx*

   No anode

errno.EBADRQC                                     *EBADRQC..errno.pyx*

   Invalid request code

errno.EBADSLT                                     *EBADSLT..errno.pyx*

   Invalid slot

errno.EDEADLOCK                                 *EDEADLOCK..errno.pyx*

   File locking deadlock error

errno.EBFONT                                       *EBFONT..errno.pyx*

   Bad font file format

errno.ENOSTR                                       *ENOSTR..errno.pyx*

   Device not a stream

errno.ENODATA                                     *ENODATA..errno.pyx*

   No data available

errno.ETIME                                         *ETIME..errno.pyx*

   Timer expired

errno.ENOSR                                         *ENOSR..errno.pyx*

   Out of streams resources

errno.ENONET                                       *ENONET..errno.pyx*

   Machine is not on the network

errno.ENOPKG                                       *ENOPKG..errno.pyx*

   Package not installed

errno.EREMOTE                                     *EREMOTE..errno.pyx*

   Object is remote

errno.ENOLINK                                     *ENOLINK..errno.pyx*

   Link has been severed

errno.EADV                                           *EADV..errno.pyx*

   Advertise error

errno.ESRMNT                                       *ESRMNT..errno.pyx*

   Srmount error

errno.ECOMM                                         *ECOMM..errno.pyx*

   Communication error on send

errno.EPROTO                                       *EPROTO..errno.pyx*

   Protocol error

errno.EMULTIHOP                                 *EMULTIHOP..errno.pyx*

   Multihop attempted

errno.EDOTDOT                                     *EDOTDOT..errno.pyx*

   RFS specific error

errno.EBADMSG                                     *EBADMSG..errno.pyx*

   Not a data message

errno.EOVERFLOW                                 *EOVERFLOW..errno.pyx*

   Value too large for defined data type

errno.ENOTUNIQ                                   *ENOTUNIQ..errno.pyx*

   Name not unique on network

errno.EBADFD                                       *EBADFD..errno.pyx*

   File descriptor in bad state

errno.EREMCHG                                     *EREMCHG..errno.pyx*

   Remote address changed

errno.ELIBACC                                     *ELIBACC..errno.pyx*

   Can not access a needed shared library

errno.ELIBBAD                                     *ELIBBAD..errno.pyx*

   Accessing a corrupted shared library

errno.ELIBSCN                                     *ELIBSCN..errno.pyx*

   .lib section in a.out corrupted

errno.ELIBMAX                                     *ELIBMAX..errno.pyx*

   Attempting to link in too many shared libraries

errno.ELIBEXEC                                   *ELIBEXEC..errno.pyx*

   Cannot exec a shared library directly

errno.EILSEQ                                       *EILSEQ..errno.pyx*

   Illegal byte sequence

errno.ERESTART                                   *ERESTART..errno.pyx*

   Interrupted system call should be restarted

errno.ESTRPIPE                                   *ESTRPIPE..errno.pyx*

   Streams pipe error

errno.EUSERS                                       *EUSERS..errno.pyx*

   Too many users

errno.ENOTSOCK                                   *ENOTSOCK..errno.pyx*

   Socket operation on non-socket

errno.EDESTADDRREQ                           *EDESTADDRREQ..errno.pyx*

   Destination address required

errno.EMSGSIZE                                   *EMSGSIZE..errno.pyx*

   Message too long

errno.EPROTOTYPE                               *EPROTOTYPE..errno.pyx*

   Protocol wrong type for socket

errno.ENOPROTOOPT                             *ENOPROTOOPT..errno.pyx*

   Protocol not available

errno.EPROTONOSUPPORT                     *EPROTONOSUPPORT..errno.pyx*

   Protocol not supported

errno.ESOCKTNOSUPPORT                     *ESOCKTNOSUPPORT..errno.pyx*

   Socket type not supported

errno.EOPNOTSUPP                               *EOPNOTSUPP..errno.pyx*

   Operation not supported on transport endpoint

errno.ENOTSUP                                     *ENOTSUP..errno.pyx*

   Operation not supported

   New in version 3.2.

errno.EPFNOSUPPORT                           *EPFNOSUPPORT..errno.pyx*

   Protocol family not supported

errno.EAFNOSUPPORT                           *EAFNOSUPPORT..errno.pyx*

   Address family not supported by protocol

errno.EADDRINUSE                               *EADDRINUSE..errno.pyx*

   Address already in use

errno.EADDRNOTAVAIL                         *EADDRNOTAVAIL..errno.pyx*

   Cannot assign requested address

errno.ENETDOWN                                   *ENETDOWN..errno.pyx*

   Network is down

errno.ENETUNREACH                             *ENETUNREACH..errno.pyx*

   Network is unreachable

errno.ENETRESET                                 *ENETRESET..errno.pyx*

   Network dropped connection because of reset

errno.ECONNABORTED                           *ECONNABORTED..errno.pyx*

   Software caused connection abort. This error is mapped to the
   exception "ConnectionAbortedError".

errno.ECONNRESET                               *ECONNRESET..errno.pyx*

   Connection reset by peer. This error is mapped to the exception
   "ConnectionResetError".

errno.ENOBUFS                                     *ENOBUFS..errno.pyx*

   No buffer space available

errno.EISCONN                                     *EISCONN..errno.pyx*

   Transport endpoint is already connected

errno.ENOTCONN                                   *ENOTCONN..errno.pyx*

   Transport endpoint is not connected

errno.ESHUTDOWN                                 *ESHUTDOWN..errno.pyx*

   Cannot send after transport endpoint shutdown. This error is mapped
   to the exception "BrokenPipeError".

errno.ETOOMANYREFS                           *ETOOMANYREFS..errno.pyx*

   Too many references: cannot splice

errno.ETIMEDOUT                                 *ETIMEDOUT..errno.pyx*

   Connection timed out. This error is mapped to the exception
   "TimeoutError".

errno.ECONNREFUSED                           *ECONNREFUSED..errno.pyx*

   Connection refused. This error is mapped to the exception
   "ConnectionRefusedError".

errno.EHOSTDOWN                                 *EHOSTDOWN..errno.pyx*

   Host is down

errno.EHOSTUNREACH                           *EHOSTUNREACH..errno.pyx*

   No route to host

errno.EALREADY                                   *EALREADY..errno.pyx*

   Operation already in progress. This error is mapped to the
   exception "BlockingIOError".

errno.EINPROGRESS                             *EINPROGRESS..errno.pyx*

   Operation now in progress. This error is mapped to the exception
   "BlockingIOError".

errno.ESTALE                                       *ESTALE..errno.pyx*

   Stale NFS file handle

errno.EUCLEAN                                     *EUCLEAN..errno.pyx*

   Structure needs cleaning

errno.ENOTNAM                                     *ENOTNAM..errno.pyx*

   Not a XENIX named type file

errno.ENAVAIL                                     *ENAVAIL..errno.pyx*

   No XENIX semaphores available

errno.EISNAM                                       *EISNAM..errno.pyx*

   Is a named type file

errno.EREMOTEIO                                 *EREMOTEIO..errno.pyx*

   Remote I/O error

errno.EDQUOT                                       *EDQUOT..errno.pyx*

   Quota exceeded

errno.EQFULL                                       *EQFULL..errno.pyx*

   Interface output queue is full

   New in version 3.11.

errno.ENOTCAPABLE                             *ENOTCAPABLE..errno.pyx*

   Capabilities insufficient. This error is mapped to the exception
   "PermissionError".

   Availability: WASI, FreeBSD

   New in version 3.11.1.

errno.ECANCELED                                 *ECANCELED..errno.pyx*

   Operation canceled

   New in version 3.2.

errno.EOWNERDEAD                               *EOWNERDEAD..errno.pyx*

   Owner died

   New in version 3.2.

errno.ENOTRECOVERABLE                     *ENOTRECOVERABLE..errno.pyx*

   State not recoverable

   New in version 3.2.

vim:tw=78:ts=8:ft=help:norl: