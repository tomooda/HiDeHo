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

{ #category : 'enumerating' }
THiDeSyntaxTree >> syntaxAccessorsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : 'enumerating' }
THiDeSyntaxTree >> syntaxAccessorsToTipsDo: aBlock [

	self syntaxAccessorsDo: [ :accessor |
		| node |
		node := accessor read: self.
		node isHiDeSyntaxTree
			ifTrue: [
				node syntaxAccessorsToTipsDo: [ :accessorToTip |
					aBlock value: accessor , accessorToTip ] ]
			ifFalse: [ aBlock value: accessor ] ]
]
