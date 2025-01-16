Class {
	#name : 'HiDeSyntaxComparator',
	#superclass : 'Object',
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'enumerating' }
HiDeSyntaxComparator >> compare: anObject withBase: anotherObject intersectionsDo: aBlock additionsDo: additionBlock deletionsDo: deletionBlock [

	^ self subclassResponsibility
]
