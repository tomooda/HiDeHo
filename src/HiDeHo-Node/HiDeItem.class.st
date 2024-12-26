Class {
	#name : 'HiDeItem',
	#superclass : 'HiDeNode',
	#instVars : [
		'value'
	],
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeItem class >> on: anObject [

	^ self new
		  value: anObject;
		  yourself
]

{ #category : 'converting' }
HiDeItem >> asHiDeClosure [

	^ HiDeClosure with: self
]

{ #category : 'converting' }
HiDeItem >> asHiDeItem [

	^ self
]

{ #category : 'testing' }
HiDeItem >> isHiDeItem [

	^ true
]

{ #category : 'enumerating' }
HiDeItem >> itemsDo: aBlock [

	aBlock value: self
]

{ #category : 'enumerating' }
HiDeItem >> nodesDo: aBlock [

	aBlock value: self
]

{ #category : 'printing' }
HiDeItem >> printOn: aStream [

	value printOn: aStream
]

{ #category : 'adding/removing' }
HiDeItem >> remove: anObject [

	
]

{ #category : 'accessing' }
HiDeItem >> size [

	^ 1
]

{ #category : 'accessing' }
HiDeItem >> value [

	^ value
]

{ #category : 'accessing' }
HiDeItem >> value: anObject [

	value := anObject
]
