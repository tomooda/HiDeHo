Trait {
	#name : 'THiDePersistency',
	#instVars : [
		'hideMetadata',
		'hideStorage'
	],
	#classTraits : '{} + TraitedClass',
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoad [

	hideStorage ifNotNil: [ hideStorage chronicleLoad: self ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoad: aFileReference [

	^ hideStorage ifNotNil: [
		  self hideLoad: aFileReference storage: hideStorage ]
]

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
THiDePersistency >> hideSave [

	hideStorage ifNotNil: [ hideStorage chronicleSave: self ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSave: aFileReference [

	^ hideStorage ifNotNil: [
		  self hideSave: aFileReference storage: hideStorage ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSave: aFileReference storage: aHiDeStorage [

	^ self subclassResponsibility
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideStorage [

	^ hideStorage
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideStorage: aHiDeStorage [

	hideStorage := aHiDeStorage
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideUpdateMetadataStorage: aHiDeStorage [

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

{ #category : 'copying' }
THiDePersistency >> postCopy [

	super postCopy.
	hideMetadata := hideMetadata copy
]
