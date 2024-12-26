Class {
	#name : 'HiDeItemTest',
	#superclass : 'TestCase',
	#instVars : [
		'item'
	],
	#category : 'HiDeHo-Node-Tests',
	#package : 'HiDeHo-Node',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeItemTest >> setUp [

	item := 1 asHiDeItem
]

{ #category : 'tests' }
HiDeItemTest >> testAllNodesSatisfy [

	self assert: (item allNodesSatisfy: [ :o | true ]).
	self deny: (item allNodesSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeItemTest >> testAllSatisfy [

	self assert: (item allSatisfy: [ :o | true ]).
	self deny: (item allSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeItemTest >> testAnyNodeSatisfy [

	self assert: (item anyNodeSatisfy: [ :o | true ]).
	self deny: (item anyNodeSatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeItemTest >> testAnySatisfy [

	self assert: (item anySatisfy: [ :o | true ]).
	self deny: (item anySatisfy: [ :o | false ])
]

{ #category : 'tests' }
HiDeItemTest >> testDo [

	| count |
	count := 0.
	item do: [ :object |
		self assert: object identicalTo: item value.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeItemTest >> testIdentityIncludes [

	self assert: (item includes: 1).
	self deny: (item includes: 0)
]

{ #category : 'tests' }
HiDeItemTest >> testIncludes [

	self assert: (item includes: 1).
	self deny: (item includes: 0)
]

{ #category : 'tests' }
HiDeItemTest >> testIsHiDeClosure [

	self deny: item isHiDeClosure
]

{ #category : 'tests' }
HiDeItemTest >> testIsHiDeItem [

	self assert: item isHiDeItem
]

{ #category : 'tests' }
HiDeItemTest >> testItemsDo [

	| count |
	count := 0.
	item itemsDo: [ :holder |
		self assert: holder identicalTo: item.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeItemTest >> testNodesDo [

	| count |
	count := 0.
	item nodesDo: [ :holder |
		self assert: holder identicalTo: item.
		count := count + 1 ].
	self assert: count equals: 1
]

{ #category : 'tests' }
HiDeItemTest >> testNumberOfNodes [

	self assert: item numberOfNodes equals: 1
]

{ #category : 'tests' }
HiDeItemTest >> testSize [

	self assert: item size equals: 1
]
