Class {
	#name : 'HiDeSyntaxAccessor',
	#superclass : 'Object',
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'testing' }
HiDeSyntaxAccessor class >> isAbstract [

	^ self == HiDeSyntaxAccessor
]

{ #category : 'copying' }
HiDeSyntaxAccessor >> , aHiDeSyntaxAccessor [

	^ HiDeSyntaxSequentialAccessor with: self with: aHiDeSyntaxAccessor
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> value: anObject [

	^ self subclassResponsibility
]
