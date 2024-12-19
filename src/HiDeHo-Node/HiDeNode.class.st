Class {
	#name : 'HiDeNode',
	#superclass : 'Object',
	#category : 'HiDeHo-Node',
	#package : 'HiDeHo-Node'
}

{ #category : 'testing' }
HiDeNode class >> isAbstract [

	^ self == HiDeNode
]

{ #category : 'enumerating' }
HiDeNode >> allSatisfy: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
HiDeNode >> anySatisfy: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
HiDeNode >> do: aBlock [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeNode >> impacts [

	^ self subclassResponsibility
]
