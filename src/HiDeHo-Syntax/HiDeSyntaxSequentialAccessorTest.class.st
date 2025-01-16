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
	self assert: (accessor value: node) equals: 1
]

{ #category : 'tests' }
HiDeSyntaxSequentialAccessorTest >> testValue [

	| node accessor |
	node := 1 -> 2 -> 3.
	accessor := HiDeSyntaxSequentialAccessor
		            with: (HiDeSyntaxSelectorAccessor on: #key)
		            with: (HiDeSyntaxSelectorAccessor on: #value).
	self assert: (accessor value: node) equals: 2
]
