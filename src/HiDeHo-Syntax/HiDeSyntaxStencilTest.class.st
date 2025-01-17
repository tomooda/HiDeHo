Class {
	#name : 'HiDeSyntaxStencilTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxStencilTest >> testAccessorsDo [

	| node accessors a c |
	node := HiDeSyntaxStencil
		        node: {
				        ('a' -> {
					         ('a1' -> 1).
					         ('a2' -> 2).
					         ('a3' -> 3) } asHiDeSyntaxDictionary).
				        ('b' -> 4).
				        ('c' -> 5) } asHiDeSyntaxDictionary
		        accessors: {
				        ((HiDeSyntaxKeyAccessor on: 'a')
				         , (HiDeSyntaxKeyAccessor on: 'a1')).
				        ((HiDeSyntaxKeyAccessor on: 'a')
				         , (HiDeSyntaxKeyAccessor on: 'a2')).
				        (HiDeSyntaxKeyAccessor on: 'c') }.
	accessors := Array streamContents: [ :stream |
		             node syntaxAccessorsDo: [ :accessor |
			             stream nextPut: accessor ] ].
	self assert: accessors size equals: 2.
	a := accessors first value: node.
	self assert: a node identicalTo: (node node at: 'a').
	self assert: a accessors equals: {
			(HiDeSyntaxKeyAccessor on: 'a1').
			(HiDeSyntaxKeyAccessor on: 'a2') }.
	self
		assert: (Array streamContents: [ :stream |
				 a syntaxAccessorsDo: [ :accessor |
					 stream nextPut: (accessor value: a) ] ])
		equals: { 1. 2 }.
	c := accessors second value: node.
	self assert: c equals: 5
]
