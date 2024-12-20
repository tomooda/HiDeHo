Class {
	#name : 'HiDeAbstractOperationTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Node-Tests',
	#package : 'HiDeHo-Node',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAllOperationsSatisfy [

	| op |
	op := HiDeAbstractOperation new.
	self assert: (op allOperationsSatisfy: [ :o | true ]).
	self deny: (op allOperationsSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAllSatisfy [

	| op |
	op := HiDeAbstractOperation new.
	self assert: (op allSatisfy: [ :o | true ]).
	self deny: (op allSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAnyOperationSatisfy [

	| op |
	op := HiDeAbstractOperation new.
	self assert: (op anyOperationSatisfy: [ :o | true ]).
	self deny: (op anyOperationSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAnySatisfy [

	| op |
	op := HiDeAbstractOperation new.
	self assert: (op anySatisfy: [ :o | true ]).
	self deny: (op anySatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testDo [

	| op count |
	op := HiDeAbstractOperation new.
	count := 0.
	op do: [ :o |
		self assert: op identicalTo: o.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testNumberOfOperations [

	| op |
	op := HiDeAbstractOperation new.
	self assert: op numberOfOperations equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testOperationsDo [

	| op count |
	op := HiDeAbstractOperation new.
	count := 0.
	op operationsDo: [ :o |
		self assert: op identicalTo: o.
		count := count + 1 ].
	self assert: count equals: 1
]
