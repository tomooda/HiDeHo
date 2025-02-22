Class {
	#name : 'HiDeStorage',
	#superclass : 'Object',
	#instVars : [
		'basepath',
		'chronicleMaxSize',
		'chronicleMaxDays',
		'chronicle',
		'narratives'
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
		loadChronicle;
		loadNarratives
]

{ #category : 'accessing-files' }
HiDeStorage >> basepathDo: aBlock [

	^ basepath ifNotNil: [ :ref |
		  ref ensureCreateDirectory.
		  aBlock cull: ref copy ]
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicle [

	^ self chronicleSuchThat: [ :payload | true ]
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleAt: aString [

	^ self chronicleAt: aString ifAbsent: [ nil ]
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleAt: aString ifAbsent: errorBlock [

	^ chronicle at: aString ifAbsent: errorBlock
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleAt: aString ifPresent: aBlock [

	^ chronicle at: aString ifPresent: aBlock
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
			^ aHiDePersistency
				  hideLoadMetadata: ref;
				  hideLoad: ref;
				  hideStorage: self;
				  yourself ].
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
HiDeStorage >> chronicleRemove: aHiDePersistency [

	self
		chronicleFileReferenceFor: aHiDePersistency hideMetadata
		do: [ :ref |
			ref ensureDeleteAll.
			chronicle
				removeKey: aHiDePersistency hideMetadata identity
				ifAbsent: [  ].
			^ ref ].
	^ nil
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
			aHiDePersistency hideSave: ref.
			backupRef ensureDeleteAll.
			chronicle
				at: aHiDePersistency hideMetadata identity
				put: aHiDePersistency.
			^ ref ].
	^ nil
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleSaveMetadata: aHiDePersistency [

	self
		ensureIdentity: aHiDePersistency hideMetadata;
		chronicleFileReferenceFor: aHiDePersistency hideMetadata
		do: [ :ref |
			aHiDePersistency hideMetadata save: ref.
			^ ref ].
	^ nil
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleSuchThat: aBlock [

	| payloads |
	payloads := chronicle values select: [ :payload |
		            aBlock value: payload hideMetadata ].
	^ payloads asSortedCollection:
		  [ :payload | payload hideMetadata timestamp ] descending
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleTags [

	^ (chronicle values inject: Set new into: [ :tags :persistency |
		   tags
			   addAll: persistency hideMetadata tags;
			   yourself ]) asSortedCollection
]

{ #category : 'operations-chronicle' }
HiDeStorage >> chronicleTail [

	| tail tailtime |
	chronicle ifEmpty: [ ^ nil ].
	tail := chronicle values anyOne.
	tailtime := tail hideMetadata timestamp.
	chronicle valuesDo: [ :persistency |
		| time |
		tailtime < (time := persistency hideMetadata timestamp) ifTrue: [
			tail := persistency.
			tailtime := time ] ].
	^ tail
]

{ #category : 'operations-chronicle' }
HiDeStorage >> createPayloadFor: aHiDeMetadata [

	^ (self payloadClassFor: aHiDeMetadata) new
		  hideMetadata: aHiDeMetadata;
		  hideStorage: self;
		  hideUnload;
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

{ #category : 'operations-narrative' }
HiDeStorage >> ensureNarrativeIdentity: aHiDeNarrative [

	^ aHiDeNarrative identity ifNil: [
		  | timestamp random prefix |
		  timestamp := DateAndTime now.
		  random := Random new.
		  prefix := String streamContents: [ :stream |
			            stream nextPutAll: 'narrative-'.
			            timestamp year printOn: stream base: 10 nDigits: 4.
			            timestamp month printOn: stream base: 10 nDigits: 2.
			            timestamp dayOfMonth
				            printOn: stream
				            base: 10
				            nDigits: 2.
			            stream nextPut: $-.
			            timestamp hour printOn: stream base: 10 nDigits: 2.
			            timestamp minute printOn: stream base: 10 nDigits: 2.
			            timestamp second printOn: stream base: 10 nDigits: 2.
			            stream nextPut: $-.
			            timestamp nanoSecond
				            printOn: stream
				            base: 10
				            nDigits: 9.
			            stream nextPut: $- ].
		  100 timesRepeat: [
			  | id |
			  id := prefix , (String streamContents: [ :stream |
				         12 timesRepeat: [
					         stream nextPut:
						         ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at:
							          (random nextInteger: 32)) ] ]) , '.json'.
			  (narratives includesKey: id) ifFalse: [
				  aHiDeNarrative
					  identity: id;
					  storage: self.
				  narratives at: id put: aHiDeNarrative.
				  ^ id ] ].
		  ^ self error: 'Failed to create an identity' ]
]

{ #category : 'operations-narrative' }
HiDeStorage >> hasNarrativeNamed: aString [

	^ narratives anySatisfy: [ :narrative | aString = narrative name ]
]

{ #category : 'initialization' }
HiDeStorage >> initialize [

	super initialize.
	chronicle := Dictionary new.
	narratives := Dictionary new
]

{ #category : 'operations-chronicle' }
HiDeStorage >> loadChronicle [

	chronicle removeAll.
	self chronicleMetadataDo: [ :metadata |
		chronicle
			at: metadata identity
			ifAbsentPut: [ self createPayloadFor: metadata ] ]
]

{ #category : 'operations-narrative' }
HiDeStorage >> loadNarratives [

	self basepathDo: [ :ref |
		(ref filesMatching: 'narrative-*.json') do: [ :file |
			narratives
				at: file basename
				put: (self narrativeClass fromFile: file storage: self) ] ]
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

{ #category : 'operations-narrative' }
HiDeStorage >> narrative: aString [

	^ Array streamContents: [ :stream |
		  self
			  narrativeAt: aString
			  do: [ :persistency | stream nextPut: persistency ] ]
]

{ #category : 'operations-narrative' }
HiDeStorage >> narrativeAt: aString [

	^ narratives at: aString ifAbsent: [ nil ]
]

{ #category : 'operations-narrative' }
HiDeStorage >> narrativeAt: aString do: aBlock [

	^ narratives
		  at: aString
		  ifPresent: [ :narrative | narrative do: aBlock ]
]

{ #category : 'class access' }
HiDeStorage >> narrativeClass [

	^ HiDeNarrative
]

{ #category : 'operations-narrative' }
HiDeStorage >> narrativeNameAt: aString [

	^ narratives at: aString ifPresent: #name ifAbsent: [ nil ]
]

{ #category : 'operations-narrative' }
HiDeStorage >> narrativeSave: aHiDeNarrative [

	self ensureNarrativeIdentity: aHiDeNarrative.
	aHiDeNarrative storage: self.
	aHiDeNarrative save.
	narratives at: aHiDeNarrative identity put: aHiDeNarrative.
	^ aHiDeNarrative
]

{ #category : 'operations-narrative' }
HiDeStorage >> narratives [

	^ narratives values asSortedCollection: #name ascending
]

{ #category : 'operations-narrative' }
HiDeStorage >> newNarrativeNamed: aString [

	| timestamp random prefix |
	timestamp := DateAndTime now.
	random := Random new.
	prefix := String streamContents: [ :stream |
		          stream nextPutAll: 'narrative-'.
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
	100 timesRepeat: [
		| id |
		id := prefix , (String streamContents: [ :stream |
			       12 timesRepeat: [
				       stream nextPut:
					       ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at:
						        (random nextInteger: 32)) ] ]) , '.json'.
		(narratives includesKey: id) ifFalse: [
			^ self narrativeSave:
				  (self narrativeClass identity: id name: aString storage: self) ] ].
	^ nil
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
