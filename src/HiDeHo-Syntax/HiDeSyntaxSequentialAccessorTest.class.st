Class {
	#name : 'HiDeSyntaxSequentialAccessorTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxSequentialAccessorTest >> testConcat [

	| node accessor |
	node := { ('b' -> ({ ('a' -> 1) } asDictionary -> 0)) } asDictionary.
	accessor := (HiDeSyntaxSequentialAccessor
		             with: (HiDeSyntaxKeyAccessor on: 'b')
		             with: (HiDeSyntaxSelectorAccessor on: #key))
	            , (HiDeSyntaxKeyAccessor on: 'a').
	self assert: (accessor read: node) equals: 1
]

{ #category : 'tests' }
HiDeSyntaxSequentialAccessorTest >> testHead [

	| accessor |
	accessor := HiDeSyntaxSequentialAccessor
		            with: (HiDeSyntaxSelectorAccessor on: #key)
		            with: (HiDeSyntaxSelectorAccessor on: #value).
	self
		assert: accessor head
		equals: (HiDeSyntaxSelectorAccessor on: #key)
]

{ #category : 'tests' }
HiDeSyntaxSequentialAccessorTest >> testTail [

	| accessor |
	accessor := HiDeSyntaxSequentialAccessor
		            with: (HiDeSyntaxKeyAccessor on: 'a')
		            with: (HiDeSyntaxKeyAccessor on: 'b')
		            with: (HiDeSyntaxKeyAccessor on: 'c').
	accessor := accessor tail.
	self assert: accessor equals: (HiDeSyntaxSequentialAccessor
			 with: (HiDeSyntaxKeyAccessor on: 'b')
			 with: (HiDeSyntaxKeyAccessor on: 'c')).
	accessor := accessor tail.
	self assert: accessor equals: (HiDeSyntaxKeyAccessor on: 'c').
	accessor := accessor tail.
	self assert: accessor equals: nil
]

{ #category : 'tests' }
HiDeSyntaxSequentialAccessorTest >> testValue [

	| node accessor |
	node := 1 -> 2 -> 3.
	accessor := HiDeSyntaxSequentialAccessor
		            with: (HiDeSyntaxSelectorAccessor on: #key)
		            with: (HiDeSyntaxSelectorAccessor on: #value).
	self assert: (accessor read: node) equals: 2
]
