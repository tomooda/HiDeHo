Class {
	#name : 'HiDeSyntaxComparatorTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Syntax-Tests',
	#package : 'HiDeHo-Syntax',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSyntaxComparatorTest >> testIntersectionsDoAdditionsDoDeletionsDo [

	| inter add del |
	inter := Set new.
	add := Set new.
	del := Set new.
	(HiDeSyntaxComparator
		 from: {
				 ('a' -> { ('aa' -> 1) } asHiDeSyntaxDictionary).
				 ('b' -> 2).
				 ('d' -> {
					  ('d1' -> 1).
					  ('d2' -> 2) } asHiDeSyntaxDictionary) } asHiDeSyntaxDictionary
		 to: {
				 ('a' -> { ('aa' -> 1) } asHiDeSyntaxDictionary).
				 ('c' -> 3).
				 ('d' -> {
					  ('d1' -> 1).
					  ('d2' -> 0) } asHiDeSyntaxDictionary) } asHiDeSyntaxDictionary)
		intersectionsDo: [ :a | inter add: a ]
		additionsDo: [ :a | add add: a ]
		deletionsDo: [ :a | del add: a ].
	self assert: inter equals: {
			(HiDeSyntaxKeyAccessor on: 'a').
			((HiDeSyntaxKeyAccessor on: 'd') , (HiDeSyntaxKeyAccessor on: 'd1')) }
			asSet.
	self assert: add equals: {
			(HiDeSyntaxKeyAccessor on: 'c').
			((HiDeSyntaxKeyAccessor on: 'd') , (HiDeSyntaxKeyAccessor on: 'd2')) }
			asSet.
	self assert: del equals: {
			(HiDeSyntaxKeyAccessor on: 'b').
			((HiDeSyntaxKeyAccessor on: 'd') , (HiDeSyntaxKeyAccessor on: 'd2')) }
			asSet
]
