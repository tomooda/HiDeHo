Class {
	#name : 'HiDeAbstractOperationTest',
	#superclass : 'TestCase',
	#instVars : [
		'item'
	],
	#category : 'HiDeHo-Node-Tests',
	#package : 'HiDeHo-Node',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeAbstractOperationTest >> setUp [

	item := 1 asHiDeItem
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAllNodesSatisfy [

	self assert: (item allNodesSatisfy: [ :o | true ]).
	self deny: (item allNodesSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAllSatisfy [

	self assert: (item allSatisfy: [ :o | true ]).
	self deny: (item allSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAnyNodeSatisfy [

	self assert: (item anyNodeSatisfy: [ :o | true ]).
	self deny: (item anyNodeSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testAnySatisfy [

	self assert: (item anySatisfy: [ :o | true ]).
	self deny: (item anySatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testDo [

	| count |
	count := 0.
	item do: [ :object |
		self assert: object identicalTo: item value.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testIncludes [

	self assert: (item includes: 1).
	self deny: (item includes: 0)
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testIsHiDeClosure [

	self deny: item isHiDeClosure
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testIsHiDeItem [

	self assert: item isHiDeItem
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testItemsDo [

	| count |
	count := 0.
	item itemsDo: [ :holder |
		self assert: holder identicalTo: item.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testNodesDo [

	| count |
	count := 0.
	item nodesDo: [ :holder |
		self assert: holder identicalTo: item.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testNumberOfNodes [

	self assert: item numberOfNodes equals: 1
]

{ #category : 'tests' }
HiDeAbstractOperationTest >> testSize [

	self assert: item size equals: 1
]
