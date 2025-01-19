Class {
	#name : 'HiDeSyntaxDictionaryKeyNotFound',
	#superclass : 'Exception',
	#instVars : [
		'key'
	],
	#category : 'HiDeHo-Syntax-Core',
	#package : 'HiDeHo-Syntax',
	#tag : 'Core'
}

{ #category : 'signalling' }
HiDeSyntaxDictionaryKeyNotFound class >> signalFor: anObject [
	"Create and signal a NotFound exception for anObject in the default receiver."

	^ self new
		  key: anObject;
		  signal
]

{ #category : 'accessing' }
HiDeSyntaxDictionaryKeyNotFound >> key [

	^ key
]

{ #category : 'accessing' }
HiDeSyntaxDictionaryKeyNotFound >> key: anObject [

	key := anObject
]
