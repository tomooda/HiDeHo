Trait {
	#name : 'THiDePersistency',
	#instVars : [
		'hideMetadata'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'hideho-initialization' }
THiDePersistency >> hideDefaultTimestamp [

	^ self subclassResponsibility
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoad: aFileReference [

	self
		hideLoadMetadata: aFileReference;
		hideLoadPayload: aFileReference
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoadMetadata: aFileReference [

	aFileReference / self hideMetadataFilename ifExists: [ :ref |
		([ ref readStreamDo: [ :stream | STONJSON fromStream: stream ] ]
			 on: Exception
			 do: [ :ex | ex return: nil ]) ifNotNil: [ :json |
			hideMetadata := json ] ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideLoadPayload: aFileReference [

	^ self subclassResponsibility
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideMetadataAt: aString [

	^ hideMetadata at: aString ifAbsent: [ nil ]
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideMetadataAt: aString ifAbsent: errorBlock [

	^ hideMetadata at: aString ifAbsent: errorBlock
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideMetadataAt: aString ifAbsentPut: errorBlock [

	^ hideMetadata at: aString ifAbsentPut: errorBlock
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideMetadataAt: aString put: errorBlock [

	^ hideMetadata at: aString put: errorBlock
]

{ #category : 'hideho-files' }
THiDePersistency >> hideMetadataFilename [

	^ 'metadata.json'
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSave: aFileReference [

	self
		hideSaveMetadata: aFileReference;
		hideSavePayload: aFileReference
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSaveMetadata: aFileReference [

	aFileReference isDirectory ifTrue: [
		(aFileReference / self hideMetadataFilename)
			ensureDelete;
			writeStreamDo: [ :stream |
				STONJSON put: hideMetadata onStream: stream ] ]
]

{ #category : 'hideho-operations' }
THiDePersistency >> hideSavePayload: aFileReference [

	^ self subclassResponsibility
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideTimestamp [

	^ (self hideMetadataAt: self hideTimestampKey) asDateAndTime
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideTimestamp: aDateTime [

	self hideMetadataAt: self hideTimestampKey put: aDateTime asString
]

{ #category : 'hideho-accessing' }
THiDePersistency >> hideTimestampKey [

	^ 'timestamp'
]

{ #category : 'initialization' }
THiDePersistency >> initialize [

	super initialize.
	self initializeHideMetadata
]

{ #category : 'hideho-initialization' }
THiDePersistency >> initializeHideMetadata [

	hideMetadata := OrderedDictionary new
		                  at: self hideTimestampKey
		                  put: self hideDefaultTimestamp asString;
		                  yourself
]
