Class {
	#name : 'HiDeNode',
	#superclass : 'Object',
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'testing' }
HiDeNode class >> isAbstract [

	^ self == HiDeNode
]

{ #category : 'enumerating' }
HiDeNode >> allNodesSatisfy: aBlock [

	self nodesDo: [ :node | (aBlock value: node) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'enumerating' }
HiDeNode >> allSatisfy: aBlock [

	self do: [ :object |
		(aBlock value: object) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'enumerating' }
HiDeNode >> anyNodeSatisfy: aBlock [

	self nodesDo: [ :node | (aBlock value: node) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'enumerating' }
HiDeNode >> anySatisfy: aBlock [

	self do: [ :object | (aBlock value: object) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'converting' }
HiDeNode >> asHiDeNode [

	^ self
]

{ #category : 'enumerating' }
HiDeNode >> do: aBlock [

	self itemsDo: [ :holder | aBlock value: holder value ]
]

{ #category : 'testing' }
HiDeNode >> identityIncludes: anObject [

	^ self anySatisfy: [ :object | object == anObject ]
]

{ #category : 'testing' }
HiDeNode >> includes: anObject [

	^ self anySatisfy: [ :object | object = anObject ]
]

{ #category : 'testing' }
HiDeNode >> isHiDeClosure [

	^ false
]

{ #category : 'testing' }
HiDeNode >> isHiDeItem [

	^ false
]

{ #category : 'enumerating' }
HiDeNode >> itemsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
HiDeNode >> nodesDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeNode >> numberOfNodes [

	| num |
	num := 0.
	self nodesDo: [ :node | num := num + 1 ].
	^ num
]

{ #category : 'adding/removing' }
HiDeNode >> remove: aHiDeAbstractOperation [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
HiDeNode >> select: aBlock [

	^ Array streamContents: [ :stream |
		  self do: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : 'enumerating' }
HiDeNode >> selectNodes: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : 'accessing' }
HiDeNode >> size [

	| num |
	num := 0.
	self do: [ :object | num := num + 1 ].
	^ num
]
