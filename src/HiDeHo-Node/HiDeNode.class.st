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
HiDeNode >> allOperationsSatisfy: aBlock [

	self operationsDo: [ :node |
		(aBlock value: node) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'enumerating' }
HiDeNode >> allSatisfy: aBlock [

	self do: [ :node | (aBlock value: node) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'enumerating' }
HiDeNode >> anyOperationSatisfy: aBlock [

	self operationsDo: [ :node | (aBlock value: node) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'enumerating' }
HiDeNode >> anySatisfy: aBlock [

	self do: [ :node | (aBlock value: node) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'enumerating' }
HiDeNode >> do: aBlock [

	^ self subclassResponsibility
]

{ #category : 'testing' }
HiDeNode >> includesOperation: anObject [

	^ self anyOperationSatisfy: [ :operation |
		  operation value = anObject ]
]

{ #category : 'testing' }
HiDeNode >> isOperationHolder [

	^ false
]

{ #category : 'testing' }
HiDeNode >> isSequence [

	^ false
]

{ #category : 'accessing' }
HiDeNode >> numberOfOperations [

	| num |
	num := 0.
	self operationsDo: [ :operation | num := num + 1 ].
	^ num
]

{ #category : 'enumerating' }
HiDeNode >> operationHoldersDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
HiDeNode >> operationsDo: aBlock [

	self operationHoldersDo: [ :holder | aBlock value: holder operation ]
]

{ #category : 'adding/removing' }
HiDeNode >> removeOperation: aHiDeAbstractOperation [

	^ self subclassResponsibility
]
