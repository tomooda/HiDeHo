Class {
	#name : 'HiDeAbstractSorter',
	#superclass : 'Object',
	#instVars : [
		'sequences'
	],
	#category : 'HiDeHo-Sorter',
	#package : 'HiDeHo-Sorter'
}

{ #category : 'private' }
HiDeAbstractSorter >> createMerge: aCollectionOfHiDeSequence [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
HiDeAbstractSorter >> initialize [

	super initialize.
	sequences := OrderedCollection new
]

{ #category : 'adding/removing' }
HiDeAbstractSorter >> merge: aCollectionOfHiDeNode [

	| mergedSequence |
	aCollectionOfHiDeNode do: [ :node |
		(sequences includes: node) ifFalse: [
			^ ValueNotFound signalFor: node ] ].
	mergedSequence := self createMerge: aCollectionOfHiDeNode.
	sequences removeAll: aCollectionOfHiDeNode.
	^ mergedSequence
]
