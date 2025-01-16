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

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> selector [

	^ selector
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> selector: aSymbol [

	selector := aSymbol asSymbol
]

{ #category : 'accessing' }
HiDeSyntaxSelectorAccessor >> value: anObject [

	^ anObject perform: selector asSymbol
]
