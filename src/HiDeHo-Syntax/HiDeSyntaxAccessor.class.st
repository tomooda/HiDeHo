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

	^ aHiDeSyntaxAccessor isSyntaxSequentialAccessor
		  ifTrue: [
			  HiDeSyntaxSequentialAccessor withAll:
				  (aHiDeSyntaxAccessor accessors copyWithFirst: self) ]
		  ifFalse: [
		  HiDeSyntaxSequentialAccessor with: self with: aHiDeSyntaxAccessor ]
]

{ #category : 'comparing' }
HiDeSyntaxAccessor >> = anObject [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
HiDeSyntaxAccessor >> do: aBlock [

	aBlock value: self
]

{ #category : 'comparing' }
HiDeSyntaxAccessor >> hash [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> head [

	^ self subclassResponsibility
]

{ #category : 'testing' }
HiDeSyntaxAccessor >> isSyntaxSequentialAccessor [

	^ false
]

{ #category : 'enumerating' }
HiDeSyntaxAccessor >> keyAccessorsDo: aBlock [

	
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
HiDeSyntaxAccessor >> read: anObject [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> tail [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
HiDeSyntaxAccessor >> write: anObject to: anotherObject [

	^ self subclassResponsibility
]
