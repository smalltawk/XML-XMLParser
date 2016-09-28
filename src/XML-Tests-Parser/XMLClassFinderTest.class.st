Class {
	#name : #XMLClassFinderTest,
	#superclass : #TestCase,
	#category : #'XML-Tests-Parser-Utils'
}

{ #category : #accessing }
XMLClassFinderTest >> absentClassName [
	^ (self presentClassName asString, 'ShouldNotBePresent') asString
]

{ #category : #accessing }
XMLClassFinderTest >> classFinder [
	^ XMLClassFinder
]

{ #category : #accessing }
XMLClassFinderTest >> presentClass [
	^ self class
]

{ #category : #accessing }
XMLClassFinderTest >> presentClassName [
	^ self class name asSymbol
]

{ #category : #tests }
XMLClassFinderTest >> testClassNamed [
	self assert:
		(self classFinder classNamed: self presentClassName) ==
			self presentClass.
	self assert: (self classFinder classNamed: self absentClassName) isNil.
]

{ #category : #tests }
XMLClassFinderTest >> testClassNamedIfAbsent [
	self assert:
		(self classFinder
			classNamed: self presentClassName
			ifAbsent: [self fail]) == self presentClass.
	self assert:
		(self classFinder
			classNamed: self absentClassName
			ifAbsent: [#absent]) = #absent.
]

{ #category : #tests }
XMLClassFinderTest >> testHasClassNamed [
	self
		assert: (self classFinder hasClassNamed: self presentClassName);
		deny: (self classFinder hasClassNamed: self absentClassName)
]