Class {
	#name : 'HiDeSequence',
	#superclass : 'HiDeNode',
	#instVars : [
		'collection'
	],
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeSequence class >> new: anInteger [

	^ self basicNew initialize: anInteger
]

{ #category : 'adding/removing' }
HiDeSequence >> add: aHiDeNode [

	^ collection add: aHiDeNode
]

{ #category : 'adding/removing' }
HiDeSequence >> addAll: aCollectionOfHiDeNode [

	^ collection addAll: aCollectionOfHiDeNode
]

{ #category : 'enumerating' }
HiDeSequence >> do: aBlock [

	collection do: aBlock
]

{ #category : 'initialization' }
HiDeSequence >> initialize [

	super initialize.
	collection := OrderedCollection new
]

{ #category : 'initialization' }
HiDeSequence >> initialize: anInteger [

	super initialize.
	collection := OrderedCollection new: anInteger
]

{ #category : 'enumerating' }
HiDeSequence >> operationsDo: aBlock [

	collection do: [ :node | node operationsDo: aBlock ]
]

{ #category : 'adding/removing' }
HiDeSequence >> remove: aHiDeNode ifAbsent: errorBlock [

	^ collection remove: aHiDeNode ifAbsent: errorBlock
]
