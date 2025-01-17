Class {
	#name : 'HiDeSyntaxComparator',
	#superclass : 'Object',
	#instVars : [
		'node1',
		'node2'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeSyntaxComparator class >> from: anObject to: anotherObject [

	^ self new
		  node1: anObject;
		  node2: anotherObject;
		  yourself
]

{ #category : 'enumerating' }
HiDeSyntaxComparator >> accessor: aHiDeSyntaxAccessor intersectionsDo: aBlock additionsDo: additionBlock deletionsDo: deletionBlock [

	| n1 n2 set1 set2 |
	n1 := aHiDeSyntaxAccessor value: node1.
	n2 := aHiDeSyntaxAccessor value: node2.
	n1 = n2 ifTrue: [
		aBlock value: aHiDeSyntaxAccessor.
		^ self ].
	(n1 isHiDeSyntaxTree not or: [ n2 isHiDeSyntaxTree not ]) ifTrue: [
		deletionBlock value: aHiDeSyntaxAccessor.
		additionBlock value: aHiDeSyntaxAccessor.
		^ self ].
	set1 := (Array streamContents: [ :stream |
		         n1 syntaxAccessorsDo: [ :accessor |
			         stream nextPut: accessor ] ]) asSet.
	set2 := (Array streamContents: [ :stream |
		         n2 syntaxAccessorsDo: [ :accessor |
			         stream nextPut: accessor ] ]) asSet.
	n1 syntaxAccessorsDo: [ :accessor |
		(set2 includes: accessor)
			ifTrue: [
				self
					accessor: aHiDeSyntaxAccessor , accessor
					intersectionsDo: aBlock
					additionsDo: additionBlock
					deletionsDo: deletionBlock ]
			ifFalse: [ deletionBlock value: aHiDeSyntaxAccessor , accessor ] ].
	n2 syntaxAccessorsDo: [ :accessor |
		(set1 includes: accessor) ifFalse: [
			additionBlock value: aHiDeSyntaxAccessor , accessor ] ]
]

{ #category : 'enumerating' }
HiDeSyntaxComparator >> intersectionsDo: aBlock additionsDo: additionBlock deletionsDo: deletionBlock [

	| set1 set2 |
	node1 = node2 ifTrue: [
		aBlock value: HiDeSyntaxRootAccessor current.
		^ self ].
	(node1 isHiDeSyntaxTree not or: [ node2 isHiDeSyntaxTree not ])
		ifTrue: [
			deletionBlock value: HiDeSyntaxRootAccessor current.
			additionBlock value: HiDeSyntaxRootAccessor current.
			^ self ].
	set1 := (Array streamContents: [ :stream |
		         node1 syntaxAccessorsDo: [ :accessor |
			         stream nextPut: accessor ] ]) asSet.
	set2 := (Array streamContents: [ :stream |
		         node2 syntaxAccessorsDo: [ :accessor |
			         stream nextPut: accessor ] ]) asSet.
	node1 syntaxAccessorsDo: [ :accessor |
		(set2 includes: accessor)
			ifTrue: [
				self
					accessor: accessor
					intersectionsDo: aBlock
					additionsDo: additionBlock
					deletionsDo: deletionBlock ]
			ifFalse: [ deletionBlock value: accessor ] ].
	node2 syntaxAccessorsDo: [ :accessor |
		(set1 includes: accessor) ifFalse: [ additionBlock value: accessor ] ]
]

{ #category : 'accessing' }
HiDeSyntaxComparator >> node1 [

	^ node1
]

{ #category : 'accessing' }
HiDeSyntaxComparator >> node1: anObject [

	node1 := anObject
]

{ #category : 'accessing' }
HiDeSyntaxComparator >> node2 [

	^ node2
]

{ #category : 'accessing' }
HiDeSyntaxComparator >> node2: anObject [

	node2 := anObject
]
