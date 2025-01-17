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

{ #category : 'comparing' }
HiDeSyntaxAccessor >> = anObject [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
HiDeSyntaxAccessor >> hash [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> head [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> name [

	^ self subclassResponsibility
]

{ #category : 'printing' }
HiDeSyntaxAccessor >> printOn: aStream [

	aStream nextPutAll: self name
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> tail [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> value: anObject [

	^ self subclassResponsibility
]
