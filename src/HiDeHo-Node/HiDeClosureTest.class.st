Class {
	#name : 'HiDeClosureTest',
	#superclass : 'TestCase',
	#instVars : [
		'item1',
		'item2',
		'closure',
		'subclosure'
	],
	#category : 'HiDeHo-Node-Tests',
	#package : 'HiDeHo-Node',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeClosureTest >> setUp [

	item1 := 1 asHiDeItem.
	item2 := 2 asHiDeItem.
	subclosure := {
		          item1.
		          item2 } asHiDeClosure.
	closure := {
		       item1.
		       subclosure } asHiDeClosure
]

{ #category : 'tests' }
HiDeClosureTest >> testAllNodesSatisfy [

	self assert: (closure allNodesSatisfy: [ :node | node isKindOf: HiDeNode ]).
	self deny: (closure allNodesSatisfy: [ :node | node isHiDeItem ])
]

{ #category : 'tests' }
HiDeClosureTest >> testAllSatisfy [

	self assert: (closure allSatisfy: [ :op | op > 0 ]).
	self deny: (closure allSatisfy: [ :op | op = 1 ])
]

{ #category : 'tests' }
HiDeClosureTest >> testAnyNodeSatisfy [

	self assert: (closure anyNodeSatisfy: [ :node | node isHiDeItem ]).
	self deny: (closure anyNodeSatisfy: [ :node | node = item2 ])
]

{ #category : 'tests' }
HiDeClosureTest >> testAnySatisfy [

	self assert: (closure anySatisfy: [ :op | op = 1 ]).
	self assert: (closure anySatisfy: [ :op | op = 2 ]).
	self deny: (closure anySatisfy: [ :op | op = 0 ])
]

{ #category : 'tests' }
HiDeClosureTest >> testDo [

	| objects |
	objects := OrderedCollection new.
	closure do: [ :op | objects add: op ].
	self assert: objects equals: { 1. 1. 2 } asOrderedCollection
]

{ #category : 'tests' }
HiDeClosureTest >> testIdentityIncludes [

	self assert: (closure includes: 1).
	self assert: (closure includes: 2).
	self deny: (closure includes: 0)
]

{ #category : 'tests' }
HiDeClosureTest >> testIncludes [

	self assert: (closure includes: 1).
	self assert: (closure includes: 2).
	self deny: (closure includes: 0)
]

{ #category : 'tests' }
HiDeClosureTest >> testIsHiDeClosure [

	self assert: closure isHiDeClosure.
	self assert: subclosure isHiDeClosure
]

{ #category : 'tests' }
HiDeClosureTest >> testIsHiDeItem [

	self deny: closure isHiDeItem.
	self deny: subclosure isHiDeItem
]

{ #category : 'tests' }
HiDeClosureTest >> testItemsDo [

	| items |
	items := OrderedCollection new.
	closure itemsDo: [ :holder | items add: holder ].
	self assert: items equals: {
			item1.
			item1.
			item2 } asOrderedCollection
]

{ #category : 'tests' }
HiDeClosureTest >> testNodeAt [

	self assert: (closure nodeAt: 1) identicalTo: item1.
	self assert: (closure nodeAt: 2) identicalTo: subclosure.
	self assert: (subclosure nodeAt: 1) identicalTo: item1.
	self assert: (subclosure nodeAt: 2) identicalTo: item2
]

{ #category : 'tests' }
HiDeClosureTest >> testNodesDo [

	| nodes |
	nodes := OrderedCollection new.
	closure nodesDo: [ :node | nodes add: node ].
	self assert: nodes equals: {
			item1.
			subclosure } asOrderedCollection
]

{ #category : 'tests' }
HiDeClosureTest >> testNumberOfNodes [

	self assert: closure numberOfNodes equals: 2.
	self assert: subclosure numberOfNodes equals: 2
]

{ #category : 'tests' }
HiDeClosureTest >> testSize [

	self assert: closure size equals: 3.
	self assert: subclosure size equals: 2
]
