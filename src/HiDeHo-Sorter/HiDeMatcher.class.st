Class {
	#name : 'HiDeMatcher',
	#superclass : 'Object',
	#category : 'HiDeHo-Sorter',
	#package : 'HiDeHo-Sorter'
}

{ #category : 'testing' }
HiDeMatcher class >> isAbstract [

	^ self == HiDeMatcher
]

{ #category : 'evaluating' }
HiDeMatcher >> value: anObject value: anotherObject [

	^ self subclassResponsibility
]
