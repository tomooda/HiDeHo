Class {
	#name : 'HiDeFlatMerger',
	#superclass : 'HiDeMerger',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'merging' }
HiDeFlatMerger >> createMerge: aCollectionOfHiDeClosure [

	| newClosure |
	newClosure := HiDeClosure new: (aCollectionOfHiDeClosure
			               inject: 0
			               into: [ :subtotal :closure |
			               subtotal + closure size ]).
	aCollectionOfHiDeClosure do: [ :sequence |
		sequence itemsDo: [ :holder | newClosure add: holder ] ].
	^ newClosure
]
