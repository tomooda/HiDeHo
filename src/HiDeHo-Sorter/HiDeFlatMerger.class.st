Class {
	#name : 'HiDeFlatMerger',
	#superclass : 'HiDeMerger',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'merging' }
HiDeFlatMerger >> createMerge: aCollectionOfHiDeSequence [

	| newSequence |
	newSequence := HiDeSequence new: (aCollectionOfHiDeSequence
			                inject: 0
			                into: [ :subtotal :sequence |
			                subtotal + sequence numberOfOperations ]).
	aCollectionOfHiDeSequence do: [ :sequence |
		sequence operationHoldersDo: [ :holder | newSequence add: holder ] ].
	^ newSequence
]
