Trait {
	#name : 'THiDeSyntaxTree',
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'testing' }
THiDeSyntaxTree >> isHiDeSyntaxTree [

	^ true
]

{ #category : 'comparing' }
THiDeSyntaxTree >> syntaxAccessorsDo: aBlock [

	^ self subclassResponsibility
]
