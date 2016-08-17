"
This class is a SAX2 handler for individual elements to be used with a SAX2ElementParser. Unlike a SAX2ContentHandler, element handlers are created by SAX2ElementParsers to handle each element in the document and only handle the #startElement*, #endElement*, and #characters: events.

The parser can be accessed with #parser, and the parent element handler (if any) can be accessed with #parent.
"
Class {
	#name : #SAX2ElementHandler,
	#superclass : #Object,
	#instVars : [
		'parser',
		'parent',
		'elementHandlerFactory'
	],
	#category : #'XML-Parser'
}

{ #category : #accessing }
SAX2ElementHandler class >> elementHandlerFactory [
	^ nil
]

{ #category : #'instance creation' }
SAX2ElementHandler class >> parser: aParser parent: anElementHandler [
	^ self new
		parser: aParser;
		parent: anElementHandler
]

{ #category : #accessing }
SAX2ElementHandler >> characters [
	"This handler ignores #characters: events, so this always returns
	an empty string."

	^ ''
]

{ #category : #'handling - content' }
SAX2ElementHandler >> characters: aString [
	"Handles character data in an element, such as the 'test' in
	'<characters>test</characters>' or in the CDATA section '<![CDATA[test]]>'.
	
	It may be sent multiple times for different sections of character data
	in a single element if they're separated by other nodes or entity
	references like in '<characters>one<!--comment-->two</characters>'.
	
	See isInCDataSection and ignorableWhitespace:"
]

{ #category : #accessing }
SAX2ElementHandler >> elementHandlerFactory [
	^ elementHandlerFactory
]

{ #category : #accessing }
SAX2ElementHandler >> elementHandlerFactory: anElementHandlerFactory [
	elementHandlerFactory := anElementHandlerFactory
]

{ #category : #'handling - content' }
SAX2ElementHandler >> endElement: aQualifiedName [
	"Handles the end of an element if a subclass doesn't implement
	endElement:prefix:uri:localName: or endElement:prefix:uri:."
]

{ #category : #'handling - content' }
SAX2ElementHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI [
	"Handles the end of an element if a subclass doesn't implement
	endElement:prefix:uri:localName:. By default it forwards to a simpler
	handler, endElement:.
	
	aQualifiedName - the full name, including any prefix, such as 'prefix:name'
	aPrefix - the prefix of the qualified name or an empty string
	aURI - the namespace URI of the element or an empty string"

	self endElement: aQualifiedName
]

{ #category : #'handling - content' }
SAX2ElementHandler >> endElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName [
	"Handles the end of an element, either an end tag like '</end>' or a
	self-closed tag like '<empty/>'. By default it forwards to a simpler handler,
	endElement:prefix:uri:.
	
	aQualifiedName - the full name, including any prefix, such as 'prefix:name'
	aPrefix - the prefix of the qualified name or an empty string
	aURI - the namespace URI of the element or an empty string
	aLocalName - the local part of the qualified name"

	self
		endElement: aQualifiedName
		prefix: aPrefix
		uri:  aURI
]

{ #category : #testing }
SAX2ElementHandler >> isHandlingRootElement [
	^ self parent isNil
]

{ #category : #accessing }
SAX2ElementHandler >> parent [
	"Returns the parent element handler or nil if there isn't one (if
	this element handler is handling the root element)."

	^ parent
]

{ #category : #accessing }
SAX2ElementHandler >> parent: anElementHandler [
	parent := anElementHandler
]

{ #category : #accessing }
SAX2ElementHandler >> parser [
	"Returns the SAX2ElementParser"

	^ parser
]

{ #category : #accessing }
SAX2ElementHandler >> parser: aParser [
	parser := aParser
]

{ #category : #'handling - content' }
SAX2ElementHandler >> startElement: aQualifiedName attributes: aDictionary [
	"Handles the start of an element if a subclass doesn't implement
	startElement:prefix:uri:localName:attributes: or
	startElement:prefix:uri:attributes:.

	aQualifiedName - the full name, including any prefix, such as 'prefix:name'
	aDictionary - an OrderPreservingStringDictionary of attributes"
]

{ #category : #'handling - content' }
SAX2ElementHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI attributes: aDictionary [
	"Handles the start of an element if a subclass doesn't implement
	startElement:prefix:uri:localName:attributes:. By default it forwards
	to a simpler handler, startElement:attributes:.
	
	aQualifiedName - the full name, including any prefix, such as 'prefix:name'
	aPrefix - the prefix of the qualified name or an empty string
	aURI - the namespace URI of the element or an empty string
	aDictionary - an OrderPreservingStringDictionary of attributes"

	self
		startElement: aQualifiedName
		attributes: aDictionary
]

{ #category : #'handling - content' }
SAX2ElementHandler >> startElement: aQualifiedName prefix: aPrefix uri: aURI localName: aLocalName attributes: aDictionary [
	"Handles the start of an element, either a start tag like '<start>' or a
	self-closed tag like '<empty/>'. By default it forwards to a simpler handler,
	startElement:prefix:uri:attributes:.
	
	aQualifiedName - the full name, including any prefix, such as 'prefix:name'
	aPrefix - the prefix of the qualified name or an empty string
	aURI - the namespace URI of the element or an empty string
	aLocalName - the local part of the qualified name
	aDictionary - an OrderPreservingStringDictionary of attributes"

	self
		startElement: aQualifiedName
		prefix: aPrefix
		uri: aURI
		attributes: aDictionary
]