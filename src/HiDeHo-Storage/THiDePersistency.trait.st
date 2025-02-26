Trait {
	#name : 'THiDePersistency',
	#instVars : [
		'hideMetadata',
		'hideStorage'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'hideho-accessing' }
THiDePersistency >> hideBaseDirectory [

	^ self hideBaseDirectoryDo: #yourself
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideBaseDirectoryDo: aBlock [

	^ hideStorage ifNotNil: [
		  hideStorage chronicleFileReferenceFor: hideMetadata do: aBlock ]
]

{ #category : 'hideho-testing' }
THiDePersistency >> hideIsAutoExpirable [

	^ false
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoad [

	self hideBaseDirectoryDo: [ :ref | self hideLoad: ref ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoad: aFileReference [

	^ self subclassResponsibility
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoadMetadata: aFileReference [

	hideMetadata load: aFileReference
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
THiDePersistency >> hideRemove [

	hideStorage ifNotNil: [ hideStorage chronicleRemove: self ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSave [

	hideStorage ifNotNil: [ hideStorage chronicleSave: self ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSave: aFileReference [

	^ self subclassResponsibility
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSaveMetadata [

	hideStorage ifNotNil: [ hideStorage chronicleSaveMetadata: self ]
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
THiDePersistency >> hideUnload [

	self class allSlots do: [ :slot |
		(slot isKindOf: HiDePersistencySlot) ifTrue: [ slot unload: self ] ]
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
