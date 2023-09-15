*markup.pyx*                                  Last change: 2023 Sep 15

Structured Markup Processing Tools
**********************************

Python supports a variety of modules to work with various forms of
structured data markup.  This includes modules to work with the
Standard Generalized Markup Language (SGML) and the Hypertext Markup
Language (HTML), and several interfaces for working with the
Extensible Markup Language (XML).

* "html" — HyperText Markup Language support

  * "escape()"

  * "unescape()"

* "html.parser" — Simple HTML and XHTML parser

  * "HTMLParser"

  * Example HTML Parser Application

  * "HTMLParser" Methods

    * "HTMLParser.feed()"

    * "HTMLParser.close()"

    * "HTMLParser.reset()"

    * "HTMLParser.getpos()"

    * "HTMLParser.get_starttag_text()"

    * "HTMLParser.handle_starttag()"

    * "HTMLParser.handle_endtag()"

    * "HTMLParser.handle_startendtag()"

    * "HTMLParser.handle_data()"

    * "HTMLParser.handle_entityref()"

    * "HTMLParser.handle_charref()"

    * "HTMLParser.handle_comment()"

    * "HTMLParser.handle_decl()"

    * "HTMLParser.handle_pi()"

    * "HTMLParser.unknown_decl()"

  * Examples

* "html.entities" — Definitions of HTML general entities

  * "html5"

  * "entitydefs"

  * "name2codepoint"

  * "codepoint2name"

* XML Processing Modules

  * XML vulnerabilities

  * The "defusedxml" Package

* "xml.etree.ElementTree" — The ElementTree XML API

  * Tutorial

    * XML tree and elements

    * Parsing XML

    * Pull API for non-blocking parsing

    * Finding interesting elements

    * Modifying an XML File

    * Building XML documents

    * Parsing XML with Namespaces

  * XPath support

    * Example

    * Supported XPath syntax

  * Reference

    * Functions

      * "canonicalize()"

      * "Comment()"

      * "dump()"

      * "fromstring()"

      * "fromstringlist()"

      * "indent()"

      * "iselement()"

      * "iterparse()"

      * "parse()"

      * "ProcessingInstruction()"

      * "register_namespace()"

      * "SubElement()"

      * "tostring()"

      * "tostringlist()"

      * "XML()"

      * "XMLID()"

  * XInclude support

    * Example

  * Reference

    * Functions

      * "xml.etree.ElementInclude.default_loader()"

      * "xml.etree.ElementInclude.include()"

    * Element Objects

      * "Element"

        * "Element.tag"

        * "Element.text"

        * "Element.tail"

        * "Element.attrib"

        * "Element.clear()"

        * "Element.get()"

        * "Element.items()"

        * "Element.keys()"

        * "Element.set()"

        * "Element.append()"

        * "Element.extend()"

        * "Element.find()"

        * "Element.findall()"

        * "Element.findtext()"

        * "Element.insert()"

        * "Element.iter()"

        * "Element.iterfind()"

        * "Element.itertext()"

        * "Element.makeelement()"

        * "Element.remove()"

    * ElementTree Objects

      * "ElementTree"

        * "ElementTree._setroot()"

        * "ElementTree.find()"

        * "ElementTree.findall()"

        * "ElementTree.findtext()"

        * "ElementTree.getroot()"

        * "ElementTree.iter()"

        * "ElementTree.iterfind()"

        * "ElementTree.parse()"

        * "ElementTree.write()"

    * QName Objects

      * "QName"

    * TreeBuilder Objects

      * "TreeBuilder"

        * "TreeBuilder.close()"

        * "TreeBuilder.data()"

        * "TreeBuilder.end()"

        * "TreeBuilder.start()"

        * "TreeBuilder.comment()"

        * "TreeBuilder.pi()"

        * "TreeBuilder.doctype()"

        * "TreeBuilder.start_ns()"

        * "TreeBuilder.end_ns()"

      * "C14NWriterTarget"

    * XMLParser Objects

      * "XMLParser"

        * "XMLParser.close()"

        * "XMLParser.feed()"

    * XMLPullParser Objects

      * "XMLPullParser"

        * "XMLPullParser.feed()"

        * "XMLPullParser.close()"

        * "XMLPullParser.read_events()"

    * Exceptions

      * "ParseError"

        * "ParseError.code"

        * "ParseError.position"

* "xml.dom" — The Document Object Model API

  * Module Contents

    * "registerDOMImplementation()"

    * "getDOMImplementation()"

    * "EMPTY_NAMESPACE"

    * "XML_NAMESPACE"

    * "XMLNS_NAMESPACE"

    * "XHTML_NAMESPACE"

  * Objects in the DOM

    * DOMImplementation Objects

      * "DOMImplementation.hasFeature()"

      * "DOMImplementation.createDocument()"

      * "DOMImplementation.createDocumentType()"

    * Node Objects

      * "Node.nodeType"

      * "Node.parentNode"

      * "Node.attributes"

      * "Node.previousSibling"

      * "Node.nextSibling"

      * "Node.childNodes"

      * "Node.firstChild"

      * "Node.lastChild"

      * "Node.localName"

      * "Node.prefix"

      * "Node.namespaceURI"

      * "Node.nodeName"

      * "Node.nodeValue"

      * "Node.hasAttributes()"

      * "Node.hasChildNodes()"

      * "Node.isSameNode()"

      * "Node.appendChild()"

      * "Node.insertBefore()"

      * "Node.removeChild()"

      * "Node.replaceChild()"

      * "Node.normalize()"

      * "Node.cloneNode()"

    * NodeList Objects

      * "NodeList.item()"

      * "NodeList.length"

    * DocumentType Objects

      * "DocumentType.publicId"

      * "DocumentType.systemId"

      * "DocumentType.internalSubset"

      * "DocumentType.name"

      * "DocumentType.entities"

      * "DocumentType.notations"

    * Document Objects

      * "Document.documentElement"

      * "Document.createElement()"

      * "Document.createElementNS()"

      * "Document.createTextNode()"

      * "Document.createComment()"

      * "Document.createProcessingInstruction()"

      * "Document.createAttribute()"

      * "Document.createAttributeNS()"

      * "Document.getElementsByTagName()"

      * "Document.getElementsByTagNameNS()"

    * Element Objects

      * "Element.tagName"

      * "Element.getElementsByTagName()"

      * "Element.getElementsByTagNameNS()"

      * "Element.hasAttribute()"

      * "Element.hasAttributeNS()"

      * "Element.getAttribute()"

      * "Element.getAttributeNode()"

      * "Element.getAttributeNS()"

      * "Element.getAttributeNodeNS()"

      * "Element.removeAttribute()"

      * "Element.removeAttributeNode()"

      * "Element.removeAttributeNS()"

      * "Element.setAttribute()"

      * "Element.setAttributeNode()"

      * "Element.setAttributeNodeNS()"

      * "Element.setAttributeNS()"

    * Attr Objects

      * "Attr.name"

      * "Attr.localName"

      * "Attr.prefix"

      * "Attr.value"

    * NamedNodeMap Objects

      * "NamedNodeMap.length"

      * "NamedNodeMap.item()"

    * Comment Objects

      * "Comment.data"

    * Text and CDATASection Objects

      * "Text.data"

    * ProcessingInstruction Objects

      * "ProcessingInstruction.target"

      * "ProcessingInstruction.data"

    * Exceptions

      * "DOMException"

      * "DomstringSizeErr"

      * "HierarchyRequestErr"

      * "IndexSizeErr"

      * "InuseAttributeErr"

      * "InvalidAccessErr"

      * "InvalidCharacterErr"

      * "InvalidModificationErr"

      * "InvalidStateErr"

      * "NamespaceErr"

      * "NotFoundErr"

      * "NotSupportedErr"

      * "NoDataAllowedErr"

      * "NoModificationAllowedErr"

      * "SyntaxErr"

      * "WrongDocumentErr"

  * Conformance

    * Type Mapping

    * Accessor Methods

* "xml.dom.minidom" — Minimal DOM implementation

  * "parse()"

  * "parseString()"

  * DOM Objects

    * "Node.unlink()"

    * "Node.writexml()"

    * "Node.toxml()"

    * "Node.toprettyxml()"

  * DOM Example

  * minidom and the DOM standard

* "xml.dom.pulldom" — Support for building partial DOM trees

  * "PullDom"

  * "SAX2DOM"

  * "parse()"

  * "parseString()"

  * "default_bufsize"

  * DOMEventStream Objects

    * "DOMEventStream"

      * "DOMEventStream.getEvent()"

      * "DOMEventStream.expandNode()"

      * "DOMEventStream.reset()"

* "xml.sax" — Support for SAX2 parsers

  * "make_parser()"

  * "parse()"

  * "parseString()"

  * "SAXException"

  * "SAXParseException"

  * "SAXNotRecognizedException"

  * "SAXNotSupportedException"

  * SAXException Objects

    * "SAXException.getMessage()"

    * "SAXException.getException()"

* "xml.sax.handler" — Base classes for SAX handlers

  * "ContentHandler"

  * "DTDHandler"

  * "EntityResolver"

  * "ErrorHandler"

  * "LexicalHandler"

  * "feature_namespaces"

  * "feature_namespace_prefixes"

  * "feature_string_interning"

  * "feature_validation"

  * "feature_external_ges"

  * "feature_external_pes"

  * "all_features"

  * "property_lexical_handler"

  * "property_declaration_handler"

  * "property_dom_node"

  * "property_xml_string"

  * "all_properties"

  * ContentHandler Objects

    * "ContentHandler.setDocumentLocator()"

    * "ContentHandler.startDocument()"

    * "ContentHandler.endDocument()"

    * "ContentHandler.startPrefixMapping()"

    * "ContentHandler.endPrefixMapping()"

    * "ContentHandler.startElement()"

    * "ContentHandler.endElement()"

    * "ContentHandler.startElementNS()"

    * "ContentHandler.endElementNS()"

    * "ContentHandler.characters()"

    * "ContentHandler.ignorableWhitespace()"

    * "ContentHandler.processingInstruction()"

    * "ContentHandler.skippedEntity()"

  * DTDHandler Objects

    * "DTDHandler.notationDecl()"

    * "DTDHandler.unparsedEntityDecl()"

  * EntityResolver Objects

    * "EntityResolver.resolveEntity()"

  * ErrorHandler Objects

    * "ErrorHandler.error()"

    * "ErrorHandler.fatalError()"

    * "ErrorHandler.warning()"

  * LexicalHandler Objects

    * "LexicalHandler.comment()"

    * "LexicalHandler.startDTD()"

    * "LexicalHandler.endDTD()"

    * "LexicalHandler.startCDATA()"

    * "LexicalHandler.endCDATA()"

* "xml.sax.saxutils" — SAX Utilities

  * "escape()"

  * "unescape()"

  * "quoteattr()"

  * "XMLGenerator"

  * "XMLFilterBase"

  * "prepare_input_source()"

* "xml.sax.xmlreader" — Interface for XML parsers

  * "XMLReader"

  * "IncrementalParser"

  * "Locator"

  * "InputSource"

  * "AttributesImpl"

  * "AttributesNSImpl"

  * XMLReader Objects

    * "XMLReader.parse()"

    * "XMLReader.getContentHandler()"

    * "XMLReader.setContentHandler()"

    * "XMLReader.getDTDHandler()"

    * "XMLReader.setDTDHandler()"

    * "XMLReader.getEntityResolver()"

    * "XMLReader.setEntityResolver()"

    * "XMLReader.getErrorHandler()"

    * "XMLReader.setErrorHandler()"

    * "XMLReader.setLocale()"

    * "XMLReader.getFeature()"

    * "XMLReader.setFeature()"

    * "XMLReader.getProperty()"

    * "XMLReader.setProperty()"

  * IncrementalParser Objects

    * "IncrementalParser.feed()"

    * "IncrementalParser.close()"

    * "IncrementalParser.reset()"

  * Locator Objects

    * "Locator.getColumnNumber()"

    * "Locator.getLineNumber()"

    * "Locator.getPublicId()"

    * "Locator.getSystemId()"

  * InputSource Objects

    * "InputSource.setPublicId()"

    * "InputSource.getPublicId()"

    * "InputSource.setSystemId()"

    * "InputSource.getSystemId()"

    * "InputSource.setEncoding()"

    * "InputSource.getEncoding()"

    * "InputSource.setByteStream()"

    * "InputSource.getByteStream()"

    * "InputSource.setCharacterStream()"

    * "InputSource.getCharacterStream()"

  * The "Attributes" Interface

    * "Attributes.getLength()"

    * "Attributes.getNames()"

    * "Attributes.getType()"

    * "Attributes.getValue()"

  * The "AttributesNS" Interface

    * "AttributesNS.getValueByQName()"

    * "AttributesNS.getNameByQName()"

    * "AttributesNS.getQNameByName()"

    * "AttributesNS.getQNames()"

* "xml.parsers.expat" — Fast XML parsing using Expat

  * "ExpatError"

  * "error"

  * "XMLParserType"

  * "ErrorString()"

  * "ParserCreate()"

  * XMLParser Objects

    * "xmlparser.Parse()"

    * "xmlparser.ParseFile()"

    * "xmlparser.SetBase()"

    * "xmlparser.GetBase()"

    * "xmlparser.GetInputContext()"

    * "xmlparser.ExternalEntityParserCreate()"

    * "xmlparser.SetParamEntityParsing()"

    * "xmlparser.UseForeignDTD()"

    * "xmlparser.buffer_size"

    * "xmlparser.buffer_text"

    * "xmlparser.buffer_used"

    * "xmlparser.ordered_attributes"

    * "xmlparser.specified_attributes"

    * "xmlparser.ErrorByteIndex"

    * "xmlparser.ErrorCode"

    * "xmlparser.ErrorColumnNumber"

    * "xmlparser.ErrorLineNumber"

    * "xmlparser.CurrentByteIndex"

    * "xmlparser.CurrentColumnNumber"

    * "xmlparser.CurrentLineNumber"

    * "xmlparser.XmlDeclHandler()"

    * "xmlparser.StartDoctypeDeclHandler()"

    * "xmlparser.EndDoctypeDeclHandler()"

    * "xmlparser.ElementDeclHandler()"

    * "xmlparser.AttlistDeclHandler()"

    * "xmlparser.StartElementHandler()"

    * "xmlparser.EndElementHandler()"

    * "xmlparser.ProcessingInstructionHandler()"

    * "xmlparser.CharacterDataHandler()"

    * "xmlparser.UnparsedEntityDeclHandler()"

    * "xmlparser.EntityDeclHandler()"

    * "xmlparser.NotationDeclHandler()"

    * "xmlparser.StartNamespaceDeclHandler()"

    * "xmlparser.EndNamespaceDeclHandler()"

    * "xmlparser.CommentHandler()"

    * "xmlparser.StartCdataSectionHandler()"

    * "xmlparser.EndCdataSectionHandler()"

    * "xmlparser.DefaultHandler()"

    * "xmlparser.DefaultHandlerExpand()"

    * "xmlparser.NotStandaloneHandler()"

    * "xmlparser.ExternalEntityRefHandler()"

  * ExpatError Exceptions

    * "ExpatError.code"

    * "ExpatError.lineno"

    * "ExpatError.offset"

  * Example

  * Content Model Descriptions

  * Expat error constants

    * "codes"

    * "messages"

    * "XML_ERROR_ASYNC_ENTITY"

    * "XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF"

    * "XML_ERROR_BAD_CHAR_REF"

    * "XML_ERROR_BINARY_ENTITY_REF"

    * "XML_ERROR_DUPLICATE_ATTRIBUTE"

    * "XML_ERROR_INCORRECT_ENCODING"

    * "XML_ERROR_INVALID_TOKEN"

    * "XML_ERROR_JUNK_AFTER_DOC_ELEMENT"

    * "XML_ERROR_MISPLACED_XML_PI"

    * "XML_ERROR_NO_ELEMENTS"

    * "XML_ERROR_NO_MEMORY"

    * "XML_ERROR_PARAM_ENTITY_REF"

    * "XML_ERROR_PARTIAL_CHAR"

    * "XML_ERROR_RECURSIVE_ENTITY_REF"

    * "XML_ERROR_SYNTAX"

    * "XML_ERROR_TAG_MISMATCH"

    * "XML_ERROR_UNCLOSED_TOKEN"

    * "XML_ERROR_UNDEFINED_ENTITY"

    * "XML_ERROR_UNKNOWN_ENCODING"

    * "XML_ERROR_UNCLOSED_CDATA_SECTION"

    * "XML_ERROR_EXTERNAL_ENTITY_HANDLING"

    * "XML_ERROR_NOT_STANDALONE"

    * "XML_ERROR_UNEXPECTED_STATE"

    * "XML_ERROR_ENTITY_DECLARED_IN_PE"

    * "XML_ERROR_FEATURE_REQUIRES_XML_DTD"

    * "XML_ERROR_CANT_CHANGE_FEATURE_ONCE_PARSING"

    * "XML_ERROR_UNBOUND_PREFIX"

    * "XML_ERROR_UNDECLARING_PREFIX"

    * "XML_ERROR_INCOMPLETE_PE"

    * "XML_ERROR_XML_DECL"

    * "XML_ERROR_TEXT_DECL"

    * "XML_ERROR_PUBLICID"

    * "XML_ERROR_SUSPENDED"

    * "XML_ERROR_NOT_SUSPENDED"

    * "XML_ERROR_ABORTED"

    * "XML_ERROR_FINISHED"

    * "XML_ERROR_SUSPEND_PE"

    * "XML_ERROR_RESERVED_PREFIX_XML"

    * "XML_ERROR_RESERVED_PREFIX_XMLNS"

    * "XML_ERROR_RESERVED_NAMESPACE_URI"

    * "XML_ERROR_INVALID_ARGUMENT"

    * "XML_ERROR_NO_BUFFER"

    * "XML_ERROR_AMPLIFICATION_LIMIT_BREACH"

vim:tw=78:ts=8:ft=help:norl: