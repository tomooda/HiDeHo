Class {
	#name : 'HiDeTagFilterPresenter',
	#superclass : 'SpTablePresenter',
	#instVars : [
		'requiredTags',
		'rejectTags',
		'tagHistogram',
		'filterChangeAction',
		'checkboxColumn',
		'tagColumn',
		'quantityColumn'
	],
	#category : 'HiDeHo-UI',
	#package : 'HiDeHo-UI'
}

{ #category : 'api' }
HiDeTagFilterPresenter >> checkboxColumnTitle: aString [

	checkboxColumn ifNotNil: [ :column | column title: aString ]
]

{ #category : 'initialization' }
HiDeTagFilterPresenter >> initialize [

	super initialize.
	requiredTags := Set new.
	rejectTags := Set new.
	tagHistogram := Bag new.
	filterChangeAction := [  ].
	self
		beResizable;
		addColumn: ((checkboxColumn := HiDeButtonTableColumn
				                    title: (self iconNamed: #edit)
				                    evaluated: [ :tag |
					                    (requiredTags includes: tag)
						                    ifTrue: [ self iconNamed: #smallAdd ]
						                    ifFalse: [
							                    (rejectTags includes: tag)
								                    ifTrue: [ self iconNamed: #smallCancel ]
								                    ifFalse: [ '' ] ] ])
				 color: Color lightGray;
				 action: [ :tag |
					 (requiredTags includes: tag)
						 ifTrue: [
							 requiredTags remove: tag ifAbsent: [  ].
							 rejectTags add: tag ]
						 ifFalse: [
							 (rejectTags includes: tag)
								 ifTrue: [ rejectTags remove: tag ifAbsent: [  ] ]
								 ifFalse: [ requiredTags add: tag ] ].
					 self triggerFilterChangeAction ];
				 beNotExpandable;
				 width: 20;
				 color: Color transparent;
				 yourself);
		addColumn: (tagColumn := SpStringTableColumn
				              title: 'tag'
				              evaluated: [ :tag | tag ]) beSortable;
		addColumn: ((quantityColumn := SpStringTableColumn
				                    title: '# tagged'
				                    evaluated: [ :tag |
					                    (tagHistogram occurrencesOf: tag) asString ])
				 width: 80;
				 beSortable;
				 sortFunction:
					 [ :tag | tagHistogram occurrencesOf: tag ] ascending;
				 yourself)
]

{ #category : 'api' }
HiDeTagFilterPresenter >> persistencies: aCollectionOfHiDePersistency [

	tagHistogram := aCollectionOfHiDePersistency
		                inject: Bag new
		                into: [ :tags :persistency |
			                tags
				                addAll: persistency tags;
				                yourself ].
	requiredTags := requiredTags select: [ :tag |
		                tagHistogram includes: tag ].
	self items: tagHistogram asSet asSortedCollection
]

{ #category : 'api' }
HiDeTagFilterPresenter >> quantityColumnTitle: aString [

	quantityColumn ifNotNil: [ :column | column title: aString ]
]

{ #category : 'api' }
HiDeTagFilterPresenter >> tagColumnTitle: aString [

	tagColumn ifNotNil: [ :column | column title: aString ]
]

{ #category : 'updating' }
HiDeTagFilterPresenter >> triggerFilterChangeAction [

	filterChangeAction ifNotNil: #value
]

{ #category : 'api' }
HiDeTagFilterPresenter >> value: aHiDePersistency [

	^ (requiredTags allSatisfy: [ :tag |
		   aHiDePersistency hideMetadata hasTag: tag ]) and: [
		  rejectTags allSatisfy: [ :tag |
			  (aHiDePersistency hideMetadata hasTag: tag) not ] ]
]

{ #category : 'api - events' }
HiDeTagFilterPresenter >> whenFilterChangedDo: aBlock [

	filterChangeAction := aBlock
]
