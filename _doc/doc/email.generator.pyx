*email.generator.pyx*                         Last change: 2023 Sep 15

"email.generator": Generating MIME documents
********************************************

**Source code:** Lib/email/generator.py

======================================================================

One of the most common tasks is to generate the flat (serialized)
version of the email message represented by a message object
structure.  You will need to do this if you want to send your message
via "smtplib.SMTP.sendmail()", or print the message on the console.
Taking a message object structure and producing a serialized
representation is the job of the generator classes.

As with the "email.parser" module, you aren’t limited to the
functionality of the bundled generator; you could write one from
scratch yourself.  However the bundled generator knows how to generate
most email in a standards-compliant way, should handle MIME and non-
MIME email messages just fine, and is designed so that the bytes-
oriented parsing and generation operations are inverses, assuming the
same non-transforming "policy" is used for both.  That is, parsing the
serialized byte stream via the "BytesParser" class and then
regenerating the serialized byte stream using "BytesGenerator" should
produce output identical to the input [1].  (On the other hand, using
the generator on an "EmailMessage" constructed by program may result
in changes to the "EmailMessage" object as defaults are filled in.)

The "Generator" class can be used to flatten a message into a text (as
opposed to binary) serialized representation, but since Unicode cannot
represent binary data directly, the message is of necessity
transformed into something that contains only ASCII characters, using
the standard email RFC Content Transfer Encoding techniques for
encoding email messages for transport over channels that are not “8
bit clean”.

To accommodate reproducible processing of SMIME-signed messages
"Generator" disables header folding for message parts of type
"multipart/signed" and all subparts.

                                 *BytesGenerator..email.generator.pyx*
class email.generator.BytesGenerator(outfp, mangle_from_=None, maxheaderlen=None, *, policy=None)

   Return a "BytesGenerator" object that will write any message
   provided to the "flatten()" method, or any surrogateescape encoded
   text provided to the "write()" method, to the _file-like object_
   _outfp_. _outfp_ must support a "write" method that accepts binary
   data.

   If optional _mangle_from__ is "True", put a ">" character in front
   of any line in the body that starts with the exact string ""From
   "", that is "From" followed by a space at the beginning of a line.
   _mangle_from__ defaults to the value of the "mangle_from_" setting
   of the _policy_ (which is "True" for the "compat32" policy and
   "False" for all others). _mangle_from__ is intended for use when
   messages are stored in Unix mbox format (see "mailbox" and WHY THE
   CONTENT-LENGTH FORMAT IS BAD).

   If _maxheaderlen_ is not "None", refold any header lines that are
   longer than _maxheaderlen_, or if "0", do not rewrap any headers.
   If _manheaderlen_ is "None" (the default), wrap headers and other
   message lines according to the _policy_ settings.

   If _policy_ is specified, use that policy to control message
   generation.  If _policy_ is "None" (the default), use the policy
   associated with the "Message" or "EmailMessage" object passed to
   "flatten" to control the message generation.  See "email.policy"
   for details on what _policy_ controls.

   New in version 3.2.

   Changed in version 3.3: Added the _policy_ keyword.

   Changed in version 3.6: The default behavior of the _mangle_from__
   and _maxheaderlen_ parameters is to follow the policy.

                       *BytesGenerator.flatten()..email.generator.pyx*
   flatten(msg, unixfrom=False, linesep=None)

      Print the textual representation of the message object structure
      rooted at _msg_ to the output file specified when the
      "BytesGenerator" instance was created.

      If the "policy" option "cte_type" is "8bit" (the default), copy
      any headers in the original parsed message that have not been
      modified to the output with any bytes with the high bit set
      reproduced as in the original, and preserve the non-ASCII
      _Content-Transfer-Encoding_ of any body parts that have them. If
      "cte_type" is "7bit", convert the bytes with the high bit set as
      needed using an ASCII-compatible _Content-Transfer-Encoding_.
      That is, transform parts with non-ASCII _Content-Transfer-
      Encoding_ (_Content-Transfer-Encoding: 8bit_) to an ASCII
      compatible _Content-Transfer-Encoding_, and encode RFC-invalid
      non-ASCII bytes in headers using the MIME "unknown-8bit"
      character set, thus rendering them RFC-compliant.

      If _unixfrom_ is "True", print the envelope header delimiter
      used by the Unix mailbox format (see "mailbox") before the first
      of the **RFC 5322** headers of the root message object.  If the
      root object has no envelope header, craft a standard one.  The
      default is "False". Note that for subparts, no envelope header
      is ever printed.

      If _linesep_ is not "None", use it as the separator character
      between all the lines of the flattened message.  If _linesep_ is
      "None" (the default), use the value specified in the _policy_.

   clone(fp)                *BytesGenerator.clone()..email.generator.pyx*

      Return an independent clone of this "BytesGenerator" instance
      with the exact same option settings, and _fp_ as the new
      _outfp_.

   write(s)                 *BytesGenerator.write()..email.generator.pyx*

      Encode _s_ using the "ASCII" codec and the "surrogateescape"
      error handler, and pass it to the _write_ method of the _outfp_
      passed to the "BytesGenerator"’s constructor.

As a convenience, "EmailMessage" provides the methods "as_bytes()" and
"bytes(aMessage)" (a.k.a. "__bytes__()"), which simplify the
generation of a serialized binary representation of a message object.
For more detail, see "email.message".

Because strings cannot represent binary data, the "Generator" class
must convert any binary data in any message it flattens to an ASCII
compatible format, by converting them to an ASCII compatible _Content-
Transfer_Encoding_.  Using the terminology of the email RFCs, you can
think of this as "Generator" serializing to an I/O stream that is not
“8 bit clean”.  In other words, most applications will want to be
using "BytesGenerator", and not "Generator".

                                      *Generator..email.generator.pyx*
class email.generator.Generator(outfp, mangle_from_=None, maxheaderlen=None, *, policy=None)

   Return a "Generator" object that will write any message provided to
   the "flatten()" method, or any text provided to the "write()"
   method, to the _file-like object_ _outfp_.  _outfp_ must support a
   "write" method that accepts string data.

   If optional _mangle_from__ is "True", put a ">" character in front
   of any line in the body that starts with the exact string ""From
   "", that is "From" followed by a space at the beginning of a line.
   _mangle_from__ defaults to the value of the "mangle_from_" setting
   of the _policy_ (which is "True" for the "compat32" policy and
   "False" for all others). _mangle_from__ is intended for use when
   messages are stored in Unix mbox format (see "mailbox" and WHY THE
   CONTENT-LENGTH FORMAT IS BAD).

   If _maxheaderlen_ is not "None", refold any header lines that are
   longer than _maxheaderlen_, or if "0", do not rewrap any headers.
   If _manheaderlen_ is "None" (the default), wrap headers and other
   message lines according to the _policy_ settings.

   If _policy_ is specified, use that policy to control message
   generation.  If _policy_ is "None" (the default), use the policy
   associated with the "Message" or "EmailMessage" object passed to
   "flatten" to control the message generation.  See "email.policy"
   for details on what _policy_ controls.

   Changed in version 3.3: Added the _policy_ keyword.

   Changed in version 3.6: The default behavior of the _mangle_from__
   and _maxheaderlen_ parameters is to follow the policy.

                            *Generator.flatten()..email.generator.pyx*
   flatten(msg, unixfrom=False, linesep=None)

      Print the textual representation of the message object structure
      rooted at _msg_ to the output file specified when the
      "Generator" instance was created.

      If the "policy" option "cte_type" is "8bit", generate the
      message as if the option were set to "7bit". (This is required
      because strings cannot represent non-ASCII bytes.) Convert any
      bytes with the high bit set as needed using an ASCII-compatible
      _Content-Transfer-Encoding_.  That is, transform parts with non-
      ASCII _Content-Transfer-Encoding_ (_Content-Transfer-Encoding:
      8bit_) to an ASCII compatible _Content-Transfer-Encoding_, and
      encode RFC-invalid non-ASCII bytes in headers using the MIME
      "unknown-8bit" character set, thus rendering them RFC-compliant.

      If _unixfrom_ is "True", print the envelope header delimiter
      used by the Unix mailbox format (see "mailbox") before the first
      of the **RFC 5322** headers of the root message object.  If the
      root object has no envelope header, craft a standard one.  The
      default is "False". Note that for subparts, no envelope header
      is ever printed.

      If _linesep_ is not "None", use it as the separator character
      between all the lines of the flattened message.  If _linesep_ is
      "None" (the default), use the value specified in the _policy_.

      Changed in version 3.2: Added support for re-encoding "8bit"
      message bodies, and the _linesep_ argument.

   clone(fp)                     *Generator.clone()..email.generator.pyx*

      Return an independent clone of this "Generator" instance with
      the exact same options, and _fp_ as the new _outfp_.

   write(s)                      *Generator.write()..email.generator.pyx*

      Write _s_ to the _write_ method of the _outfp_ passed to the
      "Generator"’s constructor.  This provides just enough file-like
      API for "Generator" instances to be used in the "print()"
      function.

As a convenience, "EmailMessage" provides the methods "as_string()"
and "str(aMessage)" (a.k.a. "__str__()"), which simplify the
generation of a formatted string representation of a message object.
For more detail, see "email.message".

The "email.generator" module also provides a derived class,
"DecodedGenerator", which is like the "Generator" base class, except
that non-_text_ parts are not serialized, but are instead represented
in the output stream by a string derived from a template filled in
with information about the part.

                               *DecodedGenerator..email.generator.pyx*
class email.generator.DecodedGenerator(outfp, mangle_from_=None, maxheaderlen=None, fmt=None, *, policy=None)

   Act like "Generator", except that for any subpart of the message
   passed to "Generator.flatten()", if the subpart is of main type
   _text_, print the decoded payload of the subpart, and if the main
   type is not _text_, instead of printing it fill in the string _fmt_
   using information from the part and print the resulting filled-in
   string.

   To fill in _fmt_, execute "fmt % part_info", where "part_info" is a
   dictionary composed of the following keys and values:

   * "type" – Full MIME type of the non-_text_ part

   * "maintype" – Main MIME type of the non-_text_ part

   * "subtype" – Sub-MIME type of the non-_text_ part

   * "filename" – Filename of the non-_text_ part

   * "description" – Description associated with the non-_text_ part

   * "encoding" – Content transfer encoding of the non-_text_ part

   If _fmt_ is "None", use the following default _fmt_:

      “[Non-text (%(type)s) part of message omitted, filename
      %(filename)s]”

   Optional __mangle_from__ and _maxheaderlen_ are as with the
   "Generator" base class.

-[ Footnotes ]-

[1] This statement assumes that you use the appropriate setting for
    "unixfrom", and that there are no "email.policy" settings calling
    for automatic adjustments (for example, "refold_source" must be
    "none", which is _not_ the default).  It is also not 100% true,
    since if the message does not conform to the RFC standards
    occasionally information about the exact original text is lost
    during parsing error recovery.  It is a goal to fix these latter
    edge cases when possible.

vim:tw=78:ts=8:ft=help:norl: