Class {
	#name : 'HiDeSyntaxKeyAccessor',
	#superclass : 'HiDeSyntaxAccessor',
	#instVars : [
		'key'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeSyntaxKeyAccessor class >> on: anObject [

	^ self new
		  key: anObject;
		  yourself
]

{ #category : 'comparing' }
HiDeSyntaxKeyAccessor >> = anObject [

	^ self class = anObject class and: [ key = anObject key ]
]

{ #category : 'comparing' }
HiDeSyntaxKeyAccessor >> hash [

	^ self class hash bitXor: key hash
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> head [

	^ self
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> key [

	^ key
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> key: anObject [

	key := anObject
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> name [

	^ key asString
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> tail [

	^ nil
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> value: anObject [

	^ anObject at: key
]
