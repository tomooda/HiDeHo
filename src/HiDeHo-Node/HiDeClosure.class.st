Class {
	#name : 'HiDeClosure',
	#superclass : 'HiDeNode',
	#instVars : [
		'collection'
	],
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeClosure class >> new: anInteger [

	^ self basicNew initialize: anInteger
]

{ #category : 'instance creation' }
HiDeClosure class >> with: anObject [

	^ self new
		  add: anObject;
		  yourself
]

{ #category : 'instance creation' }
HiDeClosure class >> with: anObject with: anotherObject [

	^ self new
		  add: anObject;
		  add: anotherObject;
		  yourself
]

{ #category : 'instance creation' }
HiDeClosure class >> with: anObject1 with: anObject2 with: anObject3 [

	^ self new
		  add: anObject1;
		  add: anObject2;
		  add: anObject3;
		  yourself
]

{ #category : 'instance creation' }
HiDeClosure class >> with: anObject1 with: anObject2 with: anObject3 with: anObject4 [

	^ self new
		  add: anObject1;
		  add: anObject2;
		  add: anObject3;
		  add: anObject4;
		  yourself
]

{ #category : 'instance creation' }
HiDeClosure class >> withAll: aCollection [

	^ self new
		  addAll: aCollection;
		  yourself
]

{ #category : 'adding/removing' }
HiDeClosure >> add: anObject [

	^ self addLast: anObject
]

{ #category : 'adding/removing' }
HiDeClosure >> add: anObject beforeIndex: anInteger [

	^ collection
		  ifNotEmpty: [
		  collection add: anObject asHiDeNode beforeIndex: anInteger ]
		  ifEmpty: [ collection add: anObject asHiDeNode ]
]

{ #category : 'adding/removing' }
HiDeClosure >> addAll: aCollection [

	aCollection do: [ :object | self add: object ].
	^ aCollection
]

{ #category : 'adding/removing' }
HiDeClosure >> addLast: anObject [

	^ collection addLast: anObject asHiDeNode
]

{ #category : 'converting' }
HiDeClosure >> asHiDeClosure [

	^ self
]

{ #category : 'converting' }
HiDeClosure >> asHiDeItem [

	^ self error: 'Operation holders should not be nested.'
]

{ #category : 'accessing' }
HiDeClosure >> indexOf: anObject [

	^ self indexOf: anObject ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
HiDeClosure >> indexOf: anObject ifAbsent: errorBlock [

	1 to: self numberOfNodes do: [ :index |
		| node |
		node := self nodeAt: index.
		(node isHiDeItem and: [ node value = anObject ]) ifTrue: [ ^ index ] ].
	^ errorBlock value
]

{ #category : 'accessing' }
HiDeClosure >> indexOfNode: aHiDeNode [

	^ self indexOfNode: aHiDeNode ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
HiDeClosure >> indexOfNode: aHiDeNode ifAbsent: errorBlock [

	^ collection indexOf: aHiDeNode ifAbsent: errorBlock
]

{ #category : 'initialization' }
HiDeClosure >> initialize [

	super initialize.
	collection := OrderedCollection new
]

{ #category : 'initialization' }
HiDeClosure >> initialize: anInteger [

	super initialize.
	collection := OrderedCollection new: anInteger
]

{ #category : 'testing' }
HiDeClosure >> isHiDeClosure [

	^ true
]

{ #category : 'enumerating' }
HiDeClosure >> itemsDo: aBlock [

	self nodesDo: [ :node | node itemsDo: aBlock ]
]

{ #category : 'accessing' }
HiDeClosure >> nodeAt: anInteger [

	^ collection at: anInteger
]

{ #category : 'enumerating' }
HiDeClosure >> nodesDo: aBlock [

	collection do: aBlock
]

{ #category : 'enumerating' }
HiDeClosure >> nodesDo: aBlock separatedBy: anotherBlock [

	self numberOfNodes > 0 ifTrue: [
		1 to: self numberOfNodes - 1 do: [ :index |
			aBlock value: (self nodeAt: index).
			anotherBlock value ].
		aBlock value: (self nodeAt: self numberOfNodes) ]
]

{ #category : 'accessing' }
HiDeClosure >> numberOfNodes [

	^ collection size
]

{ #category : 'printing' }
HiDeClosure >> printOn: aStream [

	aStream nextPut: $(.
	self
		nodesDo: [ :node | node printOn: aStream ]
		separatedBy: [ aStream space ].
	aStream nextPut: $)
]

{ #category : 'adding/removing' }
HiDeClosure >> remove: anObject [

	collection removeAllSuchThat: [ :node |
		node isHiDeItem and: [ node value = anObject ] ].
	collection do: [ :node | node remove: anObject ].
	^ anObject
]

{ #category : 'adding/removing' }
HiDeClosure >> removeAllItems: aCollectionOfHiDeNode [

	collection removeAll: aCollectionOfHiDeNode.
	^ aCollectionOfHiDeNode
]

{ #category : 'adding/removing' }
HiDeClosure >> removeAllNodes: aCollectionOfHiDeNode [

	collection removeAll: aCollectionOfHiDeNode.
	^ aCollectionOfHiDeNode
]

{ #category : 'adding/removing' }
HiDeClosure >> removeItem: aHiDeNode ifAbsent: errorBlock [

	^ collection remove: aHiDeNode ifAbsent: errorBlock
]
