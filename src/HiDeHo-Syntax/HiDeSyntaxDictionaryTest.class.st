Class {
	#name : 'HiDeSyntaxDictionaryTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxDictionaryTest >> testIntersectionWith [

	| node1 node2 |
	node1 := {
		         ('a' -> {
			          ('a1' -> 1).
			          ('a2' -> 2).
			          ('a3' -> 3) } asHiDeSyntaxDictionary).
		         ('b' -> 10) } asHiDeSyntaxDictionary.
	node2 := {
		         ('a' -> {
			          ('a1' -> 1).
			          ('a2' -> 3) } asHiDeSyntaxDictionary).
		         ('c' -> 3) } asHiDeSyntaxDictionary.
	self
		assert: (node1 intersectionWith: node2)
		equals: { ('a' -> { ('a1' -> 1) } asHiDeSyntaxDictionary) }
				asHiDeSyntaxDictionary
]
