Trait {
	#name : 'THiDeAbstractSyntaxTree',
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'comparing' }
THiDeAbstractSyntaxTree >> = anObject [

	^ self subclassResponsibility
]

{ #category : 'comparing' }
THiDeAbstractSyntaxTree >> syntaxAccessorsDo: aBlock [

	^ self subclassResponsibility
]
