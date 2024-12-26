Class {
	#name : 'HiDeHierarchicalMerger',
	#superclass : 'HiDeMerger',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'merging' }
HiDeHierarchicalMerger >> createMerge: aCollectionOfHiDeClosure [

	^ (HiDeClosure new: aCollectionOfHiDeClosure size)
		  addAll: aCollectionOfHiDeClosure;
		  yourself
]
