Trait {
	#name : 'THiDePersistency',
	#instVars : [
		'hideMetadata'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoad: aFileReference storage: aHiDeStorage [

	^ self subclassResponsibility
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideMetadata [

	^ hideMetadata
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideMetadata: aDictionary [

	hideMetadata := aDictionary
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSave: aFileReference storage: aHiDeStorage [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
THiDePersistency >> initialize [

	super initialize.
	self initializeHideMetadata
]

{ #category : 'hideho-initialization' }
THiDePersistency >> initializeHideMetadata [

	hideMetadata := HiDeMetadata new
]
