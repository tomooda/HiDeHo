Class {
	#name : 'HiDeSyntaxRootAccessorTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
HiDeSyntaxRootAccessorTest >> testConcat [

	| node accessor |
	node := { ('a' -> 1) } asDictionary.
	accessor := HiDeSyntaxRootAccessor current
	            , (HiDeSyntaxKeyAccessor on: 'a').
	self assert: (accessor value: node) equals: 1
]

{ #category : 'tests' }
HiDeSyntaxRootAccessorTest >> testHead [

	| accessor |
	accessor := HiDeSyntaxRootAccessor current.
	self assert: accessor head equals: accessor
]

{ #category : 'tests' }
HiDeSyntaxRootAccessorTest >> testTail [

	| accessor |
	accessor := HiDeSyntaxRootAccessor current.
	self assert: accessor tail equals: nil
]

{ #category : 'as yet unclassified' }
HiDeSyntaxRootAccessorTest >> testValue [

	| node accessor |
	node := {
		        ('a' -> 1).
		        ('b' -> 2) } asDictionary.
	accessor := HiDeSyntaxRootAccessor current.
	self assert: (accessor value: node) equals: node
]
