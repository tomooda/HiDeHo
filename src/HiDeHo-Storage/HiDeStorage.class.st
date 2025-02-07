Class {
	#name : 'HiDeStorage',
	#superclass : 'Object',
	#instVars : [
		'basepath',
		'chronicleMaxSize',
		'chronicleMaxDays',
		'chronicle'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'accessing-files' }
HiDeStorage >> basepath: aFileReference [

	basepath := aFileReference.
	self basepathChanged
]

{ #category : 'updating' }
HiDeStorage >> basepathChanged [

	self
		loadSettings;
		loadChronicle
]

{ #category : 'accessing-files' }
HiDeStorage >> basepathDo: aBlock [

	^ basepath ifNotNil: [ :ref |
		  ref ensureCreateDirectory.
		  aBlock cull: ref copy ]
]

{ #category : 'operations' }
HiDeStorage >> chronicle [

	^ chronicle values asSortedCollection: [ :older :newer |
		  older hideMetadata timestamp <= newer hideMetadata timestamp ]
]

{ #category : 'operations' }
HiDeStorage >> chronicleAdd: aHiDePersistency [

	self chronicleSave: aHiDePersistency.
	chronicle
		at: aHiDePersistency hideMetadata identity
		put: aHiDePersistency
]

{ #category : 'operations' }
HiDeStorage >> chronicleAt: aString [

	^ self chronicleAt: aString ifAbsent: [ nil ]
]

{ #category : 'operations' }
HiDeStorage >> chronicleAt: aString ifAbsent: errorBlock [

	^ chronicle
		  at: aString
		  ifPresent: [ :payload | self chronicleLoad: payload ]
		  ifAbsent: errorBlock
]

{ #category : 'accessing-files' }
HiDeStorage >> chronicleDirname [

	^ 'chronicle'
]

{ #category : 'accessing-files' }
HiDeStorage >> chronicleFileReferenceDo: aBlock [

	^ self basepathDo: [ :ref |
		  aBlock cull: ((ref / self chronicleDirname)
				   ensureCreateDirectory;
				   copy) ]
]

{ #category : 'accessing-files' }
HiDeStorage >> chronicleFileReferenceFor: aHiDeMetadata do: aBlock [

	self chronicleFileReferenceDo: [ :baseDir |
		^ aBlock cull: baseDir / (self ensureIdentity: aHiDeMetadata) ].
	^ nil
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleLoad: aHiDePersistency [

	self
		chronicleFileReferenceFor: aHiDePersistency hideMetadata
		do: [ :ref |
			aHiDePersistency hideMetadata load: ref.
			aHiDePersistency hideLoad: ref storage: self.
			^ aHiDePersistency ].
	^ nil
]

{ #category : 'accessing' }
HiDeStorage >> chronicleMaxDays [

	^ chronicleMaxDays
]

{ #category : 'accessing' }
HiDeStorage >> chronicleMaxDays: anInteger [

	chronicleMaxDays := anInteger
]

{ #category : 'accessing' }
HiDeStorage >> chronicleMaxSize [

	^ chronicleMaxSize
]

{ #category : 'accessing' }
HiDeStorage >> chronicleMaxSize: anInteger [

	chronicleMaxSize := anInteger
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleMetadataDo: aBlock [

	self chronicleFileReferenceDo: [ :chronicleRef |
		chronicleRef directories
			select: [ :ref | (ref basename includes: $.) not ]
			thenDo: [ :ref | (HiDeMetadata load: ref) ifNotNil: aBlock ] ]
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleSave: aHiDePersistency [

	self
		ensureIdentity: aHiDePersistency hideMetadata;
		chronicleFileReferenceFor: aHiDePersistency hideMetadata
		do: [ :ref |
			| backupRef |
			backupRef := ref withExtension: 'moving'.
			ref copyTo: backupRef.
			ref ensureDeleteAllChildren.
			aHiDePersistency hideUpdateMetadataStorage: self.
			aHiDePersistency hideMetadata save: ref.
			aHiDePersistency hideStorage: self.
			aHiDePersistency hideSave: ref storage: self.
			backupRef ensureDeleteAll.
			^ ref ].
	^ nil
]

{ #category : 'operations-chronicle' }
HiDeStorage >> createPayloadFor: aHiDeMetadata [

	^ (self payloadClassFor: aHiDeMetadata) new
		  hideMetadata: aHiDeMetadata;
		  hideStorage: self;
		  yourself
]

{ #category : 'operations-chronicle' }
HiDeStorage >> ensureIdentity: aHiDeMetadata [

	aHiDeMetadata identity ifNotNil: [ :id | ^ id ] ifNil: [
		| timestamp random prefix |
		timestamp := aHiDeMetadata timestamp ifNil: [ DateAndTime now ].
		random := Random new.
		prefix := String streamContents: [ :stream |
			          timestamp year printOn: stream base: 10 nDigits: 4.
			          timestamp month printOn: stream base: 10 nDigits: 2.
			          timestamp dayOfMonth printOn: stream base: 10 nDigits: 2.
			          stream nextPut: $-.
			          timestamp hour printOn: stream base: 10 nDigits: 2.
			          timestamp minute printOn: stream base: 10 nDigits: 2.
			          timestamp second printOn: stream base: 10 nDigits: 2.
			          stream nextPut: $-.
			          timestamp nanoSecond printOn: stream base: 10 nDigits: 9.
			          stream nextPut: $- ].
		self chronicleFileReferenceDo: [ :chronicleDir |
			100 timesRepeat: [
				| ref |
				ref := (chronicleDir
				        / (prefix , (String streamContents: [ :stream |
						          12 timesRepeat: [
							          stream nextPut:
								          ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at:
									           (random nextInteger: 32)) ] ]))) resolve.
				([ ref fileSystem createDirectory: ref ]
					 on: Exception
					 do: [ :ex | ex return: nil ]) ifNotNil: [
					aHiDeMetadata identity: ref basename.
					^ aHiDeMetadata identity ] ] ] ].
	^ nil
]

{ #category : 'initialization' }
HiDeStorage >> initialize [

	super initialize.
	chronicle := Dictionary new
]

{ #category : 'operations' }
HiDeStorage >> loadChronicle [

	chronicle removeAll.
	self chronicleMetadataDo: [ :metadata |
		chronicle
			at: metadata identity
			ifAbsentPut: [ self createPayloadFor: metadata ] ]
]

{ #category : 'operations-settings' }
HiDeStorage >> loadSettings [

	self settingsFileReferenceDo: [ :ref |
		([ ref readStreamDo: [ :stream | STONJSON fromStream: stream ] ]
			 on: Exception
			 do: [ :ex | ex return: nil ]) ifNotNil: [ :json |
			self settings: json ] ]
]

{ #category : 'class access' }
HiDeStorage >> metadataClass [

	^ HiDeMetadata
]

{ #category : 'class access' }
HiDeStorage >> payloadClassFor: aHiDeMetadata [

	^ self subclassResponsibility
]

{ #category : 'operations-settings' }
HiDeStorage >> saveSettings [

	self settingsFileReferenceDo: [ :ref |
		ref
			ensureDelete;
			writeStreamDo: [ :stream |
				STONJSON put: self settings onStreamPretty: stream ] ]
]

{ #category : 'accessing' }
HiDeStorage >> settings [

	| json |
	json := OrderedDictionary new.
	chronicleMaxDays ifNotNil: [
		json at: 'chronicle-max-days' put: chronicleMaxDays ].
	chronicleMaxSize ifNotNil: [
		json at: 'chronicle-max-size' put: chronicleMaxSize ].
	^ json
]

{ #category : 'accessing' }
HiDeStorage >> settings: aDictionary [

	aDictionary
		at: 'chronicle-max-days'
		ifPresent: [ :value | chronicleMaxDays := value ];
		at: 'chronicle-max-size'
		ifPresent: [ :value | chronicleMaxSize := value ]
]

{ #category : 'accessing-files' }
HiDeStorage >> settingsFileReferenceDo: aBlock [

	^ self basepathDo: [ :ref |
		  aBlock cull: (ref / self settingsFilename) copy ]
]

{ #category : 'accessing-files' }
HiDeStorage >> settingsFilename [

	^ 'settings.json'
]

{ #category : 'accessing-files' }
HiDeStorage >> temporaryDirectoryReferenceDo: aBlock [

	| random |
	random := Random new.
	self basepathDo: [ :baseRef |
		| tmpBaseRef |
		tmpBaseRef := (baseRef / 'temporary')
			              ensureCreateDirectory;
			              yourself.
		100 timesRepeat: [
			| tmpRef |
			tmpRef := tmpBaseRef / (String streamContents: [ :stream |
				           (random next * 1000000000000) truncated
					           printOn: stream
					           base: 10
					           nDigits: 12 ]).
			([ tmpRef fileSystem createDirectory: tmpRef ]
				 on: Exception
				 do: [ :ex | ex return: nil ]) ifNotNil: [
				^ [ aBlock value: tmpRef copy ] ensure: [
					  [ tmpRef deleteAll ]
						  on: Exception
						  do: [ :ex |  ] ] ] ] ].
	^ nil
]
