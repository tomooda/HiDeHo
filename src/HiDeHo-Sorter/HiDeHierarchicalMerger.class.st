Class {
	#name : 'HiDeHierarchicalMerger',
	#superclass : 'HiDeMerger',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'merging' }
HiDeHierarchicalMerger >> createMerge: aCollectionOfHiDeSequence [

	^ (HiDeSequence new: aCollectionOfHiDeSequence size)
		  addAll: aCollectionOfHiDeSequence;
		  yourself
]
