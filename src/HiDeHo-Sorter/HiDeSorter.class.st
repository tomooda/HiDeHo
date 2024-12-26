Class {
	#name : 'HiDeSorter',
	#superclass : 'Object',
	#instVars : [
		'merger',
		'matcher',
		'closure'
	],
	#category : 'HiDeHo-Sorter-Core',
	#package : 'HiDeHo-Sorter',
	#tag : 'Core'
}

{ #category : 'adding' }
HiDeSorter >> add: anObject [

	merger add: anObject to: closure withMatcher: matcher.
	^ anObject
]

{ #category : 'accessing' }
HiDeSorter >> closure [

	^ closure
]

{ #category : 'matching' }
HiDeSorter >> defaultMatcher [

	^ [ :closure :object | false ]
]

{ #category : 'merging' }
HiDeSorter >> defaultMerger [

	^ HiDeFlatMerger new
]

{ #category : 'accessing' }
HiDeSorter >> identityIndexOf: anObject [

	^ self identityIndexOf: anObject ifAbsent: [ 0 ]
]

{ #category : 'accessing' }
HiDeSorter >> identityIndexOf: anObject ifAbsent: errorBlock [

	^ closure identityIndexOf: anObject ifAbsent: errorBlock
]

{ #category : 'accessing' }
HiDeSorter >> indexOf: anObject ifAbsent: errorBlock [

	^ closure indexOf: anObject ifAbsent: errorBlock
]

{ #category : 'initialization' }
HiDeSorter >> initialize [

	super initialize.
	closure := HiDeClosure new.
	merger := self defaultMerger.
	matcher := self defaultMatcher
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
HiDeSorter >> nodeAt: anInteger [

	^ closure nodeAt: anInteger
]

{ #category : 'accessing' }
HiDeSorter >> numberOfNodes [

	^ closure numberOfNodes
]

{ #category : 'accessing' }
HiDeSorter >> size [

	^ closure size
]

{ #category : 'merging' }
HiDeSorter >> useFlatMerger [

	merger := HiDeFlatMerger new
]

{ #category : 'merging' }
HiDeSorter >> useHierarchicalMerger [

	merger := HiDeHierarchicalMerger new
]
