Extension { #name : 'Dictionary' }

{ #category : '*HiDeHo-Syntax' }
Dictionary >> syntaxAccessorsDo: aBlock [

	self keysDo: [ :key | aBlock value: (HiDeSyntaxKeyAccessor on: key) ]
]
