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
HiDeSequence class >> with: anObject [

	^ self new
		  add: anObject;
		  yourself
]

{ #category : 'instance creation' }
HiDeSequence class >> with: anObject with: anotherObject [

	^ self new
		  add: anObject;
		  add: anotherObject;
		  yourself
]

{ #category : 'instance creation' }
HiDeSequence class >> with: anObject1 with: anObject2 with: anObject3 [

	^ self new
		  add: anObject1;
		  add: anObject2;
		  add: anObject3;
		  yourself
]

{ #category : 'instance creation' }
HiDeSequence class >> with: anObject1 with: anObject2 with: anObject3 with: anObject4 [

	^ self new
		  add: anObject1;
		  add: anObject2;
		  add: anObject3;
		  add: anObject4;
		  yourself
]

{ #category : 'instance creation' }
HiDeSequence class >> withAll: aCollection [

	^ self new
		  addAll: aCollection;
		  yourself
]

{ #category : 'adding/removing' }
HiDeSequence >> add: anObject [

	^ collection add: anObject asHiDeNode
]

{ #category : 'adding/removing' }
HiDeSequence >> add: anObject beforeIndex: anInteger [

	^ collection add: anObject asHiDeNode beforeIndex: anInteger
]

{ #category : 'adding/removing' }
HiDeSequence >> addAll: aCollection [

	aCollection do: [ :object | collection addLast: object asHiDeNode ].
	^ aCollection
]

{ #category : 'converting' }
HiDeSequence >> asHiDeOperationHolder [

	^ self error: 'Operation holders should not be nested.'
]

{ #category : 'converting' }
HiDeSequence >> asHiDeSequence [

	^ self
]

{ #category : 'accessing' }
HiDeSequence >> at: anInteger [

	^ collection at: anInteger
]

{ #category : 'enumerating' }
HiDeSequence >> do: aBlock [

	collection do: aBlock
]

{ #category : 'enumerating' }
HiDeSequence >> do: aBlock separatedBy: anotherBlock [

	1 to: self size - 1 do: [ :index |
		aBlock value: (self at: index).
		anotherBlock value ].
	aBlock value: (self at: self size)
]

{ #category : 'accessing' }
HiDeSequence >> indexOf: aHiDeNode [

	^ collection indexOf: aHiDeNode
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

{ #category : 'printing' }
HiDeSequence >> printOn: aStream [

	aStream nextPut: $(.
	self
		do: [ :node | node printOn: aStream ]
		separatedBy: [ aStream space ].
	aStream nextPut: $)
]

{ #category : 'adding/removing' }
HiDeSequence >> remove: aHiDeNode ifAbsent: errorBlock [

	^ collection remove: aHiDeNode ifAbsent: errorBlock
]

{ #category : 'adding/removing' }
HiDeSequence >> removeAll: aCollectionOfHiDeNode [

	collection removeAll: aCollectionOfHiDeNode.
	^ aCollectionOfHiDeNode
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
