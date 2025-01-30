Trait {
	#name : 'THiDeItem',
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'enumerating' }
THiDeItem >> allNodesSatisfy: aBlock [

	self nodesDo: [ :node | (aBlock value: node) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'enumerating' }
THiDeItem >> allSatisfy: aBlock [

	self do: [ :object |
		(aBlock value: object) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'enumerating' }
THiDeItem >> anyNodeSatisfy: aBlock [

	self nodesDo: [ :node | (aBlock value: node) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'enumerating' }
THiDeItem >> anySatisfy: aBlock [

	self do: [ :object | (aBlock value: object) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'converting' }
THiDeItem >> asHiDeClosure [

	^ HiDeClosure with: self
]

{ #category : 'converting' }
THiDeItem >> asHiDeItem [

	^ self
]

{ #category : 'converting' }
THiDeItem >> asHiDeNode [

	^ self
]

{ #category : 'enumerating' }
THiDeItem >> do: aBlock [

	self itemsDo: [ :holder | aBlock value: holder value ]
]

{ #category : 'testing' }
THiDeItem >> identityIncludes: anObject [

	^ self anySatisfy: [ :object | object == anObject ]
]

{ #category : 'testing' }
THiDeItem >> includes: anObject [

	^ self anySatisfy: [ :object | object = anObject ]
]

{ #category : 'testing' }
THiDeItem >> isHiDeClosure [

	^ false
]

{ #category : 'testing' }
THiDeItem >> isHiDeItem [

	^ true
]

{ #category : 'enumerating' }
THiDeItem >> itemsDo: aBlock [

	aBlock value: self
]

{ #category : 'enumerating' }
THiDeItem >> nodesDo: aBlock [

	aBlock value: self
]

{ #category : 'accessing' }
THiDeItem >> numberOfNodes [

	^ 1
]

{ #category : 'adding/removing' }
THiDeItem >> remove: anObject [

	
]

{ #category : 'enumerating' }
THiDeItem >> select: aBlock [

	^ Array streamContents: [ :stream |
		  self do: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : 'enumerating' }
THiDeItem >> selectNodes: aBlock [

	^ Array streamContents: [ :stream |
		  self nodesDo: [ :node |
			  (aBlock value: node) ifTrue: [ stream nextPut: node ] ] ]
]

{ #category : 'accessing' }
THiDeItem >> size [

	^ 1
]

{ #category : 'accessing' }
THiDeItem >> value [

	^ self
]
