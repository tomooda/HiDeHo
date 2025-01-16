Class {
	#name : 'HiDeMatcher',
	#superclass : 'Object',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'testing' }
HiDeMatcher class >> isAbstract [

	^ self == HiDeMatcher
]

{ #category : 'evaluating' }
HiDeMatcher >> value: anObject value: anotherObject [

	^ self subclassResponsibility
]
