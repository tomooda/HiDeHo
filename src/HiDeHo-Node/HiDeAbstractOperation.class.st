Class {
	#name : 'HiDeAbstractOperation',
	#superclass : 'HiDeNode',
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'testing' }
HiDeAbstractOperation class >> isAbstract [

	^ self == HiDeAbstractOperation
]

{ #category : 'enumerating' }
HiDeAbstractOperation >> do: aBlock [

	aBlock value: self
]

{ #category : 'enumerating' }
HiDeAbstractOperation >> operationsDo: aBlock [

	aBlock value: self
]
