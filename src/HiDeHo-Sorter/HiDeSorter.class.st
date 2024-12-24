Class {
	#name : 'HiDeSorter',
	#superclass : 'Object',
	#instVars : [
		'sequence',
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

	merger add: anObject to: sequence withMatcher: matcher.
	^ anObject
]

{ #category : 'accessing' }
HiDeSorter >> at: anInteger [

	^ sequence at: anInteger
]

{ #category : 'matching' }
HiDeSorter >> beExclusive [

	exclusive := true
]

{ #category : 'matching' }
HiDeSorter >> beNonExclusive [

	exclusive := false
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
	sequence := HiDeSequence new.
	merger := self defaultMerger.
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
HiDeSorter >> merger [

	^ merger
]

{ #category : 'merging' }
HiDeSorter >> merger: aHiDeMerger [

	merger := aHiDeMerger
]

{ #category : 'accessing' }
HiDeSorter >> sequence [

	^ sequence
]

{ #category : 'accessing' }
HiDeSorter >> size [

	^ sequence size
]

{ #category : 'merging' }
HiDeSorter >> useFlatMerger [

	merger := HiDeFlatMerger new
]

{ #category : 'merging' }
HiDeSorter >> useHierarchicalMerger [

	merger := HiDeHierarchicalMerger new
]
