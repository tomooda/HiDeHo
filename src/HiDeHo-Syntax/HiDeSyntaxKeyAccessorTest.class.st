Class {
	#name : 'HiDeSyntaxKeyAccessorTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxKeyAccessorTest >> testConcat [

	| node accessor |
	node := { ('a' -> { ('b' -> 1) } asDictionary) } asDictionary.
	accessor := (HiDeSyntaxKeyAccessor on: 'a')
	            , (HiDeSyntaxKeyAccessor on: 'b').
	self assert: (accessor read: node) equals: 1
]

{ #category : 'tests' }
HiDeSyntaxKeyAccessorTest >> testHead [

	| accessor |
	accessor := HiDeSyntaxKeyAccessor on: 'a'.
	self assert: accessor head equals: accessor
]

{ #category : 'tests' }
HiDeSyntaxKeyAccessorTest >> testTail [

	| accessor |
	accessor := HiDeSyntaxKeyAccessor on: 'a'.
	self assert: accessor tail equals: nil
]

{ #category : 'tests' }
HiDeSyntaxKeyAccessorTest >> testValue [

	| node accessor |
	node := {
		        ('a' -> 1).
		        ('b' -> 2) } asDictionary.
	accessor := HiDeSyntaxKeyAccessor on: 'a'.
	self assert: (accessor read: node) equals: 1
]
