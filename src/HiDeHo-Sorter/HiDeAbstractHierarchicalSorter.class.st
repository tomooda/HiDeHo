Class {
	#name : 'HiDeAbstractHierarchicalSorter',
	#superclass : 'HiDeAbstractSorter',
	#category : 'HiDeHo-Sorter',
	#package : 'HiDeHo-Sorter'
}

{ #category : 'private' }
HiDeAbstractHierarchicalSorter >> createMerge: aCollectionOfHiDeSequence [

	^ (HiDeSequence new: aCollectionOfHiDeSequence size)
		  addAll: aCollectionOfHiDeSequence;
		  yourself
]
