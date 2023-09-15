*email.mime.pyx*                              Last change: 2023 Sep 15

"email.mime": Creating email and MIME objects from scratch
**********************************************************

**Source code:** Lib/email/mime/

======================================================================

This module is part of the legacy ("Compat32") email API.  Its
functionality is partially replaced by the "contentmanager" in the new
API, but in certain applications these classes may still be useful,
even in non-legacy code.

Ordinarily, you get a message object structure by passing a file or
some text to a parser, which parses the text and returns the root
message object.  However you can also build a complete message
structure from scratch, or even individual "Message" objects by hand.
In fact, you can also take an existing structure and add new "Message"
objects, move them around, etc.  This makes a very convenient
interface for slicing-and-dicing MIME messages.

You can create a new object structure by creating "Message" instances,
adding attachments and all the appropriate headers manually.  For MIME
messages though, the "email" package provides some convenient
subclasses to make things easier.

Here are the classes:

                                            *MIMEBase..email.mime.pyx*
class email.mime.base.MIMEBase(_maintype, _subtype, *, policy=compat32, **_params)

   Module: "email.mime.base"

   This is the base class for all the MIME-specific subclasses of
   "Message".  Ordinarily you won’t create instances specifically of
   "MIMEBase", although you could.  "MIMEBase" is provided primarily
   as a convenient base class for more specific MIME-aware subclasses.

   __maintype_ is the _Content-Type_ major type (e.g. _text_ or
   _image_), and __subtype_ is the _Content-Type_ minor type  (e.g.
   _plain_ or _gif_).  __params_ is a parameter key/value dictionary
   and is passed directly to "Message.add_header".

   If _policy_ is specified, (defaults to the "compat32" policy) it
   will be passed to "Message".

   The "MIMEBase" class always adds a _Content-Type_ header (based on
   __maintype_, __subtype_, and __params_), and a _MIME-Version_
   header (always set to "1.0").

   Changed in version 3.6: Added _policy_ keyword-only parameter.

                                    *MIMENonMultipart..email.mime.pyx*
class email.mime.nonmultipart.MIMENonMultipart

   Module: "email.mime.nonmultipart"

   A subclass of "MIMEBase", this is an intermediate base class for
   MIME messages that are not _multipart_.  The primary purpose of
   this class is to prevent the use of the "attach()" method, which
   only makes sense for _multipart_ messages.  If "attach()" is
   called, a "MultipartConversionError" exception is raised.

                                       *MIMEMultipart..email.mime.pyx*
class email.mime.multipart.MIMEMultipart(_subtype='mixed', boundary=None, _subparts=None, *, policy=compat32, **_params)

   Module: "email.mime.multipart"

   A subclass of "MIMEBase", this is an intermediate base class for
   MIME messages that are _multipart_.  Optional __subtype_ defaults
   to _mixed_, but can be used to specify the subtype of the message.
   A _Content-Type_ header of _multipart/_subtype_ will be added to
   the message object.  A _MIME-Version_ header will also be added.

   Optional _boundary_ is the multipart boundary string.  When "None"
   (the default), the boundary is calculated when needed (for example,
   when the message is serialized).

   __subparts_ is a sequence of initial subparts for the payload.  It
   must be possible to convert this sequence to a list.  You can
   always attach new subparts to the message by using the
   "Message.attach" method.

   Optional _policy_ argument defaults to "compat32".

   Additional parameters for the _Content-Type_ header are taken from
   the keyword arguments, or passed into the __params_ argument, which
   is a keyword dictionary.

   Changed in version 3.6: Added _policy_ keyword-only parameter.

                                     *MIMEApplication..email.mime.pyx*
class email.mime.application.MIMEApplication(_data, _subtype='octet-stream', _encoder=email.encoders.encode_base64, *, policy=compat32, **_params)

   Module: "email.mime.application"

   A subclass of "MIMENonMultipart", the "MIMEApplication" class is
   used to represent MIME message objects of major type _application_.
   __data_ contains the bytes for the raw application data.  Optional
   __subtype_ specifies the MIME subtype and defaults to _octet-
   stream_.

   Optional __encoder_ is a callable (i.e. function) which will
   perform the actual encoding of the data for transport.  This
   callable takes one argument, which is the "MIMEApplication"
   instance. It should use "get_payload()" and "set_payload()" to
   change the payload to encoded form.  It should also add any
   _Content-Transfer-Encoding_ or other headers to the message object
   as necessary.  The default encoding is base64.  See the
   "email.encoders" module for a list of the built-in encoders.

   Optional _policy_ argument defaults to "compat32".

   __params_ are passed straight through to the base class
   constructor.

   Changed in version 3.6: Added _policy_ keyword-only parameter.

                                           *MIMEAudio..email.mime.pyx*
class email.mime.audio.MIMEAudio(_audiodata, _subtype=None, _encoder=email.encoders.encode_base64, *, policy=compat32, **_params)

   Module: "email.mime.audio"

   A subclass of "MIMENonMultipart", the "MIMEAudio" class is used to
   create MIME message objects of major type _audio_. __audiodata_
   contains the bytes for the raw audio data.  If this data can be
   decoded as au, wav, aiff, or aifc, then the subtype will be
   automatically included in the _Content-Type_ header. Otherwise you
   can explicitly specify the audio subtype via the __subtype_
   argument.  If the minor type could not be guessed and __subtype_
   was not given, then "TypeError" is raised.

   Optional __encoder_ is a callable (i.e. function) which will
   perform the actual encoding of the audio data for transport.  This
   callable takes one argument, which is the "MIMEAudio" instance. It
   should use "get_payload()" and "set_payload()" to change the
   payload to encoded form.  It should also add any _Content-Transfer-
   Encoding_ or other headers to the message object as necessary.  The
   default encoding is base64.  See the "email.encoders" module for a
   list of the built-in encoders.

   Optional _policy_ argument defaults to "compat32".

   __params_ are passed straight through to the base class
   constructor.

   Changed in version 3.6: Added _policy_ keyword-only parameter.

                                           *MIMEImage..email.mime.pyx*
class email.mime.image.MIMEImage(_imagedata, _subtype=None, _encoder=email.encoders.encode_base64, *, policy=compat32, **_params)

   Module: "email.mime.image"

   A subclass of "MIMENonMultipart", the "MIMEImage" class is used to
   create MIME message objects of major type _image_. __imagedata_
   contains the bytes for the raw image data.  If this data type can
   be detected (jpeg, png, gif, tiff, rgb, pbm, pgm, ppm, rast, xbm,
   bmp, webp, and exr attempted), then the subtype will be
   automatically included in the _Content-Type_ header. Otherwise you
   can explicitly specify the image subtype via the __subtype_
   argument. If the minor type could not be guessed and __subtype_ was
   not given, then "TypeError" is raised.

   Optional __encoder_ is a callable (i.e. function) which will
   perform the actual encoding of the image data for transport.  This
   callable takes one argument, which is the "MIMEImage" instance. It
   should use "get_payload()" and "set_payload()" to change the
   payload to encoded form.  It should also add any _Content-Transfer-
   Encoding_ or other headers to the message object as necessary.  The
   default encoding is base64.  See the "email.encoders" module for a
   list of the built-in encoders.

   Optional _policy_ argument defaults to "compat32".

   __params_ are passed straight through to the "MIMEBase"
   constructor.

   Changed in version 3.6: Added _policy_ keyword-only parameter.

                                         *MIMEMessage..email.mime.pyx*
class email.mime.message.MIMEMessage(_msg, _subtype='rfc822', *, policy=compat32)

   Module: "email.mime.message"

   A subclass of "MIMENonMultipart", the "MIMEMessage" class is used
   to create MIME objects of main type _message_. __msg_ is used as
   the payload, and must be an instance of class "Message" (or a
   subclass thereof), otherwise a "TypeError" is raised.

   Optional __subtype_ sets the subtype of the message; it defaults to
   _rfc822_.

   Optional _policy_ argument defaults to "compat32".

   Changed in version 3.6: Added _policy_ keyword-only parameter.

                                            *MIMEText..email.mime.pyx*
class email.mime.text.MIMEText(_text, _subtype='plain', _charset=None, *, policy=compat32)

   Module: "email.mime.text"

   A subclass of "MIMENonMultipart", the "MIMEText" class is used to
   create MIME objects of major type _text_. __text_ is the string for
   the payload.  __subtype_ is the minor type and defaults to _plain_.
   __charset_ is the character set of the text and is passed as an
   argument to the "MIMENonMultipart" constructor; it defaults to "us-
   ascii" if the string contains only "ascii" code points, and "utf-8"
   otherwise.  The __charset_ parameter accepts either a string or a
   "Charset" instance.

   Unless the __charset_ argument is explicitly set to "None", the
   MIMEText object created will have both a _Content-Type_ header with
   a "charset" parameter, and a _Content-Transfer-Encoding_ header.
   This means that a subsequent "set_payload" call will not result in
   an encoded payload, even if a charset is passed in the
   "set_payload" command.  You can “reset” this behavior by deleting
   the "Content-Transfer-Encoding" header, after which a "set_payload"
   call will automatically encode the new payload (and add a new
   _Content-Transfer-Encoding_ header).

   Optional _policy_ argument defaults to "compat32".

   Changed in version 3.5: __charset_ also accepts "Charset"
   instances.

   Changed in version 3.6: Added _policy_ keyword-only parameter.

vim:tw=78:ts=8:ft=help:norl: