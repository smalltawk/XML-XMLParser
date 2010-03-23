Class {
	#name : #XMLOpenTags,
	#superclass : #Object,
	#instVars : [
		'tags'
	],
	#category : #'XML-Parser-Parser'
}

{ #category : #accessing }
XMLOpenTags >> closeTag: aTagName [
	(self enclosingTag = aTagName)
		ifFalse: [
			(self hasOpenTag: aTagName)
				ifTrue: [
					self error:
						('<{1}> tag closed before enclosed tags {2}'
							format: (Array with: aTagName with: (self enclosedTagsAsString: aTagName)))]
				ifFalse: [
					self error:
						('Closing </{1}> tag without corresponding opening <{1}> tag'
							format: (Array with: aTagName))]].
	^ self tags removeLast.
]

{ #category : #printing }
XMLOpenTags >> enclosedTagsAsString: aTagName [
	| stream |

	stream := String new writeStream..
	self
		printOn: stream
		startingAt: (self tags lastIndexOf: aTagName) + 1.
	^ stream contents.
]

{ #category : #accessing }
XMLOpenTags >> enclosingTag [
	^ self tags
		at: self totalOpen
		ifAbsent: ['']
]

{ #category : #testing }
XMLOpenTags >> hasOpenTag: aTagName [
	^ self tags includes: aTagName
]

{ #category : #testing }
XMLOpenTags >> hasOpenTags [
	^ self tags notEmpty
]

{ #category : #accessing }
XMLOpenTags >> maxTagsToPrint [
	^ 5
]

{ #category : #accessing }
XMLOpenTags >> openTag: aTagName [
	^ self tags addLast: aTagName
]

{ #category : #printing }
XMLOpenTags >> printOn: aStream [
	self printOn: aStream startingAt: 1
]

{ #category : #printing }
XMLOpenTags >> printOn: aStream startingAt: aPosition [
	| endPosition |

	endPosition :=  self totalOpen min: (aPosition + self maxTagsToPrint - 1).
	(self tags copyFrom: aPosition to: endPosition)
		do: [:each |
			aStream
				nextPut: $<;
				nextPutAll: each;
				nextPut: $>]
		separatedBy: [aStream nextPutAll: ', '].
	(endPosition < self totalOpen)
		ifTrue: [aStream nextPutAll: '...'].
]

{ #category : #accessing }
XMLOpenTags >> tags [
	^ tags ifNil: [tags := OrderedCollection new: 30]
]

{ #category : #accessing }
XMLOpenTags >> totalOpen [
	^ self tags size
	
]