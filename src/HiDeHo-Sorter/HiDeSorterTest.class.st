Class {
	#name : 'HiDeSorterTest',
	#superclass : 'TestCase',
	#category : 'HiDeHo-Sorter-Tests',
	#package : 'HiDeHo-Sorter',
	#tag : 'Tests'
}

{ #category : 'tests' }
HiDeSorterTest >> testFlatCluster [

	| sorter cluster1 cluster2 |
	sorter := HiDeSorter new.
	sorter
		useFlatMerger;
		matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ].
	sorter
		add: 0;
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter size equals: 2.
	cluster1 := sorter at: 1.
	cluster2 := sorter at: 2.
	self assert: cluster1 size equals: 4.
	self assert: (cluster1 at: 1) operation equals: 0.
	self assert: (cluster1 at: 2) operation equals: 1.
	self assert: (cluster1 at: 3) operation equals: 3.
	self assert: (cluster1 at: 4) operation equals: 2.
	self assert: cluster2 isOperationHolder.
	self assert: (cluster2 includesOperation: 5)
]

{ #category : 'tests' }
HiDeSorterTest >> testHierarchicalCluster [

	| sorter cluster1 cluster2 |
	sorter := HiDeSorter new.
	sorter
		useHierarchicalMerger;
		matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ].
	sorter
		add: 0;
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter size equals: 2.
	cluster1 := sorter at: 1.
	cluster2 := sorter at: 2.
	self assert: cluster1 size equals: 3.
	self assert: ((cluster1 at: 1) at: 1) operation equals: 0.
	self assert: ((cluster1 at: 1) at: 2) operation equals: 1.
	self assert: (cluster1 at: 2) operation equals: 3.
	self assert: (cluster1 at: 3) operation equals: 2.
	self assert: cluster2 isOperationHolder.
	self assert: cluster2 operation equals: 5
]
