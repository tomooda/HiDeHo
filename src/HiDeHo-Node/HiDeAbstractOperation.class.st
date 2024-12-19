Class {
	#name : 'HiDeAbstractOperation',
	#superclass : 'HiDeNode',
	#category : 'HiDeHo-Node',
	#package : 'HiDeHo-Node'
}

{ #category : 'testing' }
HiDeAbstractOperation class >> isAbstract [

	^ self == HiDeAbstractOperation
]

{ #category : 'enumerating' }
HiDeAbstractOperation >> allSatisfy: aBlock [

	^ aBlock value: self
]

{ #category : 'enumerating' }
HiDeAbstractOperation >> anySatisfy: aBlock [

	^ aBlock value: self
]

{ #category : 'enumerating' }
HiDeAbstractOperation >> do: aBlock [

	aBlock value: self
]
