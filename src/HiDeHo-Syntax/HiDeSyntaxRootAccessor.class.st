Class {
	#name : 'HiDeSyntaxRootAccessor',
	#superclass : 'HiDeSyntaxAccessor',
	#classInstVars : [
		'current'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'accessing' }
HiDeSyntaxRootAccessor class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : 'comparing' }
HiDeSyntaxRootAccessor >> = anObject [

	^ self class = anObject class
]

{ #category : 'comparing' }
HiDeSyntaxRootAccessor >> hash [

	^ self class hash
]

{ #category : 'accessing' }
HiDeSyntaxRootAccessor >> head [

	^ self
]

{ #category : 'accessing' }
HiDeSyntaxRootAccessor >> name [

	^ ''
]

{ #category : 'accessing' }
HiDeSyntaxRootAccessor >> read: anObject [

	^ anObject
]

{ #category : 'accessing' }
HiDeSyntaxRootAccessor >> tail [

	^ nil
]

{ #category : 'accessing' }
HiDeSyntaxRootAccessor >> write: anObject to: anotherObject [

	anObject syntaxAccessorsDo: [ :accessor |
		accessor write: (accessor read: anObject) to: anotherObject ]
]
