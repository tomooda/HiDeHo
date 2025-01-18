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

{ #category : 'comparing' }
HiDeSyntaxSequentialAccessor >> = anObject [

	^ self class = anObject class and: [ accessors = anObject accessors ]
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> accessors [

	^ accessors
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> accessors: anArrayOfHiDeSyntaxAccessor [

	accessors := anArrayOfHiDeSyntaxAccessor
]

{ #category : 'enumerating' }
HiDeSyntaxSequentialAccessor >> do: aBlock [

	accessors do: [ :accessor | accessor do: aBlock ]
]

{ #category : 'comparing' }
HiDeSyntaxSequentialAccessor >> hash [

	^ self class hash bitXor: accessors hash
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> head [

	^ accessors ifNotEmpty: #first ifEmpty: [ nil ]
]

{ #category : 'enumerating' }
HiDeSyntaxSequentialAccessor >> keyAccessorsDo: aBlock [

	accessors do: [ :accessor | accessor keyAccessorsDo: aBlock ]
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> name [

	^ String streamContents: [ :stream |
		  accessors
			  do: [ :accessor | accessor printOn: stream ]
			  separatedBy: [ stream nextPut: $- ] ]
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> read: anObject [

	^ accessors
		  inject: anObject
		  into: [ :ast :accessor | accessor read: ast ]
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> tail [

	^ accessors size > 2
		  ifTrue: [ self class withAll: accessors copyWithoutFirst ]
		  ifFalse: [
			  accessors size = 2
				  ifTrue: [ accessors at: 2 ]
				  ifFalse: [ nil ] ]
]

{ #category : 'accessing' }
HiDeSyntaxSequentialAccessor >> write: anObject to: anotherObject [

	| node |
	accessors isEmpty ifTrue: [ ^ nil ].
	node := anotherObject.
	1 to: accessors size - 1 do: [ :index |
	node := (accessors at: index) read: node ].
	^ accessors last write: anObject to: node
]
