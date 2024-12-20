Class {
	#name : 'HiDeAbstractFlatSorter',
	#superclass : 'HiDeAbstractSorter',
	#category : 'HiDeHo-Sorter',
	#package : 'HiDeHo-Sorter'
}

{ #category : 'private' }
HiDeAbstractFlatSorter >> createMerge: aCollectionOfHiDeSequence [

	| newSequence |
	newSequence := HiDeSequence new: (aCollectionOfHiDeSequence
			                inject: 0
			                into: [ :subtotal :sequence |
			                subtotal + sequence numberOfOperations ]).
	aCollectionOfHiDeSequence operationsDo: [ :operation |
		newSequence add: operation ].
	^ newSequence
]
