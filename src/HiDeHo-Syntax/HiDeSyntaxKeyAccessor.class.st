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

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> key [

	^ key
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> key: anObject [

	key := anObject
]

{ #category : 'accessing' }
HiDeSyntaxKeyAccessor >> value: anObject [

	^ anObject at: key
]
