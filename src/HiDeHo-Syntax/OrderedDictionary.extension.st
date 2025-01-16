Extension { #name : 'OrderedDictionary' }

{ #category : '*HiDeHo-Syntax' }
OrderedDictionary >> syntaxAccessorsDo: aBlock [

	self keysDo: [ :key | aBlock value: (HiDeSyntaxKeyAccessor on: key) ]
]
