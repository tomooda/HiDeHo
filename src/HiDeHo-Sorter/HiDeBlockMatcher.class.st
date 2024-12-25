Class {
	#name : 'HiDeBlockMatcher',
	#superclass : 'HiDeMatcher',
	#instVars : [
		'block'
	],
	#category : 'HiDeHo-Sorter',
	#package : 'HiDeHo-Sorter'
}

{ #category : 'instance creation' }
HiDeBlockMatcher class >> on: aBlockClosure [

	^ self new
		  block: aBlockClosure;
		  yourself
]

{ #category : 'accessing' }
HiDeBlockMatcher >> block [

	^ block
]

{ #category : 'accessing' }
HiDeBlockMatcher >> block: aBlockClosure [

	block := aBlockClosure
]

{ #category : 'evaluating' }
HiDeBlockMatcher >> value: anObject value: anotherObject [

	^ block value: anObject value: anotherObject
]
