Class {
	#name : 'HiDeSyntaxDictionary',
	#superclass : 'OrderedDictionary',
	#traits : 'THiDeSyntaxTree',
	#classTraits : 'THiDeSyntaxTree classTrait',
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'comparing' }
HiDeSyntaxDictionary >> syntaxAccessorsDo: aBlock [

	self keysDo: [ :key | aBlock value: (HiDeSyntaxKeyAccessor on: key) ]
]
