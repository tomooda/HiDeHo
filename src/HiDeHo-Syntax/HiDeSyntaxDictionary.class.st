Class {
	#name : 'HiDeSyntaxDictionary',
	#superclass : 'OrderedDictionary',
	#traits : 'THiDeSyntaxTree',
	#classTraits : 'THiDeSyntaxTree classTrait',
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'accessing' }
HiDeSyntaxDictionary >> \ aHiDeSyntaxDictionary [

	| intersection |
	intersection := self class new.
	(HiDeSyntaxComparator from: aHiDeSyntaxDictionary to: self)
		intersectionsDo: [ :accessor |  ]
		additionsDo: [ :accessor |
		accessor write: (accessor read: self) to: intersection ]
		deletionsDo: [ :accessor |  ].
	^ intersection
]

{ #category : 'accessing' }
HiDeSyntaxDictionary >> at: anObject [

	^ self at: anObject ifAbsentPut: [ self class new ]
]

{ #category : 'accessing' }
HiDeSyntaxDictionary >> intersectionWith: aHiDeSyntaxDictionary [

	| intersection |
	intersection := self class new.
	(HiDeSyntaxComparator from: self to: aHiDeSyntaxDictionary)
		intersectionsDo: [ :accessor |
		accessor write: (accessor read: self) to: intersection ].
	^ intersection
]

{ #category : 'enumerating' }
HiDeSyntaxDictionary >> syntaxAccessorsDo: aBlock [

	self keysDo: [ :key | aBlock value: (HiDeSyntaxKeyAccessor on: key) ]
]

{ #category : 'accessing' }
HiDeSyntaxDictionary >> syntaxAccessorsToTips [

	^ Array streamContents: [ :stream |
		  self syntaxAccessorsToTipsDo: [ :accessor |
			  stream nextPut: accessor ] ]
]
