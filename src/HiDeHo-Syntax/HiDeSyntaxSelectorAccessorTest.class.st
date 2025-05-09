Class {
	#name : 'HiDeSyntaxSelectorAccessorTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxSelectorAccessorTest >> testConcat [

	| node accessor |
	node := { ('a' -> 1) } asDictionary -> 0.
	accessor := (HiDeSyntaxSelectorAccessor on: #key)
	            , (HiDeSyntaxKeyAccessor on: 'a').
	self assert: (accessor read: node) equals: 1
]

{ #category : 'tests' }
HiDeSyntaxSelectorAccessorTest >> testHead [

	| accessor |
	accessor := HiDeSyntaxSelectorAccessor on: #key.
	self assert: accessor head equals: accessor
]

{ #category : 'tests' }
HiDeSyntaxSelectorAccessorTest >> testTail [

	| accessor |
	accessor := HiDeSyntaxSelectorAccessor on: #key.
	self assert: accessor tail equals: nil
]

{ #category : 'tests' }
HiDeSyntaxSelectorAccessorTest >> testValue [

	| node accessor |
	node := 1 -> 2.
	accessor := HiDeSyntaxSelectorAccessor on: #key.
	self assert: (accessor read: node) equals: 1
]
