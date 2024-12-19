Class {
	#name : 'HiDeSequence',
	#superclass : 'HiDeNode',
	#instVars : [
		'collection'
	],
	#category : 'HiDeHo-Node',
	#package : 'HiDeHo-Node'
}

{ #category : 'adding/removing' }
HiDeSequence >> add: aHiDeNode [

	^ collection add: aHiDeNode
]

{ #category : 'enumerating' }
HiDeSequence >> allSatisfy: aBlock [

	^ collection allSatisfy: [ :node | node allSatisfy: aBlock ]
]

{ #category : 'enumerating' }
HiDeSequence >> anySatisfy: aBlock [

	^ collection anySatisfy: [ :node | node anySatisfy: aBlock ]
]

{ #category : 'enumerating' }
HiDeSequence >> do: aBlock [

	collection do: aBlock
]

{ #category : 'accessing' }
HiDeSequence >> impacts [

	| impacts |
	impacts := Set new.
	self do: [ :node | impacts addAll: node impacts ].
	^ impacts
]

{ #category : 'initialization' }
HiDeSequence >> initialize [

	super initialize.
	collection := OrderedCollection new
]

{ #category : 'adding/removing' }
HiDeSequence >> remove: aHiDeNode ifAbsent: errorBlock [

	^ collection remove: aHiDeNode ifAbsent: errorBlock
]
