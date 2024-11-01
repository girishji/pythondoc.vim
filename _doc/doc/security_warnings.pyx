*security_warnings.pyx*                       Last change: 2023 Sep 15

Security Considerations
***********************

The following modules have specific security considerations:

* "base64": base64 security considerations in **RFC 4648**

* "hashlib": all constructors take a “usedforsecurity” keyword-only
  argument disabling known insecure and blocked algorithms

* "http.server" is not suitable for production use, only implementing
  basic security checks. See the security considerations.

* "logging": Logging configuration uses eval()

* "multiprocessing": Connection.recv() uses pickle

* "pickle": Restricting globals in pickle

* "random" shouldn’t be used for security purposes, use "secrets"
  instead

* "shelve": shelve is based on pickle and thus unsuitable for dealing
  with untrusted sources

* "ssl": SSL/TLS security considerations

* "subprocess": Subprocess security considerations

* "tempfile": mktemp is deprecated due to vulnerability to race
  conditions

* "xml": XML vulnerabilities

* "zipfile": maliciously prepared .zip files can cause disk volume
  exhaustion

The "-I" command line option can be used to run Python in isolated
mode. When it cannot be used, the "-P" option or the "PYTHONSAFEPATH"
environment variable can be used to not prepend a potentially unsafe
path to "sys.path" such as the current directory, the script’s
directory or an empty string.

vim:tw=78:ts=8:ft=help:norl: