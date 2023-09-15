*email.iterators.pyx*                         Last change: 2023 Sep 15

"email.iterators": Iterators
****************************

**Source code:** Lib/email/iterators.py

======================================================================

Iterating over a message object tree is fairly easy with the
"Message.walk" method.  The "email.iterators" module provides some
useful higher level iterations over message object trees.

                           *body_line_iterator()..email.iterators.pyx*
email.iterators.body_line_iterator(msg, decode=False)

   This iterates over all the payloads in all the subparts of _msg_,
   returning the string payloads line-by-line.  It skips over all the
   subpart headers, and it skips over any subpart with a payload that
   isn’t a Python string.  This is somewhat equivalent to reading the
   flat text representation of the message from a file using
   "readline()", skipping over all the intervening headers.

   Optional _decode_ is passed through to "Message.get_payload".

                       *typed_subpart_iterator()..email.iterators.pyx*
email.iterators.typed_subpart_iterator(msg, maintype='text', subtype=None)

   This iterates over all the subparts of _msg_, returning only those
   subparts that match the MIME type specified by _maintype_ and
   _subtype_.

   Note that _subtype_ is optional; if omitted, then subpart MIME type
   matching is done only with the main type.  _maintype_ is optional
   too; it defaults to _text_.

   Thus, by default "typed_subpart_iterator()" returns each subpart
   that has a MIME type of _text/*_.

The following function has been added as a useful debugging tool.  It
should _not_ be considered part of the supported public interface for
the package.

                                   *_structure()..email.iterators.pyx*
email.iterators._structure(msg, fp=None, level=0, include_default=False)

   Prints an indented representation of the content types of the
   message object structure.  For example:
>
      >>> msg = email.message_from_file(somefile)
      >>> _structure(msg)
      multipart/mixed
          text/plain
          text/plain
          multipart/digest
              message/rfc822
                  text/plain
              message/rfc822
                  text/plain
              message/rfc822
                  text/plain
              message/rfc822
                  text/plain
              message/rfc822
                  text/plain
          text/plain
<
   Optional _fp_ is a file-like object to print the output to.  It
   must be suitable for Python’s "print()" function.  _level_ is used
   internally. _include_default_, if true, prints the default type as
   well.

vim:tw=78:ts=8:ft=help:norl: