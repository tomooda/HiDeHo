Class {
	#name : 'HiDeSyntaxRootAccessorTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxRootAccessorTest >> testConcat [

	| node accessor |
	node := { ('a' -> 1) } asDictionary.
	accessor := HiDeSyntaxRootAccessor current
	            , (HiDeSyntaxKeyAccessor on: 'a').
	self assert: (accessor read: node) equals: 1
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

{ #category : 'tests' }
HiDeSyntaxRootAccessorTest >> testValue [

	| node accessor |
	node := {
		        ('a' -> 1).
		        ('b' -> 2) } asDictionary.
	accessor := HiDeSyntaxRootAccessor current.
	self assert: (accessor read: node) equals: node
]
