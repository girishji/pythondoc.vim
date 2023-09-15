*stat.pyx*                                    Last change: 2023 Sep 15

"stat" — Interpreting "stat()" results
**************************************

**Source code:** Lib/stat.py

======================================================================

The "stat" module defines constants and functions for interpreting the
results of "os.stat()", "os.fstat()" and "os.lstat()" (if they exist).
For complete details about the "stat()", "fstat()" and "lstat()"
calls, consult the documentation for your system.

Changed in version 3.4: The stat module is backed by a C
implementation.

The "stat" module defines the following functions to test for specific
file types:

stat.S_ISDIR(mode)                               *S_ISDIR()..stat.pyx*

   Return non-zero if the mode is from a directory.

stat.S_ISCHR(mode)                               *S_ISCHR()..stat.pyx*

   Return non-zero if the mode is from a character special device
   file.

stat.S_ISBLK(mode)                               *S_ISBLK()..stat.pyx*

   Return non-zero if the mode is from a block special device file.

stat.S_ISREG(mode)                               *S_ISREG()..stat.pyx*

   Return non-zero if the mode is from a regular file.

stat.S_ISFIFO(mode)                             *S_ISFIFO()..stat.pyx*

   Return non-zero if the mode is from a FIFO (named pipe).

stat.S_ISLNK(mode)                               *S_ISLNK()..stat.pyx*

   Return non-zero if the mode is from a symbolic link.

stat.S_ISSOCK(mode)                             *S_ISSOCK()..stat.pyx*

   Return non-zero if the mode is from a socket.

stat.S_ISDOOR(mode)                             *S_ISDOOR()..stat.pyx*

   Return non-zero if the mode is from a door.

   New in version 3.4.

stat.S_ISPORT(mode)                             *S_ISPORT()..stat.pyx*

   Return non-zero if the mode is from an event port.

   New in version 3.4.

stat.S_ISWHT(mode)                               *S_ISWHT()..stat.pyx*

   Return non-zero if the mode is from a whiteout.

   New in version 3.4.

Two additional functions are defined for more general manipulation of
the file’s mode:

stat.S_IMODE(mode)                               *S_IMODE()..stat.pyx*

   Return the portion of the file’s mode that can be set by
   "os.chmod()"—that is, the file’s permission bits, plus the sticky
   bit, set-group-id, and set-user-id bits (on systems that support
   them).

stat.S_IFMT(mode)                                 *S_IFMT()..stat.pyx*

   Return the portion of the file’s mode that describes the file type
   (used by the "S_IS*()" functions above).

Normally, you would use the "os.path.is*()" functions for testing the
type of a file; the functions here are useful when you are doing
multiple tests of the same file and wish to avoid the overhead of the
"stat()" system call for each test.  These are also useful when
checking for information about a file that isn’t handled by "os.path",
like the tests for block and character devices.

Example:
>
   import os, sys
   from stat import *

   def walktree(top, callback):
       '''recursively descend the directory tree rooted at top,
          calling the callback function for each regular file'''

       for f in os.listdir(top):
           pathname = os.path.join(top, f)
           mode = os.lstat(pathname).st_mode
           if S_ISDIR(mode):
               # It's a directory, recurse into it
               walktree(pathname, callback)
           elif S_ISREG(mode):
               # It's a file, call the callback function
               callback(pathname)
           else:
               # Unknown file type, print a message
               print('Skipping %s' % pathname)

   def visitfile(file):
       print('visiting', file)

   if __name__ == '__main__':
       walktree(sys.argv[1], visitfile)
<
An additional utility function is provided to convert a file’s mode in
a human readable string:

stat.filemode(mode)                             *filemode()..stat.pyx*

   Convert a file’s mode to a string of the form ‘-rwxrwxrwx’.

   New in version 3.3.

   Changed in version 3.4: The function supports "S_IFDOOR",
   "S_IFPORT" and "S_IFWHT".

All the variables below are simply symbolic indexes into the 10-tuple
returned by "os.stat()", "os.fstat()" or "os.lstat()".

stat.ST_MODE                                       *ST_MODE..stat.pyx*

   Inode protection mode.

stat.ST_INO                                         *ST_INO..stat.pyx*

   Inode number.

stat.ST_DEV                                         *ST_DEV..stat.pyx*

   Device inode resides on.

stat.ST_NLINK                                     *ST_NLINK..stat.pyx*

   Number of links to the inode.

stat.ST_UID                                         *ST_UID..stat.pyx*

   User id of the owner.

stat.ST_GID                                         *ST_GID..stat.pyx*

   Group id of the owner.

stat.ST_SIZE                                       *ST_SIZE..stat.pyx*

   Size in bytes of a plain file; amount of data waiting on some
   special files.

stat.ST_ATIME                                     *ST_ATIME..stat.pyx*

   Time of last access.

stat.ST_MTIME                                     *ST_MTIME..stat.pyx*

   Time of last modification.

stat.ST_CTIME                                     *ST_CTIME..stat.pyx*

   The “ctime” as reported by the operating system.  On some systems
   (like Unix) is the time of the last metadata change, and, on others
   (like Windows), is the creation time (see platform documentation
   for details).

The interpretation of “file size” changes according to the file type.
For plain files this is the size of the file in bytes.  For FIFOs and
sockets under most flavors of Unix (including Linux in particular),
the “size” is the number of bytes waiting to be read at the time of
the call to "os.stat()", "os.fstat()", or "os.lstat()"; this can
sometimes be useful, especially for polling one of these special files
after a non-blocking open.  The meaning of the size field for other
character and block devices varies more, depending on the
implementation of the underlying system call.

The variables below define the flags used in the "ST_MODE" field.

Use of the functions above is more portable than use of the first set
of flags:

stat.S_IFSOCK                                     *S_IFSOCK..stat.pyx*

   Socket.

stat.S_IFLNK                                       *S_IFLNK..stat.pyx*

   Symbolic link.

stat.S_IFREG                                       *S_IFREG..stat.pyx*

   Regular file.

stat.S_IFBLK                                       *S_IFBLK..stat.pyx*

   Block device.

stat.S_IFDIR                                       *S_IFDIR..stat.pyx*

   Directory.

stat.S_IFCHR                                       *S_IFCHR..stat.pyx*

   Character device.

stat.S_IFIFO                                       *S_IFIFO..stat.pyx*

   FIFO.

stat.S_IFDOOR                                     *S_IFDOOR..stat.pyx*

   Door.

   New in version 3.4.

stat.S_IFPORT                                     *S_IFPORT..stat.pyx*

   Event port.

   New in version 3.4.

stat.S_IFWHT                                       *S_IFWHT..stat.pyx*

   Whiteout.

   New in version 3.4.

Note:

  "S_IFDOOR", "S_IFPORT" or "S_IFWHT" are defined as 0 when the
  platform does not have support for the file types.

The following flags can also be used in the _mode_ argument of
"os.chmod()":

stat.S_ISUID                                       *S_ISUID..stat.pyx*

   Set UID bit.

stat.S_ISGID                                       *S_ISGID..stat.pyx*

   Set-group-ID bit.  This bit has several special uses.  For a
   directory it indicates that BSD semantics is to be used for that
   directory: files created there inherit their group ID from the
   directory, not from the effective group ID of the creating process,
   and directories created there will also get the "S_ISGID" bit set.
   For a file that does not have the group execution bit ("S_IXGRP")
   set, the set-group-ID bit indicates mandatory file/record locking
   (see also "S_ENFMT").

stat.S_ISVTX                                       *S_ISVTX..stat.pyx*

   Sticky bit.  When this bit is set on a directory it means that a
   file in that directory can be renamed or deleted only by the owner
   of the file, by the owner of the directory, or by a privileged
   process.

stat.S_IRWXU                                       *S_IRWXU..stat.pyx*

   Mask for file owner permissions.

stat.S_IRUSR                                       *S_IRUSR..stat.pyx*

   Owner has read permission.

stat.S_IWUSR                                       *S_IWUSR..stat.pyx*

   Owner has write permission.

stat.S_IXUSR                                       *S_IXUSR..stat.pyx*

   Owner has execute permission.

stat.S_IRWXG                                       *S_IRWXG..stat.pyx*

   Mask for group permissions.

stat.S_IRGRP                                       *S_IRGRP..stat.pyx*

   Group has read permission.

stat.S_IWGRP                                       *S_IWGRP..stat.pyx*

   Group has write permission.

stat.S_IXGRP                                       *S_IXGRP..stat.pyx*

   Group has execute permission.

stat.S_IRWXO                                       *S_IRWXO..stat.pyx*

   Mask for permissions for others (not in group).

stat.S_IROTH                                       *S_IROTH..stat.pyx*

   Others have read permission.

stat.S_IWOTH                                       *S_IWOTH..stat.pyx*

   Others have write permission.

stat.S_IXOTH                                       *S_IXOTH..stat.pyx*

   Others have execute permission.

stat.S_ENFMT                                       *S_ENFMT..stat.pyx*

   System V file locking enforcement.  This flag is shared with
   "S_ISGID": file/record locking is enforced on files that do not
   have the group execution bit ("S_IXGRP") set.

stat.S_IREAD                                       *S_IREAD..stat.pyx*

   Unix V7 synonym for "S_IRUSR".

stat.S_IWRITE                                     *S_IWRITE..stat.pyx*

   Unix V7 synonym for "S_IWUSR".

stat.S_IEXEC                                       *S_IEXEC..stat.pyx*

   Unix V7 synonym for "S_IXUSR".

The following flags can be used in the _flags_ argument of
"os.chflags()":

stat.UF_NODUMP                                   *UF_NODUMP..stat.pyx*

   Do not dump the file.

stat.UF_IMMUTABLE                             *UF_IMMUTABLE..stat.pyx*

   The file may not be changed.

stat.UF_APPEND                                   *UF_APPEND..stat.pyx*

   The file may only be appended to.

stat.UF_OPAQUE                                   *UF_OPAQUE..stat.pyx*

   The directory is opaque when viewed through a union stack.

stat.UF_NOUNLINK                               *UF_NOUNLINK..stat.pyx*

   The file may not be renamed or deleted.

stat.UF_COMPRESSED                           *UF_COMPRESSED..stat.pyx*

   The file is stored compressed (macOS 10.6+).

stat.UF_HIDDEN                                   *UF_HIDDEN..stat.pyx*

   The file should not be displayed in a GUI (macOS 10.5+).

stat.SF_ARCHIVED                               *SF_ARCHIVED..stat.pyx*

   The file may be archived.

stat.SF_IMMUTABLE                             *SF_IMMUTABLE..stat.pyx*

   The file may not be changed.

stat.SF_APPEND                                   *SF_APPEND..stat.pyx*

   The file may only be appended to.

stat.SF_NOUNLINK                               *SF_NOUNLINK..stat.pyx*

   The file may not be renamed or deleted.

stat.SF_SNAPSHOT                               *SF_SNAPSHOT..stat.pyx*

   The file is a snapshot file.

See the *BSD or macOS systems man page _chflags(2)_ for more
information.

On Windows, the following file attribute constants are available for
use when testing bits in the "st_file_attributes" member returned by
"os.stat()". See the Windows API documentation for more detail on the
meaning of these constants.

stat.FILE_ATTRIBUTE_ARCHIVE         *FILE_ATTRIBUTE_ARCHIVE..stat.pyx*
stat.FILE_ATTRIBUTE_COMPRESSED   *FILE_ATTRIBUTE_COMPRESSED..stat.pyx*
stat.FILE_ATTRIBUTE_DEVICE           *FILE_ATTRIBUTE_DEVICE..stat.pyx*
stat.FILE_ATTRIBUTE_DIRECTORY     *FILE_ATTRIBUTE_DIRECTORY..stat.pyx*
stat.FILE_ATTRIBUTE_ENCRYPTED     *FILE_ATTRIBUTE_ENCRYPTED..stat.pyx*
stat.FILE_ATTRIBUTE_HIDDEN           *FILE_ATTRIBUTE_HIDDEN..stat.pyx*

                           *FILE_ATTRIBUTE_INTEGRITY_STREAM..stat.pyx*
stat.FILE_ATTRIBUTE_INTEGRITY_STREAM
stat.FILE_ATTRIBUTE_NORMAL           *FILE_ATTRIBUTE_NORMAL..stat.pyx*

                        *FILE_ATTRIBUTE_NOT_CONTENT_INDEXED..stat.pyx*
stat.FILE_ATTRIBUTE_NOT_CONTENT_INDEXED

                              *FILE_ATTRIBUTE_NO_SCRUB_DATA..stat.pyx*
stat.FILE_ATTRIBUTE_NO_SCRUB_DATA
stat.FILE_ATTRIBUTE_OFFLINE         *FILE_ATTRIBUTE_OFFLINE..stat.pyx*
stat.FILE_ATTRIBUTE_READONLY       *FILE_ATTRIBUTE_READONLY..stat.pyx*

                              *FILE_ATTRIBUTE_REPARSE_POINT..stat.pyx*
stat.FILE_ATTRIBUTE_REPARSE_POINT

                                *FILE_ATTRIBUTE_SPARSE_FILE..stat.pyx*
stat.FILE_ATTRIBUTE_SPARSE_FILE
stat.FILE_ATTRIBUTE_SYSTEM           *FILE_ATTRIBUTE_SYSTEM..stat.pyx*
stat.FILE_ATTRIBUTE_TEMPORARY     *FILE_ATTRIBUTE_TEMPORARY..stat.pyx*
stat.FILE_ATTRIBUTE_VIRTUAL         *FILE_ATTRIBUTE_VIRTUAL..stat.pyx*

   New in version 3.5.

On Windows, the following constants are available for comparing
against the "st_reparse_tag" member returned by "os.lstat()". These
are well-known constants, but are not an exhaustive list.

stat.IO_REPARSE_TAG_SYMLINK         *IO_REPARSE_TAG_SYMLINK..stat.pyx*

                                *IO_REPARSE_TAG_MOUNT_POINT..stat.pyx*
stat.IO_REPARSE_TAG_MOUNT_POINT

                                *IO_REPARSE_TAG_APPEXECLINK..stat.pyx*
stat.IO_REPARSE_TAG_APPEXECLINK

   New in version 3.8.

vim:tw=78:ts=8:ft=help:norl: