Class {
	#name : 'HiDeSequenceTest',
	#superclass : 'TestCase',
	#instVars : [
		'seq',
		'subseq',
		'op1',
		'op2'
	],
	#category : 'HiDeHo-Node-Tests',
	#package : 'HiDeHo-Node',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeSequenceTest >> setUp [

	seq := HiDeSequence new.
	subseq := HiDeSequence new.
	op1 := HiDeOperationHolder on: 1.
	op2 := HiDeOperationHolder on: 2.
	seq
		add: op1;
		add: subseq.
	subseq
		add: op1;
		add: op2
]

{ #category : 'tests' }
HiDeSequenceTest >> testAllOperationsSatisfy [

	self assert: (seq allOperationsSatisfy: [ :op | op > 0 ]).
	self deny: (seq allOperationsSatisfy: [ :op | op = 1 ])
]

{ #category : 'tests' }
HiDeSequenceTest >> testAllSatisfy [

	self assert: (seq allSatisfy: [ :node | node isKindOf: HiDeNode ]).
	self deny: (seq allSatisfy: [ :node | node isOperationHolder ])
]

{ #category : 'tests' }
HiDeSequenceTest >> testAnyOperationSatisfy [

	self assert: (seq anyOperationSatisfy: [ :op | op = 1 ]).
	self assert: (seq anyOperationSatisfy: [ :op | op = 2 ]).
	self deny: (seq anyOperationSatisfy: [ :op | op = 0 ])
]

{ #category : 'tests' }
HiDeSequenceTest >> testAnySatisfy [

	self assert: (seq anySatisfy: [ :node | node isOperationHolder ]).
	self deny: (seq anySatisfy: [ :node | node = op2 ])
]

{ #category : 'tests' }
HiDeSequenceTest >> testAt [

	self assert: (seq at: 1) identicalTo: op1.
	self assert: (seq at: 2) identicalTo: subseq.
	self assert: (subseq at: 1) identicalTo: op1.
	self assert: (subseq at: 2) identicalTo: op2
]

{ #category : 'tests' }
HiDeSequenceTest >> testDo [

	| nodes |
	nodes := OrderedCollection new.
	seq do: [ :node | nodes add: node ].
	self assert: nodes equals: {
			op1.
			subseq } asOrderedCollection
]

{ #category : 'tests' }
HiDeSequenceTest >> testIncludesOperation [

	self assert: (seq includesOperation: 1).
	self assert: (seq includesOperation: 2).
	self deny: (seq includesOperation: 0)
]

{ #category : 'tests' }
HiDeSequenceTest >> testIsOperationHolder [

	self deny: seq isOperationHolder.
	self deny: subseq isOperationHolder
]

{ #category : 'tests' }
HiDeSequenceTest >> testIsSequence [

	self assert: seq isSequence.
	self assert: subseq isSequence
]

{ #category : 'tests' }
HiDeSequenceTest >> testNumberOfOperations [

	self assert: seq numberOfOperations equals: 3.
	self assert: subseq numberOfOperations equals: 2
]

{ #category : 'tests' }
HiDeSequenceTest >> testOperationHoldersDo [

	| holders |
	holders := OrderedCollection new.
	seq operationHoldersDo: [ :holder | holders add: holder ].
	self assert: holders equals: {
			op1.
			op1.
			op2 } asOrderedCollection
]

{ #category : 'tests' }
HiDeSequenceTest >> testOperationsDo [

	| operations |
	operations := OrderedCollection new.
	seq operationsDo: [ :op | operations add: op ].
	self assert: operations equals: { 1. 1. 2 } asOrderedCollection
]

{ #category : 'tests' }
HiDeSequenceTest >> testSize [

	self assert: seq size equals: 2
]
