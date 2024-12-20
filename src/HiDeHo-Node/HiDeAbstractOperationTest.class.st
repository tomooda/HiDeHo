Class {
	#name : 'HiDeAbstractOperationTest',
	#superclass : 'TestCase',
	#instVars : [
		'op'
	],
	#category : 'HiDeHo-Node-Tests',
	#package : 'HiDeHo-Node',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeAbstractOperationTest >> setUp [

	op := HiDeOperationHolder on: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAllOperationsSatisfy [

	self assert: (op allOperationsSatisfy: [ :o | true ]).
	self deny: (op allOperationsSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAllSatisfy [

	self assert: (op allSatisfy: [ :o | true ]).
	self deny: (op allSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAnyOperationSatisfy [

	self assert: (op anyOperationSatisfy: [ :o | true ]).
	self deny: (op anyOperationSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAnySatisfy [

	self assert: (op anySatisfy: [ :o | true ]).
	self deny: (op anySatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testDo [

	| count |
	count := 0.
	op do: [ :o |
		self assert: op identicalTo: o.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testIncludesOperation [

	self assert: (op includesOperation: 1).
	self deny: (op includesOperation: 0)
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testIsOperationHolder [

	self assert: op isOperationHolder
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testIsSequence [

	self deny: op isSequence
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testNumberOfOperations [

	self assert: op numberOfOperations equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testOperationHoldersDo [

	| count |
	count := 0.
	op operationHoldersDo: [ :holder |
		self assert: holder identicalTo: op.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testOperationsDo [

	| count |
	count := 0.
	op operationsDo: [ :o |
		self assert: o equals: 1.
		count := count + 1 ].
	self assert: count equals: 1
]
