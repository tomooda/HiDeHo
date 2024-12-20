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

{ #category : 'instance creation' }
HiDeSequence class >> with: aHiDeNode [

	^ self new
		  add: aHiDeNode;
		  yourself
]

{ #category : 'adding/removing' }
HiDeSequence >> add: aHiDeNode [

	^ collection add: aHiDeNode
]

{ #category : 'adding/removing' }
HiDeSequence >> addAll: aCollectionOfHiDeNode [

	aCollectionOfHiDeNode do: [ :node | collection addLast: node ].
	^ aCollectionOfHiDeNode
]

{ #category : 'accessing' }
HiDeSequence >> at: anInteger [

	^ collection at: anInteger
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

{ #category : 'testing' }
HiDeSequence >> isSequence [

	^ true
]

{ #category : 'enumerating' }
HiDeSequence >> operationHoldersDo: aBlock [

	collection do: [ :node | node operationHoldersDo: aBlock ]
]

{ #category : 'enumerating' }
HiDeSequence >> operationsDo: aBlock [

	collection do: [ :node | node operationsDo: aBlock ]
]

{ #category : 'adding/removing' }
HiDeSequence >> remove: aHiDeNode ifAbsent: errorBlock [

	^ collection remove: aHiDeNode ifAbsent: errorBlock
]

{ #category : 'adding/removing' }
HiDeSequence >> removeOperation: anObject [

	collection removeAllSuchThat: [ :node |
		node isOperationHolder and: [ node value = anObject ] ].
	collection do: [ :node | node removeOperation: anObject ].
	^ anObject
]

{ #category : 'accessing' }
HiDeSequence >> size [

	^ collection size
]
