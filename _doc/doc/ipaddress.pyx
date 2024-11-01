*ipaddress.pyx*                               Last change: 2023 Sep 15

"ipaddress" — IPv4/IPv6 manipulation library
********************************************

**Source code:** Lib/ipaddress.py

======================================================================

"ipaddress" provides the capabilities to create, manipulate and
operate on IPv4 and IPv6 addresses and networks.

The functions and classes in this module make it straightforward to
handle various tasks related to IP addresses, including checking
whether or not two hosts are on the same subnet, iterating over all
hosts in a particular subnet, checking whether or not a string
represents a valid IP address or network definition, and so on.

This is the full module API reference—for an overview and
introduction, see An introduction to the ipaddress module.

New in version 3.3.


Convenience factory functions
=============================

The "ipaddress" module provides factory functions to conveniently
create IP addresses, networks and interfaces:

ipaddress.ip_address(address)            *ip_address()..ipaddress.pyx*

   Return an "IPv4Address" or "IPv6Address" object depending on the IP
   address passed as argument.  Either IPv4 or IPv6 addresses may be
   supplied; integers less than "2**32" will be considered to be IPv4
   by default. A "ValueError" is raised if _address_ does not
   represent a valid IPv4 or IPv6 address.

   >>> ipaddress.ip_address('192.168.0.1')
   IPv4Address('192.168.0.1')
   >>> ipaddress.ip_address('2001:db8::')
   IPv6Address('2001:db8::')

                                         *ip_network()..ipaddress.pyx*
ipaddress.ip_network(address, strict=True)

   Return an "IPv4Network" or "IPv6Network" object depending on the IP
   address passed as argument.  _address_ is a string or integer
   representing the IP network.  Either IPv4 or IPv6 networks may be
   supplied; integers less than "2**32" will be considered to be IPv4
   by default.  _strict_ is passed to "IPv4Network" or "IPv6Network"
   constructor.  A "ValueError" is raised if _address_ does not
   represent a valid IPv4 or IPv6 address, or if the network has host
   bits set.

   >>> ipaddress.ip_network('192.168.0.0/28')
   IPv4Network('192.168.0.0/28')

ipaddress.ip_interface(address)        *ip_interface()..ipaddress.pyx*

   Return an "IPv4Interface" or "IPv6Interface" object depending on
   the IP address passed as argument.  _address_ is a string or
   integer representing the IP address.  Either IPv4 or IPv6 addresses
   may be supplied; integers less than "2**32" will be considered to
   be IPv4 by default.  A "ValueError" is raised if _address_ does not
   represent a valid IPv4 or IPv6 address.

One downside of these convenience functions is that the need to handle
both IPv4 and IPv6 formats means that error messages provide minimal
information on the precise error, as the functions don’t know whether
the IPv4 or IPv6 format was intended. More detailed error reporting
can be obtained by calling the appropriate version specific class
constructors directly.


IP Addresses
============


Address objects
---------------

The "IPv4Address" and "IPv6Address" objects share a lot of common
attributes.  Some attributes that are only meaningful for IPv6
addresses are also implemented by "IPv4Address" objects, in order to
make it easier to write code that handles both IP versions correctly.
Address objects are _hashable_, so they can be used as keys in
dictionaries.

class ipaddress.IPv4Address(address)      *IPv4Address..ipaddress.pyx*

   Construct an IPv4 address.  An "AddressValueError" is raised if
   _address_ is not a valid IPv4 address.

   The following constitutes a valid IPv4 address:

   1. A string in decimal-dot notation, consisting of four decimal
      integers in the inclusive range 0–255, separated by dots (e.g.
      "192.168.0.1"). Each integer represents an octet (byte) in the
      address. Leading zeroes are not tolerated to prevent confusion
      with octal notation.

   2. An integer that fits into 32 bits.

   3. An integer packed into a "bytes" object of length 4 (most
      significant octet first).

   >>> ipaddress.IPv4Address('192.168.0.1')
   IPv4Address('192.168.0.1')
   >>> ipaddress.IPv4Address(3232235521)
   IPv4Address('192.168.0.1')
   >>> ipaddress.IPv4Address(b'\xC0\xA8\x00\x01')
   IPv4Address('192.168.0.1')

   Changed in version 3.8: Leading zeros are tolerated, even in
   ambiguous cases that look like octal notation.

   Changed in version 3.10: Leading zeros are no longer tolerated and
   are treated as an error. IPv4 address strings are now parsed as
   strict as glibc "inet_pton()".

   Changed in version 3.9.5: The above change was also included in
   Python 3.9 starting with version 3.9.5.

   Changed in version 3.8.12: The above change was also included in
   Python 3.8 starting with version 3.8.12.

   version                           *IPv4Address.version..ipaddress.pyx*

      The appropriate version number: "4" for IPv4, "6" for IPv6.

   max_prefixlen               *IPv4Address.max_prefixlen..ipaddress.pyx*

      The total number of bits in the address representation for this
      version: "32" for IPv4, "128" for IPv6.

      The prefix defines the number of leading bits in an  address
      that are compared to determine whether or not an address is part
      of a network.

   compressed                     *IPv4Address.compressed..ipaddress.pyx*

   exploded                         *IPv4Address.exploded..ipaddress.pyx*

      The string representation in dotted decimal notation. Leading
      zeroes are never included in the representation.

      As IPv4 does not define a shorthand notation for addresses with
      octets set to zero, these two attributes are always the same as
      "str(addr)" for IPv4 addresses. Exposing these attributes makes
      it easier to write display code that can handle both IPv4 and
      IPv6 addresses.

   packed                             *IPv4Address.packed..ipaddress.pyx*

      The binary representation of this address - a "bytes" object of
      the appropriate length (most significant octet first). This is 4
      bytes for IPv4 and 16 bytes for IPv6.

   reverse_pointer           *IPv4Address.reverse_pointer..ipaddress.pyx*

      The name of the reverse DNS PTR record for the IP address, e.g.:
>
         >>> ipaddress.ip_address("127.0.0.1").reverse_pointer
         '1.0.0.127.in-addr.arpa'
         >>> ipaddress.ip_address("2001:db8::1").reverse_pointer
         '1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa'
<
      This is the name that could be used for performing a PTR lookup,
      not the resolved hostname itself.

      New in version 3.5.

   is_multicast                 *IPv4Address.is_multicast..ipaddress.pyx*

      "True" if the address is reserved for multicast use.  See **RFC
      3171** (for IPv4) or **RFC 2373** (for IPv6).

   is_private                     *IPv4Address.is_private..ipaddress.pyx*

      "True" if the address is allocated for private networks.  See
      iana-ipv4-special-registry (for IPv4) or iana-ipv6-special-
      registry (for IPv6).

   is_global                       *IPv4Address.is_global..ipaddress.pyx*

      "True" if the address is allocated for public networks.  See
      iana-ipv4-special-registry (for IPv4) or iana-ipv6-special-
      registry (for IPv6).

      New in version 3.4.

   is_unspecified             *IPv4Address.is_unspecified..ipaddress.pyx*

      "True" if the address is unspecified.  See **RFC 5735** (for
      IPv4) or **RFC 2373** (for IPv6).

   is_reserved                   *IPv4Address.is_reserved..ipaddress.pyx*

      "True" if the address is otherwise IETF reserved.

   is_loopback                   *IPv4Address.is_loopback..ipaddress.pyx*

      "True" if this is a loopback address.  See **RFC 3330** (for
      IPv4) or **RFC 2373** (for IPv6).

   is_link_local               *IPv4Address.is_link_local..ipaddress.pyx*

      "True" if the address is reserved for link-local usage.  See
      **RFC 3927**.

                             *IPv4Address.__format__()..ipaddress.pyx*
IPv4Address.__format__(fmt)

   Returns a string representation of the IP address, controlled by an
   explicit format string. _fmt_ can be one of the following: "'s'",
   the default option, equivalent to "str()", "'b'" for a zero-padded
   binary string, "'X'" or "'x'" for an uppercase or lowercase
   hexadecimal representation, or "'n'", which is equivalent to "'b'"
   for IPv4 addresses and "'x'" for IPv6. For binary and hexadecimal
   representations, the form specifier "'#'" and the grouping option
   "'_'" are available. "__format__" is used by "format", "str.format"
   and f-strings.

   >>> format(ipaddress.IPv4Address('192.168.0.1'))
   '192.168.0.1'
   >>> '{:#b}'.format(ipaddress.IPv4Address('192.168.0.1'))
   '0b11000000101010000000000000000001'
   >>> f'{ipaddress.IPv6Address("2001:db8::1000"):s}'
   '2001:db8::1000'
   >>> format(ipaddress.IPv6Address('2001:db8::1000'), '_X')
   '2001_0DB8_0000_0000_0000_0000_0000_1000'
   >>> '{:#_n}'.format(ipaddress.IPv6Address('2001:db8::1000'))
   '0x2001_0db8_0000_0000_0000_0000_0000_1000'

   New in version 3.9.

class ipaddress.IPv6Address(address)      *IPv6Address..ipaddress.pyx*

   Construct an IPv6 address.  An "AddressValueError" is raised if
   _address_ is not a valid IPv6 address.

   The following constitutes a valid IPv6 address:

   1. A string consisting of eight groups of four hexadecimal digits,
      each group representing 16 bits.  The groups are separated by
      colons. This describes an _exploded_ (longhand) notation.  The
      string can also be _compressed_ (shorthand notation) by various
      means.  See **RFC 4291** for details.  For example,
      ""0000:0000:0000:0000:0000:0abc:0007:0def"" can be compressed to
      ""::abc:7:def"".

      Optionally, the string may also have a scope zone ID, expressed
      with a suffix "%scope_id". If present, the scope ID must be non-
      empty, and may not contain "%". See **RFC 4007** for details.
      For example, "fe80::1234%1" might identify address "fe80::1234"
      on the first link of the node.

   2. An integer that fits into 128 bits.

   3. An integer packed into a "bytes" object of length 16, big-
      endian.

   >>> ipaddress.IPv6Address('2001:db8::1000')
   IPv6Address('2001:db8::1000')
   >>> ipaddress.IPv6Address('ff02::5678%1')
   IPv6Address('ff02::5678%1')

   compressed                     *IPv6Address.compressed..ipaddress.pyx*

   The short form of the address representation, with leading zeroes
   in groups omitted and the longest sequence of groups consisting
   entirely of zeroes collapsed to a single empty group.

   This is also the value returned by "str(addr)" for IPv6 addresses.

   exploded                         *IPv6Address.exploded..ipaddress.pyx*

   The long form of the address representation, with all leading
   zeroes and groups consisting entirely of zeroes included.

   For the following attributes and methods, see the corresponding
   documentation of the "IPv4Address" class:

   packed                             *IPv6Address.packed..ipaddress.pyx*

   reverse_pointer           *IPv6Address.reverse_pointer..ipaddress.pyx*

   version                           *IPv6Address.version..ipaddress.pyx*

   max_prefixlen               *IPv6Address.max_prefixlen..ipaddress.pyx*

   is_multicast                 *IPv6Address.is_multicast..ipaddress.pyx*

   is_private                     *IPv6Address.is_private..ipaddress.pyx*

   is_global                       *IPv6Address.is_global..ipaddress.pyx*

   is_unspecified             *IPv6Address.is_unspecified..ipaddress.pyx*

   is_reserved                   *IPv6Address.is_reserved..ipaddress.pyx*

   is_loopback                   *IPv6Address.is_loopback..ipaddress.pyx*

   is_link_local               *IPv6Address.is_link_local..ipaddress.pyx*

      New in version 3.4: is_global

   is_site_local               *IPv6Address.is_site_local..ipaddress.pyx*

      "True" if the address is reserved for site-local usage.  Note
      that the site-local address space has been deprecated by **RFC
      3879**. Use "is_private" to test if this address is in the space
      of unique local addresses as defined by **RFC 4193**.

   ipv4_mapped                   *IPv6Address.ipv4_mapped..ipaddress.pyx*

      For addresses that appear to be IPv4 mapped addresses (starting
      with "::FFFF/96"), this property will report the embedded IPv4
      address. For any other address, this property will be "None".

   scope_id                         *IPv6Address.scope_id..ipaddress.pyx*

      For scoped addresses as defined by **RFC 4007**, this property
      identifies the particular zone of the address’s scope that the
      address belongs to, as a string. When no scope zone is
      specified, this property will be "None".

   sixtofour                       *IPv6Address.sixtofour..ipaddress.pyx*

      For addresses that appear to be 6to4 addresses  (starting with
      "2002::/16") as defined by **RFC 3056**, this property will
      report the embedded IPv4 address.  For any other address, this
      property will be "None".

   teredo                             *IPv6Address.teredo..ipaddress.pyx*

      For addresses that appear to be Teredo addresses (starting with
      "2001::/32") as defined by **RFC 4380**, this property will
      report the embedded "(server, client)" IP address pair.  For any
      other address, this property will be "None".

                             *IPv6Address.__format__()..ipaddress.pyx*
IPv6Address.__format__(fmt)

   Refer to the corresponding method documentation in "IPv4Address".

   New in version 3.9.


Conversion to Strings and Integers
----------------------------------

To interoperate with networking interfaces such as the socket module,
addresses must be converted to strings or integers. This is handled
using the "str()" and "int()" builtin functions:
>
   >>> str(ipaddress.IPv4Address('192.168.0.1'))
   '192.168.0.1'
   >>> int(ipaddress.IPv4Address('192.168.0.1'))
   3232235521
   >>> str(ipaddress.IPv6Address('::1'))
   '::1'
   >>> int(ipaddress.IPv6Address('::1'))
   1
<
Note that IPv6 scoped addresses are converted to integers without
scope zone ID.


Operators
---------

Address objects support some operators.  Unless stated otherwise,
operators can only be applied between compatible objects (i.e. IPv4
with IPv4, IPv6 with IPv6).


Comparison operators
~~~~~~~~~~~~~~~~~~~~

Address objects can be compared with the usual set of comparison
operators. Same IPv6 addresses with different scope zone IDs are not
equal. Some examples:
>
   >>> IPv4Address('127.0.0.2') > IPv4Address('127.0.0.1')
   True
   >>> IPv4Address('127.0.0.2') == IPv4Address('127.0.0.1')
   False
   >>> IPv4Address('127.0.0.2') != IPv4Address('127.0.0.1')
   True
   >>> IPv6Address('fe80::1234') == IPv6Address('fe80::1234%1')
   False
   >>> IPv6Address('fe80::1234%1') != IPv6Address('fe80::1234%2')
   True
<

Arithmetic operators
~~~~~~~~~~~~~~~~~~~~

Integers can be added to or subtracted from address objects.  Some
examples:
>
   >>> IPv4Address('127.0.0.2') + 3
   IPv4Address('127.0.0.5')
   >>> IPv4Address('127.0.0.2') - 3
   IPv4Address('126.255.255.255')
   >>> IPv4Address('255.255.255.255') + 1
   Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
   ipaddress.AddressValueError: 4294967296 (>= 2**32) is not permitted as an IPv4 address
<

IP Network definitions
======================

The "IPv4Network" and "IPv6Network" objects provide a mechanism for
defining and inspecting IP network definitions.  A network definition
consists of a _mask_ and a _network address_, and as such defines a
range of IP addresses that equal the network address when masked
(binary AND) with the mask.  For example, a network definition with
the mask "255.255.255.0" and the network address "192.168.1.0"
consists of IP addresses in the inclusive range "192.168.1.0" to
"192.168.1.255".


Prefix, net mask and host mask
------------------------------

There are several equivalent ways to specify IP network masks.  A
_prefix_ "/<nbits>" is a notation that denotes how many high-order
bits are set in the network mask.  A _net mask_ is an IP address with
some number of high-order bits set.  Thus the prefix "/24" is
equivalent to the net mask "255.255.255.0" in IPv4, or "ffff:ff00::"
in IPv6.  In addition, a _host mask_ is the logical inverse of a _net
mask_, and is sometimes used (for example in Cisco access control
lists) to denote a network mask.  The host mask equivalent to "/24" in
IPv4 is "0.0.0.255".


Network objects
---------------

All attributes implemented by address objects are implemented by
network objects as well.  In addition, network objects implement
additional attributes. All of these are common between "IPv4Network"
and "IPv6Network", so to avoid duplication they are only documented
for "IPv4Network". Network objects are _hashable_, so they can be used
as keys in dictionaries.

                                          *IPv4Network..ipaddress.pyx*
class ipaddress.IPv4Network(address, strict=True)

   Construct an IPv4 network definition.  _address_ can be one of the
   following:

   1. A string consisting of an IP address and an optional mask,
      separated by a slash ("/").  The IP address is the network
      address, and the mask can be either a single number, which means
      it’s a _prefix_, or a string representation of an IPv4 address.
      If it’s the latter, the mask is interpreted as a _net mask_ if
      it starts with a non-zero field, or as a _host mask_ if it
      starts with a zero field, with the single exception of an all-
      zero mask which is treated as a _net mask_.  If no mask is
      provided, it’s considered to be "/32".

      For example, the following _address_ specifications are
      equivalent: "192.168.1.0/24", "192.168.1.0/255.255.255.0" and
      "192.168.1.0/0.0.0.255".

   2. An integer that fits into 32 bits.  This is equivalent to a
      single-address network, with the network address being _address_
      and the mask being "/32".

   3. An integer packed into a "bytes" object of length 4, big-endian.
      The interpretation is similar to an integer _address_.

   4. A two-tuple of an address description and a netmask, where the
      address description is either a string, a 32-bits integer, a
      4-bytes packed integer, or an existing IPv4Address object; and
      the netmask is either an integer representing the prefix length
      (e.g. "24") or a string representing the prefix mask (e.g.
      "255.255.255.0").

   An "AddressValueError" is raised if _address_ is not a valid IPv4
   address.  A "NetmaskValueError" is raised if the mask is not valid
   for an IPv4 address.

   If _strict_ is "True" and host bits are set in the supplied
   address, then "ValueError" is raised.  Otherwise, the host bits are
   masked out to determine the appropriate network address.

   Unless stated otherwise, all network methods accepting other
   network/address objects will raise "TypeError" if the argument’s IP
   version is incompatible to "self".

   Changed in version 3.5: Added the two-tuple form for the _address_
   constructor parameter.

   version                           *IPv4Network.version..ipaddress.pyx*

   max_prefixlen               *IPv4Network.max_prefixlen..ipaddress.pyx*

      Refer to the corresponding attribute documentation in
      "IPv4Address".

   is_multicast                 *IPv4Network.is_multicast..ipaddress.pyx*

   is_private                     *IPv4Network.is_private..ipaddress.pyx*

   is_unspecified             *IPv4Network.is_unspecified..ipaddress.pyx*

   is_reserved                   *IPv4Network.is_reserved..ipaddress.pyx*

   is_loopback                   *IPv4Network.is_loopback..ipaddress.pyx*

   is_link_local               *IPv4Network.is_link_local..ipaddress.pyx*

      These attributes are true for the network as a whole if they are
      true for both the network address and the broadcast address.

   network_address           *IPv4Network.network_address..ipaddress.pyx*

      The network address for the network. The network address and the
      prefix length together uniquely define a network.

   broadcast_address       *IPv4Network.broadcast_address..ipaddress.pyx*

      The broadcast address for the network. Packets sent to the
      broadcast address should be received by every host on the
      network.

   hostmask                         *IPv4Network.hostmask..ipaddress.pyx*

      The host mask, as an "IPv4Address" object.

   netmask                           *IPv4Network.netmask..ipaddress.pyx*

      The net mask, as an "IPv4Address" object.

   with_prefixlen             *IPv4Network.with_prefixlen..ipaddress.pyx*

   compressed                     *IPv4Network.compressed..ipaddress.pyx*

   exploded                         *IPv4Network.exploded..ipaddress.pyx*

      A string representation of the network, with the mask in prefix
      notation.

      "with_prefixlen" and "compressed" are always the same as
      "str(network)". "exploded" uses the exploded form the network
      address.

   with_netmask                 *IPv4Network.with_netmask..ipaddress.pyx*

      A string representation of the network, with the mask in net
      mask notation.

   with_hostmask               *IPv4Network.with_hostmask..ipaddress.pyx*

      A string representation of the network, with the mask in host
      mask notation.

   num_addresses               *IPv4Network.num_addresses..ipaddress.pyx*

      The total number of addresses in the network.

   prefixlen                       *IPv4Network.prefixlen..ipaddress.pyx*

      Length of the network prefix, in bits.

   hosts()                           *IPv4Network.hosts()..ipaddress.pyx*

      Returns an iterator over the usable hosts in the network.  The
      usable hosts are all the IP addresses that belong to the
      network, except the network address itself and the network
      broadcast address.  For networks with a mask length of 31, the
      network address and network broadcast address are also included
      in the result. Networks with a mask of 32 will return a list
      containing the single host address.

      >>> list(ip_network('192.0.2.0/29').hosts())  
      [IPv4Address('192.0.2.1'), IPv4Address('192.0.2.2'),
       IPv4Address('192.0.2.3'), IPv4Address('192.0.2.4'),
       IPv4Address('192.0.2.5'), IPv4Address('192.0.2.6')]
      >>> list(ip_network('192.0.2.0/31').hosts())
      [IPv4Address('192.0.2.0'), IPv4Address('192.0.2.1')]
      >>> list(ip_network('192.0.2.1/32').hosts())
      [IPv4Address('192.0.2.1')]

   overlaps(other)                *IPv4Network.overlaps()..ipaddress.pyx*

      "True" if this network is partly or wholly contained in _other_
      or _other_ is wholly contained in this network.

                        *IPv4Network.address_exclude()..ipaddress.pyx*
   address_exclude(network)

      Computes the network definitions resulting from removing the
      given _network_ from this one.  Returns an iterator of network
      objects. Raises "ValueError" if _network_ is not completely
      contained in this network.

      >>> n1 = ip_network('192.0.2.0/28')
      >>> n2 = ip_network('192.0.2.1/32')
      >>> list(n1.address_exclude(n2))  
      [IPv4Network('192.0.2.8/29'), IPv4Network('192.0.2.4/30'),
       IPv4Network('192.0.2.2/31'), IPv4Network('192.0.2.0/32')]

                                *IPv4Network.subnets()..ipaddress.pyx*
   subnets(prefixlen_diff=1, new_prefix=None)

      The subnets that join to make the current network definition,
      depending on the argument values.  _prefixlen_diff_ is the
      amount our prefix length should be increased by.  _new_prefix_
      is the desired new prefix of the subnets; it must be larger than
      our prefix.  One and only one of _prefixlen_diff_ and
      _new_prefix_ must be set.  Returns an iterator of network
      objects.

      >>> list(ip_network('192.0.2.0/24').subnets())
      [IPv4Network('192.0.2.0/25'), IPv4Network('192.0.2.128/25')]
      >>> list(ip_network('192.0.2.0/24').subnets(prefixlen_diff=2))  
      [IPv4Network('192.0.2.0/26'), IPv4Network('192.0.2.64/26'),
       IPv4Network('192.0.2.128/26'), IPv4Network('192.0.2.192/26')]
      >>> list(ip_network('192.0.2.0/24').subnets(new_prefix=26))  
      [IPv4Network('192.0.2.0/26'), IPv4Network('192.0.2.64/26'),
       IPv4Network('192.0.2.128/26'), IPv4Network('192.0.2.192/26')]
      >>> list(ip_network('192.0.2.0/24').subnets(new_prefix=23))
      Traceback (most recent call last):
        File "<stdin>", line 1, in <module>
          raise ValueError('new prefix must be longer')
      ValueError: new prefix must be longer
      >>> list(ip_network('192.0.2.0/24').subnets(new_prefix=25))
      [IPv4Network('192.0.2.0/25'), IPv4Network('192.0.2.128/25')]

                               *IPv4Network.supernet()..ipaddress.pyx*
   supernet(prefixlen_diff=1, new_prefix=None)

      The supernet containing this network definition, depending on
      the argument values.  _prefixlen_diff_ is the amount our prefix
      length should be decreased by.  _new_prefix_ is the desired new
      prefix of the supernet; it must be smaller than our prefix.  One
      and only one of _prefixlen_diff_ and _new_prefix_ must be set.
      Returns a single network object.

      >>> ip_network('192.0.2.0/24').supernet()
      IPv4Network('192.0.2.0/23')
      >>> ip_network('192.0.2.0/24').supernet(prefixlen_diff=2)
      IPv4Network('192.0.0.0/22')
      >>> ip_network('192.0.2.0/24').supernet(new_prefix=20)
      IPv4Network('192.0.0.0/20')

   subnet_of(other)              *IPv4Network.subnet_of()..ipaddress.pyx*

      Return "True" if this network is a subnet of _other_.

      >>> a = ip_network('192.168.1.0/24')
      >>> b = ip_network('192.168.1.128/30')
      >>> b.subnet_of(a)
      True

      New in version 3.7.

   supernet_of(other)          *IPv4Network.supernet_of()..ipaddress.pyx*

      Return "True" if this network is a supernet of _other_.

      >>> a = ip_network('192.168.1.0/24')
      >>> b = ip_network('192.168.1.128/30')
      >>> a.supernet_of(b)
      True

      New in version 3.7.

                       *IPv4Network.compare_networks()..ipaddress.pyx*
   compare_networks(other)

      Compare this network to _other_.  In this comparison only the
      network addresses are considered; host bits aren’t.  Returns
      either "-1", "0" or "1".

      >>> ip_network('192.0.2.1/32').compare_networks(ip_network('192.0.2.2/32'))
      -1
      >>> ip_network('192.0.2.1/32').compare_networks(ip_network('192.0.2.0/32'))
      1
      >>> ip_network('192.0.2.1/32').compare_networks(ip_network('192.0.2.1/32'))
      0

      Deprecated since version 3.7: It uses the same ordering and
      comparison algorithm as “<”, “==”, and “>”

                                          *IPv6Network..ipaddress.pyx*
class ipaddress.IPv6Network(address, strict=True)

   Construct an IPv6 network definition.  _address_ can be one of the
   following:

   1. A string consisting of an IP address and an optional prefix
      length, separated by a slash ("/").  The IP address is the
      network address, and the prefix length must be a single number,
      the _prefix_.  If no prefix length is provided, it’s considered
      to be "/128".

      Note that currently expanded netmasks are not supported.  That
      means "2001:db00::0/24" is a valid argument while
      "2001:db00::0/ffff:ff00::" is not.

   2. An integer that fits into 128 bits.  This is equivalent to a
      single-address network, with the network address being _address_
      and the mask being "/128".

   3. An integer packed into a "bytes" object of length 16, big-
      endian. The interpretation is similar to an integer _address_.

   4. A two-tuple of an address description and a netmask, where the
      address description is either a string, a 128-bits integer, a
      16-bytes packed integer, or an existing IPv6Address object; and
      the netmask is an integer representing the prefix length.

   An "AddressValueError" is raised if _address_ is not a valid IPv6
   address.  A "NetmaskValueError" is raised if the mask is not valid
   for an IPv6 address.

   If _strict_ is "True" and host bits are set in the supplied
   address, then "ValueError" is raised.  Otherwise, the host bits are
   masked out to determine the appropriate network address.

   Changed in version 3.5: Added the two-tuple form for the _address_
   constructor parameter.

   version                           *IPv6Network.version..ipaddress.pyx*

   max_prefixlen               *IPv6Network.max_prefixlen..ipaddress.pyx*

   is_multicast                 *IPv6Network.is_multicast..ipaddress.pyx*

   is_private                     *IPv6Network.is_private..ipaddress.pyx*

   is_unspecified             *IPv6Network.is_unspecified..ipaddress.pyx*

   is_reserved                   *IPv6Network.is_reserved..ipaddress.pyx*

   is_loopback                   *IPv6Network.is_loopback..ipaddress.pyx*

   is_link_local               *IPv6Network.is_link_local..ipaddress.pyx*

   network_address           *IPv6Network.network_address..ipaddress.pyx*

   broadcast_address       *IPv6Network.broadcast_address..ipaddress.pyx*

   hostmask                         *IPv6Network.hostmask..ipaddress.pyx*

   netmask                           *IPv6Network.netmask..ipaddress.pyx*

   with_prefixlen             *IPv6Network.with_prefixlen..ipaddress.pyx*

   compressed                     *IPv6Network.compressed..ipaddress.pyx*

   exploded                         *IPv6Network.exploded..ipaddress.pyx*

   with_netmask                 *IPv6Network.with_netmask..ipaddress.pyx*

   with_hostmask               *IPv6Network.with_hostmask..ipaddress.pyx*

   num_addresses               *IPv6Network.num_addresses..ipaddress.pyx*

   prefixlen                       *IPv6Network.prefixlen..ipaddress.pyx*

   hosts()                           *IPv6Network.hosts()..ipaddress.pyx*

      Returns an iterator over the usable hosts in the network.  The
      usable hosts are all the IP addresses that belong to the
      network, except the Subnet-Router anycast address.  For networks
      with a mask length of 127, the Subnet-Router anycast address is
      also included in the result. Networks with a mask of 128 will
      return a list containing the single host address.

   overlaps(other)                *IPv6Network.overlaps()..ipaddress.pyx*

                        *IPv6Network.address_exclude()..ipaddress.pyx*
   address_exclude(network)

                                *IPv6Network.subnets()..ipaddress.pyx*
   subnets(prefixlen_diff=1, new_prefix=None)

                               *IPv6Network.supernet()..ipaddress.pyx*
   supernet(prefixlen_diff=1, new_prefix=None)

   subnet_of(other)              *IPv6Network.subnet_of()..ipaddress.pyx*

   supernet_of(other)          *IPv6Network.supernet_of()..ipaddress.pyx*

                       *IPv6Network.compare_networks()..ipaddress.pyx*
   compare_networks(other)

      Refer to the corresponding attribute documentation in
      "IPv4Network".

   is_site_local               *IPv6Network.is_site_local..ipaddress.pyx*

      These attribute is true for the network as a whole if it is true
      for both the network address and the broadcast address.


Operators
---------

Network objects support some operators.  Unless stated otherwise,
operators can only be applied between compatible objects (i.e. IPv4
with IPv4, IPv6 with IPv6).


Logical operators
~~~~~~~~~~~~~~~~~

Network objects can be compared with the usual set of logical
operators. Network objects are ordered first by network address, then
by net mask.


Iteration
~~~~~~~~~

Network objects can be iterated to list all the addresses belonging to
the network.  For iteration, _all_ hosts are returned, including
unusable hosts (for usable hosts, use the "hosts()" method).  An
example:
>
   >>> for addr in IPv4Network('192.0.2.0/28'):
   ...     addr
   ...
   IPv4Address('192.0.2.0')
   IPv4Address('192.0.2.1')
   IPv4Address('192.0.2.2')
   IPv4Address('192.0.2.3')
   IPv4Address('192.0.2.4')
   IPv4Address('192.0.2.5')
   IPv4Address('192.0.2.6')
   IPv4Address('192.0.2.7')
   IPv4Address('192.0.2.8')
   IPv4Address('192.0.2.9')
   IPv4Address('192.0.2.10')
   IPv4Address('192.0.2.11')
   IPv4Address('192.0.2.12')
   IPv4Address('192.0.2.13')
   IPv4Address('192.0.2.14')
   IPv4Address('192.0.2.15')
<

Networks as containers of addresses
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Network objects can act as containers of addresses.  Some examples:
>
   >>> IPv4Network('192.0.2.0/28')[0]
   IPv4Address('192.0.2.0')
   >>> IPv4Network('192.0.2.0/28')[15]
   IPv4Address('192.0.2.15')
   >>> IPv4Address('192.0.2.6') in IPv4Network('192.0.2.0/28')
   True
   >>> IPv4Address('192.0.3.6') in IPv4Network('192.0.2.0/28')
   False
<

Interface objects
=================

Interface objects are _hashable_, so they can be used as keys in
dictionaries.

                                        *IPv4Interface..ipaddress.pyx*
class ipaddress.IPv4Interface(address)

   Construct an IPv4 interface.  The meaning of _address_ is as in the
   constructor of "IPv4Network", except that arbitrary host addresses
   are always accepted.

   "IPv4Interface" is a subclass of "IPv4Address", so it inherits all
   the attributes from that class.  In addition, the following
   attributes are available:

   ip                                   *IPv4Interface.ip..ipaddress.pyx*

      The address ("IPv4Address") without network information.

      >>> interface = IPv4Interface('192.0.2.5/24')
      >>> interface.ip
      IPv4Address('192.0.2.5')

   network                         *IPv4Interface.network..ipaddress.pyx*

      The network ("IPv4Network") this interface belongs to.

      >>> interface = IPv4Interface('192.0.2.5/24')
      >>> interface.network
      IPv4Network('192.0.2.0/24')

   with_prefixlen           *IPv4Interface.with_prefixlen..ipaddress.pyx*

      A string representation of the interface with the mask in prefix
      notation.

      >>> interface = IPv4Interface('192.0.2.5/24')
      >>> interface.with_prefixlen
      '192.0.2.5/24'

   with_netmask               *IPv4Interface.with_netmask..ipaddress.pyx*

      A string representation of the interface with the network as a
      net mask.

      >>> interface = IPv4Interface('192.0.2.5/24')
      >>> interface.with_netmask
      '192.0.2.5/255.255.255.0'

   with_hostmask             *IPv4Interface.with_hostmask..ipaddress.pyx*

      A string representation of the interface with the network as a
      host mask.

      >>> interface = IPv4Interface('192.0.2.5/24')
      >>> interface.with_hostmask
      '192.0.2.5/0.0.0.255'

                                        *IPv6Interface..ipaddress.pyx*
class ipaddress.IPv6Interface(address)

   Construct an IPv6 interface.  The meaning of _address_ is as in the
   constructor of "IPv6Network", except that arbitrary host addresses
   are always accepted.

   "IPv6Interface" is a subclass of "IPv6Address", so it inherits all
   the attributes from that class.  In addition, the following
   attributes are available:

   ip                                   *IPv6Interface.ip..ipaddress.pyx*

   network                         *IPv6Interface.network..ipaddress.pyx*

   with_prefixlen           *IPv6Interface.with_prefixlen..ipaddress.pyx*

   with_netmask               *IPv6Interface.with_netmask..ipaddress.pyx*

   with_hostmask             *IPv6Interface.with_hostmask..ipaddress.pyx*

      Refer to the corresponding attribute documentation in
      "IPv4Interface".


Operators
---------

Interface objects support some operators.  Unless stated otherwise,
operators can only be applied between compatible objects (i.e. IPv4
with IPv4, IPv6 with IPv6).


Logical operators
~~~~~~~~~~~~~~~~~

Interface objects can be compared with the usual set of logical
operators.

For equality comparison ("==" and "!="), both the IP address and
network must be the same for the objects to be equal.  An interface
will not compare equal to any address or network object.

For ordering ("<", ">", etc) the rules are different.  Interface and
address objects with the same IP version can be compared, and the
address objects will always sort before the interface objects.  Two
interface objects are first compared by their networks and, if those
are the same, then by their IP addresses.


Other Module Level Functions
============================

The module also provides the following module level functions:

                                   *v4_int_to_packed()..ipaddress.pyx*
ipaddress.v4_int_to_packed(address)

   Represent an address as 4 packed bytes in network (big-endian)
   order. _address_ is an integer representation of an IPv4 IP
   address.  A "ValueError" is raised if the integer is negative or
   too large to be an IPv4 IP address.

   >>> ipaddress.ip_address(3221225985)
   IPv4Address('192.0.2.1')
   >>> ipaddress.v4_int_to_packed(3221225985)
   b'\xc0\x00\x02\x01'

                                   *v6_int_to_packed()..ipaddress.pyx*
ipaddress.v6_int_to_packed(address)

   Represent an address as 16 packed bytes in network (big-endian)
   order. _address_ is an integer representation of an IPv6 IP
   address.  A "ValueError" is raised if the integer is negative or
   too large to be an IPv6 IP address.

                            *summarize_address_range()..ipaddress.pyx*
ipaddress.summarize_address_range(first, last)

   Return an iterator of the summarized network range given the first
   and last IP addresses.  _first_ is the first "IPv4Address" or
   "IPv6Address" in the range and _last_ is the last "IPv4Address" or
   "IPv6Address" in the range.  A "TypeError" is raised if _first_ or
   _last_ are not IP addresses or are not of the same version.  A
   "ValueError" is raised if _last_ is not greater than _first_ or if
   _first_ address version is not 4 or 6.

   >>> [ipaddr for ipaddr in ipaddress.summarize_address_range(
   ...    ipaddress.IPv4Address('192.0.2.0'),
   ...    ipaddress.IPv4Address('192.0.2.130'))]
   [IPv4Network('192.0.2.0/25'), IPv4Network('192.0.2.128/31'), IPv4Network('192.0.2.130/32')]

                                 *collapse_addresses()..ipaddress.pyx*
ipaddress.collapse_addresses(addresses)

   Return an iterator of the collapsed "IPv4Network" or "IPv6Network"
   objects.  _addresses_ is an iterator of "IPv4Network" or
   "IPv6Network" objects.  A "TypeError" is raised if _addresses_
   contains mixed version objects.

   >>> [ipaddr for ipaddr in
   ... ipaddress.collapse_addresses([ipaddress.IPv4Network('192.0.2.0/25'),
   ... ipaddress.IPv4Network('192.0.2.128/25')])]
   [IPv4Network('192.0.2.0/24')]

                                 *get_mixed_type_key()..ipaddress.pyx*
ipaddress.get_mixed_type_key(obj)

   Return a key suitable for sorting between networks and addresses.
   Address and Network objects are not sortable by default; they’re
   fundamentally different, so the expression:
>
      IPv4Address('192.0.2.0') <= IPv4Network('192.0.2.0/24')
<
   doesn’t make sense.  There are some times however, where you may
   wish to have "ipaddress" sort these anyway.  If you need to do
   this, you can use this function as the _key_ argument to
   "sorted()".

   _obj_ is either a network or address object.


Custom Exceptions
=================

To support more specific error reporting from class constructors, the
module defines the following exceptions:

                                    *AddressValueError..ipaddress.pyx*
exception ipaddress.AddressValueError(ValueError)

   Any value error related to the address.

                                    *NetmaskValueError..ipaddress.pyx*
exception ipaddress.NetmaskValueError(ValueError)

   Any value error related to the net mask.

vim:tw=78:ts=8:ft=help:norl: