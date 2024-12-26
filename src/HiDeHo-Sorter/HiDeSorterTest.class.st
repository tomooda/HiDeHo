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
		matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ] asHiDeMatcher.
	sorter
		add: 0;
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter numberOfNodes equals: 2.
	cluster1 := sorter nodeAt: 1.
	cluster2 := sorter nodeAt: 2.
	self assert: cluster1 numberOfNodes equals: 4.
	self assert: (cluster1 nodeAt: 1) value equals: 0.
	self assert: (cluster1 nodeAt: 2) value equals: 1.
	self assert: (cluster1 nodeAt: 3) value equals: 3.
	self assert: (cluster1 nodeAt: 4) value equals: 2.
	self assert: cluster2 isHiDeItem.
	self assert: (cluster2 includes: 5)
]

{ #category : 'tests' }
HiDeSorterTest >> testHierarchicalCluster [

	| sorter cluster1 cluster2 |
	sorter := HiDeSorter new.
	sorter
		useHierarchicalMerger;
		matcher: [ :i1 :i2 | (i1 - i2) abs <= 1 ] asHiDeMatcher.
	sorter
		add: 0;
		add: 1;
		add: 3;
		add: 5;
		add: 2.
	self assert: sorter numberOfNodes equals: 2.
	cluster1 := sorter nodeAt: 1.
	cluster2 := sorter nodeAt: 2.
	self assert: cluster1 numberOfNodes equals: 3.
	self assert: ((cluster1 nodeAt: 1) nodeAt: 1) value equals: 0.
	self assert: ((cluster1 nodeAt: 1) nodeAt: 2) value equals: 1.
	self assert: (cluster1 nodeAt: 2) value equals: 3.
	self assert: (cluster1 nodeAt: 3) value equals: 2.
	self assert: cluster2 isHiDeItem.
	self assert: cluster2 value equals: 5
]
