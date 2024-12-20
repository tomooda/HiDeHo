Class {
	#name : 'HiDeSorter',
	#superclass : 'Object',
	#instVars : [
		'sequences',
		'merger',
		'exclusive',
		'matcher'
	],
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'adding' }
HiDeSorter >> add: anObject [

	| newOperationHolder |
	newOperationHolder := HiDeOperationHolder on: anObject.
	(sequences select: [ :sequence |
		 sequence anyOperationSatisfy: [ :operation |
			 matcher value: operation value: anObject ] ])
		ifNotEmpty: [ :matchedSequences |
			(exclusive and: [ matchedSequences size > 1 ])
				ifTrue: [ (self merge: matchedSequences) add: newOperationHolder ]
				ifFalse: [
					matchedSequences do: [ :sequence |
						sequence add: newOperationHolder ] ] ]
		ifEmpty: [
		sequences addLast: (HiDeSequence with: newOperationHolder) ]
]

{ #category : 'accessing' }
HiDeSorter >> at: anInteger [

	^ sequences at: anInteger
]

{ #category : 'matching' }
HiDeSorter >> beExclusive [

	exclusive := true
]

{ #category : 'matching' }
HiDeSorter >> beNonExclusive [

	exclusive := false
]

{ #category : 'private' }
HiDeSorter >> createMerge: aCollectionOfHiDeSequence [

	^ merger createMerge: aCollectionOfHiDeSequence
]

{ #category : 'matching' }
HiDeSorter >> defaultMatcher [

	^ [ :sequence :operation | false ]
]

{ #category : 'merging' }
HiDeSorter >> defaultMerger [

	^ HiDeFlatMerger new
]

{ #category : 'initialization' }
HiDeSorter >> initialize [

	super initialize.
	sequences := OrderedCollection new.
	merger := self defaultMerger.
	exclusive := true.
	matcher := self defaultMatcher
]

{ #category : 'matching' }
HiDeSorter >> isExclusive [

	^ exclusive
]

{ #category : 'matching' }
HiDeSorter >> matcher [

	^ matcher
]

{ #category : 'matching' }
HiDeSorter >> matcher: aBlock [

	matcher := aBlock
]

{ #category : 'merging' }
HiDeSorter >> merge: aCollectionOfHiDeNode [

	| index mergedSequence |
	aCollectionOfHiDeNode ifEmpty: [ ^ ValueNotFound signal ].
	index := (aCollectionOfHiDeNode collect: [ :node |
		          sequences indexOf: node ]) min.
	index = 0 ifTrue: [ ^ ValueNotFound signal ].
	mergedSequence := self createMerge: aCollectionOfHiDeNode.
	sequences removeAll: aCollectionOfHiDeNode.
	sequences add: mergedSequence beforeIndex: index.
	^ mergedSequence
]

{ #category : 'merging' }
HiDeSorter >> merger [

	^ merger
]

{ #category : 'merging' }
HiDeSorter >> merger: aHiDeMerger [

	merger := aHiDeMerger
]

{ #category : 'accessing' }
HiDeSorter >> size [

	^ sequences size
]

{ #category : 'merging' }
HiDeSorter >> useFlatMerger [

	merger := HiDeFlatMerger new
]

{ #category : 'merging' }
HiDeSorter >> useHierarchicalMerger [

	merger := HiDeHierarchicalMerger new
]
