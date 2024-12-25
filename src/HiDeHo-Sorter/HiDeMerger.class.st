Class {
	#name : 'HiDeMerger',
	#superclass : 'Object',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'adding' }
HiDeMerger >> add: anObject to: aHiDeSequence withMatcher: aHiDeMatcher [

	(aHiDeSequence select: [ :sequence |
		 sequence anyOperationSatisfy: [ :operation |
			 aHiDeMatcher value: operation value: anObject ] ])
		ifNotEmpty: [ :matchedNodes |
			(matchedNodes size = 1 and: [ matchedNodes first isSequence ])
				ifTrue: [ matchedNodes first add: anObject asHiDeOperationHolder ]
				ifFalse: [
					| index mergedSequence |
					matchedNodes ifEmpty: [ ^ ValueNotFound signal ].
					index := (matchedNodes collect: [ :node |
						          aHiDeSequence indexOf: node ]) min.
					mergedSequence := self createMerge: matchedNodes.
					aHiDeSequence removeAll: matchedNodes.
					aHiDeSequence add: mergedSequence beforeIndex: index.
					mergedSequence add: anObject asHiDeOperationHolder ] ]
		ifEmpty: [ aHiDeSequence add: anObject asHiDeOperationHolder ]
]

{ #category : 'merging' }
HiDeMerger >> createMerge: aCollectionOfHiDeSequence [

	^ self subclassResponsibility
]
