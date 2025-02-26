Class {
	#name : 'HiDeStorageWithExpiration',
	#superclass : 'HiDeStorage',
	#instVars : [
		'chronicleMaxSize',
		'chronicleMaxDays'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'testing' }
HiDeStorageWithExpiration class >> isAbstract [

	^ self = HiDeStorageWithExpiration
]

{ #category : 'updating' }
HiDeStorageWithExpiration >> basepathChanged [

	self loadSettings.
	super basepathChanged
]

{ #category : 'operations-chronicle' }
HiDeStorageWithExpiration >> chronicleEnsureStorageLimits [

	self
		chronicleEnsureStorageMaxSize;
		chronicleEnsureStorageMaxDays
]

{ #category : 'operations-chronicle' }
HiDeStorageWithExpiration >> chronicleEnsureStorageMaxDays [

	chronicleMaxDays ifNotNil: [ :maxDays |
		| expiration |
		expiration := DateAndTime now - maxDays days.
		self chronicle reverseDo: [ :persistency |
			expiration <= persistency hideMetadata timestamp ifTrue: [ ^ self ].
			persistency hideIsAutoExpirable ifTrue: [ persistency hideRemove ] ] ]
]

{ #category : 'operations-chronicle' }
HiDeStorageWithExpiration >> chronicleEnsureStorageMaxSize [

	chronicleMaxSize ifNotNil: [ :maxSize |
		[ chronicle size > maxSize ] whileTrue: [
			(self chronicle reverse
				 detect: #hideIsAutoExpirable
				 ifNone: [ ^ self ]) hideRemove ] ]
]

{ #category : 'accessing' }
HiDeStorageWithExpiration >> chronicleMaxDays [

	^ chronicleMaxDays
]

{ #category : 'accessing' }
HiDeStorageWithExpiration >> chronicleMaxDays: anInteger [

	chronicleMaxDays := anInteger
]

{ #category : 'accessing' }
HiDeStorageWithExpiration >> chronicleMaxSize [

	^ chronicleMaxSize
]

{ #category : 'accessing' }
HiDeStorageWithExpiration >> chronicleMaxSize: anInteger [

	chronicleMaxSize := anInteger
]

{ #category : 'operations-chronicle' }
HiDeStorageWithExpiration >> chronicleSave: aHiDePersistency [

	^ (super chronicleSave: aHiDePersistency) ifNotNil: [ :ref |
		  self chronicleEnsureStorageLimits.
		  ref ]
]

{ #category : 'initialization' }
HiDeStorageWithExpiration >> defaultChronicleMaxDays [

	^ nil
]

{ #category : 'initialization' }
HiDeStorageWithExpiration >> defaultChronicleMaxSize [

	^ nil
]

{ #category : 'initialization' }
HiDeStorageWithExpiration >> initialize [

	super initialize.
	chronicleMaxDays := self defaultChronicleMaxDays.
	chronicleMaxSize := self defaultChronicleMaxSize
]

{ #category : 'operations' }
HiDeStorageWithExpiration >> loadChronicle [

	super loadChronicle.
	self chronicleEnsureStorageLimits
]

{ #category : 'operations-settings' }
HiDeStorageWithExpiration >> loadSettings [

	self settingsFileReferenceDo: [ :ref |
		([ ref readStreamDo: [ :stream | STONJSON fromStream: stream ] ]
			 on: Exception
			 do: [ :ex | ex return: nil ]) ifNotNil: [ :json |
			self settings: json ] ]
]

{ #category : 'operations-settings' }
HiDeStorageWithExpiration >> saveSettings [

	self settingsFileReferenceDo: [ :ref |
		ref
			ensureDelete;
			writeStreamDo: [ :stream |
				STONJSON put: self settings onStreamPretty: stream ] ]
]

{ #category : 'accessing' }
HiDeStorageWithExpiration >> settings [

	| json |
	json := OrderedDictionary new.
	chronicleMaxDays ifNotNil: [
		json at: 'chronicle-max-days' put: chronicleMaxDays ].
	chronicleMaxSize ifNotNil: [
		json at: 'chronicle-max-size' put: chronicleMaxSize ].
	^ json
]

{ #category : 'accessing' }
HiDeStorageWithExpiration >> settings: aDictionary [

	chronicleMaxDays := aDictionary
		                    at: 'chronicle-max-days'
		                    ifPresent: [ :value | value ]
		                    ifAbsent: [ nil ].
	chronicleMaxSize := aDictionary
		                    at: 'chronicle-max-size'
		                    ifPresent: [ :value | value ]
		                    ifAbsent: [ nil ]
]

{ #category : 'accessing-files' }
HiDeStorageWithExpiration >> settingsFileReferenceDo: aBlock [

	^ self basepathDo: [ :ref |
		  aBlock cull: (ref / self settingsFilename) copy ]
]

{ #category : 'accessing-files' }
HiDeStorageWithExpiration >> settingsFilename [

	^ 'settings.json'
]
