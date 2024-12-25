Class {
	#name : 'HiDeOperationHolder',
	#superclass : 'HiDeNode',
	#instVars : [
		'operation'
	],
	#category : 'HiDeHo-Node-Core',
	#package : 'HiDeHo-Node',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeOperationHolder class >> on: anObject [

	^ self new
		  operation: anObject;
		  yourself
]

{ #category : 'converting' }
HiDeOperationHolder >> asHiDeOperationHolder [

	^ self
]

{ #category : 'converting' }
HiDeOperationHolder >> asHiDeSequence [

	^ HiDeSequence with: self
]

{ #category : 'enumerating' }
HiDeOperationHolder >> do: aBlock [

	aBlock value: self
]

{ #category : 'testing' }
HiDeOperationHolder >> isOperationHolder [

	^ true
]

{ #category : 'accessing' }
HiDeOperationHolder >> operation [

	^ operation
]

{ #category : 'accessing' }
HiDeOperationHolder >> operation: anObject [

	operation := anObject
]

{ #category : 'enumerating' }
HiDeOperationHolder >> operationHoldersDo: aBlock [

	aBlock value: self
]

{ #category : 'printing' }
HiDeOperationHolder >> printOn: aStream [

	operation printOn: aStream
]

{ #category : 'adding/removing' }
HiDeOperationHolder >> removeOperation: anObject [

	
]
