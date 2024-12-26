Class {
	#name : 'HiDeMerger',
	#superclass : 'Object',
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'adding' }
HiDeMerger >> add: anObject to: aHiDeClosure withMatcher: aHiDeMatcher [

	(aHiDeClosure selectNodes: [ :closure |
		 closure anySatisfy: [ :object |
			 aHiDeMatcher value: object value: anObject ] ])
		ifNotEmpty: [ :matchedNodes |
			(matchedNodes size = 1 and: [ matchedNodes first isHiDeClosure ])
				ifTrue: [ matchedNodes first add: anObject asHiDeItem ]
				ifFalse: [
					| index mergedClosure |
					matchedNodes ifEmpty: [ ^ ValueNotFound signal ].
					index := (matchedNodes collect: [ :node |
						          aHiDeClosure indexOfNode: node ]) min.
					mergedClosure := self createMerge: matchedNodes.
					aHiDeClosure removeAllNodes: matchedNodes.
					aHiDeClosure add: mergedClosure beforeIndex: index.
					mergedClosure add: anObject asHiDeItem ] ]
		ifEmpty: [ aHiDeClosure add: anObject asHiDeItem ]
]

{ #category : 'merging' }
HiDeMerger >> createMerge: aCollectionOfHiDeClosure [

	^ self subclassResponsibility
]
