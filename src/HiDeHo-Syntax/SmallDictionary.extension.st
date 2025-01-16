Extension { #name : 'SmallDictionary' }

{ #category : '*HiDeHo-Syntax' }
SmallDictionary >> syntaxAccessorsDo: aBlock [

	self keysDo: [ :key | aBlock value: (HiDeSyntaxKeyAccessor on: key) ]
]
