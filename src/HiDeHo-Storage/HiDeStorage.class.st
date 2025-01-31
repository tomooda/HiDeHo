Class {
	#name : 'HiDeStorage',
	#superclass : 'Object',
	#instVars : [
		'basepath',
		'chronicleMaxSize',
		'chronicleMaxDays'
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
		  aBlock cull: ref ]
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
				   yourself) ]
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

	^ self basepathDo: [ :ref | aBlock cull: ref / self settingsFilename ]
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
				^ [ aBlock cull: tmpRef ] ensure: [
					  [ tmpRef deleteAll ]
						  on: Exception
						  do: [ :ex |  ] ] ] ] ].
	^ nil
]

{ #category : 'updating' }
HiDeStorage >> updateChronicle [

	
]
