Class {
	#name : 'HiDeStorage',
	#superclass : 'Object',
	#instVars : [
		'basepath',
		'chronicleMaxSize',
		'chronicleMaxDays',
		'semaphore'
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
		updateChronicle
]

{ #category : 'accessing-files' }
HiDeStorage >> basepathDo: aBlock [

	^ basepath ifNotNil: [ :ref |
		  ref ensureCreateDirectory.
		  aBlock cull: ref copy ]
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
HiDeStorage >> chronicleFileReferenceFor: aHiDePersistency do: aBlock [

	self chronicleFileReferenceDo: [ :baseDir |
		^ aBlock cull: baseDir / (self ensureIdentity: aHiDePersistency) ].
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

{ #category : 'controlling' }
HiDeStorage >> critical: aBlock [

	^ semaphore critical: aBlock
]

{ #category : 'operations' }
HiDeStorage >> ensureIdentity: aHiDePersistency [

	aHiDePersistency hideIdentity ifNotNil: [ :id | ^ id ] ifNil: [
		| timestamp random prefix |
		timestamp := aHiDePersistency hideTimestamp ifNil: [
			             DateAndTime now ].
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
				ref := chronicleDir
				       / (prefix , (String streamContents: [ :stream |
						         12 timesRepeat: [
							         stream nextPut:
								         ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at:
									          (random nextInteger: 32)) ] ])).
				([ ref fileSystem createDirectory: ref ]
					 on: Exception
					 do: [ :ex | ex return: nil ]) ifNotNil: [
					^ aHiDePersistency hideIdentity: ref basename ] ] ] ].
	^ nil
]

{ #category : 'operations' }
HiDeStorage >> identitiesInChronicleDo: aBlock [

	self chronicleFileReferenceDo: [ :chronicle |
		chronicle directoryNames
			select: [ :name | (name includes: $.) not ]
			thenDo: aBlock ]
]

{ #category : 'initialization' }
HiDeStorage >> initialize [

	super initialize.
	semaphore := Semaphore forMutualExclusion
]

{ #category : 'operations' }
HiDeStorage >> loadFromChronicle: aHiDePersistency [

	self chronicleFileReferenceFor: aHiDePersistency do: [ :ref |
		^ aHiDePersistency
			  hideLoad: ref;
			  yourself ].
	^ nil
]

{ #category : 'operations' }
HiDeStorage >> loadSettings [

	self settingsFileReferenceDo: [ :ref |
		([ ref readStreamDo: [ :stream | STONJSON fromStream: stream ] ]
			 on: Exception
			 do: [ :ex | ex return: nil ]) ifNotNil: [ :json |
			self settings: json ] ]
]

{ #category : 'operations' }
HiDeStorage >> saveSettings [

	self settingsFileReferenceDo: [ :ref |
		ref
			ensureDelete;
			writeStreamDo: [ :stream |
				STONJSON put: self settings onStreamPretty: stream ] ]
]

{ #category : 'operations' }
HiDeStorage >> saveToChronicle: aHiDePersistency [

	self
		ensureIdentity: aHiDePersistency;
		chronicleFileReferenceFor: aHiDePersistency do: [ :ref |
			| backupRef |
			backupRef := ref copy renameTo:
					             (ref withExtension: 'moving') basename.
			aHiDePersistency hideSave: ref ensureCreateDirectory.
			backupRef ensureDeleteAll.
			^ ref ].
	^ nil
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

{ #category : 'updating' }
HiDeStorage >> updateChronicle [

	
]
