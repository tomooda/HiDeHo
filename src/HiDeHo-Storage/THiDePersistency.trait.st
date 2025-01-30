Trait {
	#name : 'THiDePersistency',
	#instVars : [
		'name',
		'timestamp',
		'comment',
		'fileReference'
	],
	#classTraits : '{} + TraitedClass',
	#category : 'HiDeHo-Storage',
	#package : 'HiDeHo-Storage'
}

{ #category : 'accessing' }
THiDePersistency >> comment [

	^ comment
]

{ #category : 'defaults' }
THiDePersistency >> defaultTimestamp [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
THiDePersistency >> initialize [

	super initialize.
	timestamp := self defaultTimestamp
]

{ #category : 'storage' }
THiDePersistency >> load [

	self
		loadMetadata;
		loadPayload
]

{ #category : 'storage' }
THiDePersistency >> loadMetadata [

	self metadataFileReference ifNotNil: [ :ref |
		ref ifExists: [
			([ ref readStreamDo: [ :stream | STONJSON fromStream: stream ] ]
				 on: Exception
				 do: [ :ex | ex return: nil ]) ifNotNil: [ :json |
				self metadata: json ] ] ]
]

{ #category : 'storage' }
THiDePersistency >> loadPayload [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
THiDePersistency >> metadata [

	| json |
	json := OrderedDictionary new.
	name ifNotNil: [ json at: 'name' put: name ].
	timestamp ifNotNil: [ json at: 'timestamp' put: timestamp asString ].
	comment ifNotNil: [ json at: 'comment' put: comment ].
	^ json
]

{ #category : 'accessing' }
THiDePersistency >> metadata: aDictionary [

	aDictionary
		at: 'name' ifPresent: [ :n | name := n ];
		at: 'timestamp' ifPresent: [ :t | timestamp := t asDateAndTime ];
		at: 'comment' ifPresent: [ :c | comment := c ]
]

{ #category : 'accessing' }
THiDePersistency >> metadataFileReference [

	^ fileReference ifNotNil: [ fileReference / self metadataFilename ]
]

{ #category : 'accessing' }
THiDePersistency >> metadataFilename [

	^ 'metadata.json'
]

{ #category : 'accessing' }
THiDePersistency >> name [

	^ name
]

{ #category : 'storage' }
THiDePersistency >> save [

	self
		saveMetadata;
		savePayload
]

{ #category : 'storage' }
THiDePersistency >> saveMetadata [

	self metadataFileReference ifNotNil: [ :ref |
		ref parent isDirectory ifTrue: [
			ref ensureDelete.
			ref writeStreamDo: [ :stream |
				STONJSON put: self metadata onStream: stream ] ] ]
]

{ #category : 'storage' }
THiDePersistency >> savePayload [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
THiDePersistency >> timestamp [

	^ timestamp
]
