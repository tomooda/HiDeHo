Class {
	#name : 'HiDeSorterTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Sorter-Tests',
	#package : 'HiDeHo-Sorter',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSorterTest >> testExclusiveFlatCluster [

	| sorter cluster1 cluster2 |
	sorter := HiDeSorter new.
	sorter
		beExclusive;
		useFlatMerger.
	sorter matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ].
	sorter
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter size equals: 2.
	cluster1 := sorter at: 1.
	cluster2 := sorter at: 2.
	self assert: cluster1 size equals: 3.
	self assert: (cluster1 includesOperation: 1).
	self assert: (cluster1 includesOperation: 2).
	self assert: (cluster1 includesOperation: 3).
	self assert: cluster2 size equals: 1.
	self assert: (cluster2 includesOperation: 5)
]

{ #category : 'tests' }
HiDeSorterTest >> testExclusiveHierarchicalCluster [

	| sorter cluster1 cluster2 |
	sorter := HiDeSorter new.
	sorter
		beExclusive;
		useHierarchicalMerger.
	sorter matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ].
	sorter
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter size equals: 2.
	cluster1 := sorter at: 1.
	cluster2 := sorter at: 2.
	self assert: cluster1 size equals: 3.
	self assert: ((cluster1 at: 1) at: 1) operation equals: 1.
	self assert: ((cluster1 at: 2) at: 1) operation equals: 3.
	self assert: (cluster1 at: 3) operation equals: 2.
	self assert: cluster2 size equals: 1.
	self assert: (cluster2 at: 1) operation equals: 5
]

{ #category : 'tests' }
HiDeSorterTest >> testNonExclusiveFlatCluster [

	| sorter cluster1 cluster2 cluster3 |
	sorter := HiDeSorter new.
	sorter
		beNonExclusive;
		useFlatMerger.
	sorter matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ].
	sorter
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter size equals: 3.
	cluster1 := sorter at: 1.
	cluster2 := sorter at: 2.
	cluster3 := sorter at: 3.
	self assert: cluster1 size equals: 2.
	self assert: (cluster1 at: 1) operation equals: 1.
	self assert: (cluster1 at: 2) operation equals: 2.
	self assert: (cluster2 at: 1) operation equals: 3.
	self assert: (cluster2 at: 2) operation equals: 2.
	self assert: (cluster3 at: 1) operation equals: 5
]

{ #category : 'tests' }
HiDeSorterTest >> testNonExclusiveHierarchicalCluster [

	| sorter cluster1 cluster2 cluster3 |
	sorter := HiDeSorter new.
	sorter
		beNonExclusive;
		useHierarchicalMerger.
	sorter matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ].
	sorter
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter size equals: 3.
	cluster1 := sorter at: 1.
	cluster2 := sorter at: 2.
	cluster3 := sorter at: 3.
	self assert: cluster1 size equals: 2.
	self assert: (cluster1 at: 1) operation equals: 1.
	self assert: (cluster1 at: 2) operation equals: 2.
	self assert: (cluster2 at: 1) operation equals: 3.
	self assert: (cluster2 at: 2) operation equals: 2.
	self assert: (cluster3 at: 1) operation equals: 5
]
