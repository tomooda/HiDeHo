Class {
	#name : 'HiDeSyntaxSelectorAccessor',
	#superclass : 'HiDeSyntaxAccessor',
	#instVars : [
		'selector'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeSyntaxSelectorAccessor class >> on: aSymbol [

	^ self new
		  selector: aSymbol asSymbol;
		  yourself
]

{ #category : 'comparing' }
HiDeSyntaxSelectorAccessor >> = anObject [

	^ self class = anObject class and: [ selector = anObject selector ]
]

{ #category : 'comparing' }
HiDeSyntaxSelectorAccessor >> hash [

	^ self class hash bitXor: selector hash
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> head [

	^ self
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> name [

	^ selector asString
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> selector [

	^ selector
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> selector: aSymbol [

	selector := aSymbol asSymbol
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> tail [

	^ nil
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> value: anObject [

	^ anObject perform: selector asSymbol
]
