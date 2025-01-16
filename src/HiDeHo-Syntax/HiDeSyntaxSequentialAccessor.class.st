Class {
	#name : 'HiDeSyntaxSequentialAccessor',
	#superclass : 'HiDeSyntaxAccessor',
	#instVars : [
		'accessors'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeSyntaxSequentialAccessor class >> with: aHiDeSyntaxAccessor with: anotherHiDeSyntaxAccessor [

	^ self withAll: {
			  aHiDeSyntaxAccessor.
			  anotherHiDeSyntaxAccessor }
]

{ #category : 'instance creation' }
HiDeSyntaxSequentialAccessor class >> with: aHiDeSyntaxAccessor1 with: aHiDeSyntaxAccessor2 with: aHiDeSyntaxAccessor3 [

	^ self withAll: {
			  aHiDeSyntaxAccessor1.
			  aHiDeSyntaxAccessor2.
			  aHiDeSyntaxAccessor3 }
]

{ #category : 'instance creation' }
HiDeSyntaxSequentialAccessor class >> withAll: anArrayOfHiDeSyntaxAccessor [

	^ self new
		  accessors: anArrayOfHiDeSyntaxAccessor;
		  yourself
]

{ #category : 'copying' }
HiDeSyntaxSequentialAccessor >> , aHiDeSyntaxAccessor [

	^ HiDeSyntaxSequentialAccessor withAll:
		  (accessors copyWith: aHiDeSyntaxAccessor)
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> accessors [

	^ accessors
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> accessors: anArrayOfHiDeSyntaxAccessor [

	accessors := anArrayOfHiDeSyntaxAccessor
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> value: anObject [

	^ accessors
		  inject: anObject
		  into: [ :ast :accessor | accessor value: ast ]
]
