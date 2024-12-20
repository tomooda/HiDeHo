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

{ #category : 'adding/removing' }
HiDeOperationHolder >> removeOperation: anObject [

	
]
