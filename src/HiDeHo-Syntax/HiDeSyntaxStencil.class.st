Class {
	#name : 'HiDeSyntaxStencil',
	#superclass : 'Object',
	#traits : 'THiDeSyntaxTree',
	#classTraits : 'THiDeSyntaxTree classTrait',
	#instVars : [
		'node',
		'accessors'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeSyntaxStencil class >> node: anObject accessors: anArrayOfHiDeSyntaxAccessor [

	^ self new
		  node: anObject;
		  accessors: anArrayOfHiDeSyntaxAccessor;
		  yourself
]

{ #category : 'accessing' }
HiDeSyntaxStencil >> accessors [

	^ accessors
]

{ #category : 'accessing' }
HiDeSyntaxStencil >> accessors: anArrayOfHiDeSyntaxAccessor [

	accessors := anArrayOfHiDeSyntaxAccessor
]

{ #category : 'accessing' }
HiDeSyntaxStencil >> at: aHiDeSyntaxAccessor [

	| tails |
	tails := OrderedCollection new: accessors size.
	accessors do: [ :accessor |
		accessor head ifNotNil: [ :head |
			aHiDeSyntaxAccessor = head ifTrue: [
				accessor tail ifNotNil: [ :tail | tails add: tail ] ] ] ].
	^ tails
		  ifNotEmpty: [
			  self class
				  node: (aHiDeSyntaxAccessor read: node)
				  accessors: tails asArray ]
		  ifEmpty: [ aHiDeSyntaxAccessor read: node ]
]

{ #category : 'accessing' }
HiDeSyntaxStencil >> node [

	^ node
]

{ #category : 'accessing' }
HiDeSyntaxStencil >> node: anObject [

	node := anObject
]

{ #category : 'enumerating' }
HiDeSyntaxStencil >> syntaxAccessorsDo: aBlock [

	| done |
	done := Set new: accessors size.
	accessors do: [ :accessor |
		accessor head ifNotNil: [ :head |
			(done includes: head) ifFalse: [
				aBlock value: (HiDeSyntaxKeyAccessor on: head).
				done add: head ] ] ]
]
