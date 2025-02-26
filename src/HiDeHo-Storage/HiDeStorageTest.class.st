Class {
	#name : 'HiDeStorageTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem',
		'root',
		'storage'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeStorageTest >> setUp [

	filesystem := FileSystem memory.
	root := filesystem root.
	storage := HiDeStorageForTesting new
		           basepath: root;
		           yourself
]

{ #category : 'tests' }
HiDeStorageTest >> testChronicleLoad [

	| object id |
	object := HiDePersistencyObjectForTesting new.
	object hideStorage: storage.
	object hideMetadata at: 'name' put: 'test name'.
	object x: 10.
	storage chronicleSave: object.
	id := object hideMetadata identity.
	object := HiDePersistencyObjectForTesting new.
	object hideMetadata identity: id.
	self assert: object x isNil.
	self assert: (object hideMetadata at: 'name' ifAbsent: [ nil ]) isNil.
	storage chronicleLoad: object.
	self assert: object x equals: 10.
	self assert: (object hideMetadata at: 'name') equals: 'test name'.
	self assert: (object hideMetadata at: 'x') equals: '10'
]

{ #category : 'tests' }
HiDeStorageTest >> testChronicleMaxDays [

	storage chronicleMaxDays: nil.
	self assert: storage chronicleMaxDays isNil.
	storage chronicleMaxDays: 10.
	self assert: storage chronicleMaxDays equals: 10
]

{ #category : 'tests' }
HiDeStorageTest >> testChronicleMaxSize [

	storage chronicleMaxSize: nil.
	self assert: storage chronicleMaxSize isNil.
	storage chronicleMaxSize: 1000.
	self assert: storage chronicleMaxSize equals: 1000
]

{ #category : 'tests' }
HiDeStorageTest >> testChronicleSave [

	| object ref metadata |
	object := HiDePersistencyObjectForTesting new.
	object hideMetadata at: 'name' put: 'test name'.
	ref := storage chronicleSave: object.
	self assert: ref basename equals: object hideMetadata identity.
	self assert: (ref / 'metadata.json') isFile.
	self assert: (ref / 'x.json') isFile.
	metadata := HiDeMetadata load: ref.
	self assert: (metadata at: 'x') equals: 'nil'.
	self assert: (metadata at: 'name') equals: 'test name'.
	self
		assert: (STONJSON fromStream: (ref / 'x.json') readStream)
		equals: nil
]

{ #category : 'tests' }
HiDeStorageTest >> testEnsureIdentity [

	| metadata id |
	metadata := HiDeMetadata new.
	metadata at: 'name' put: 'test name'.
	self assert: metadata identity isNil.
	id := storage ensureIdentity: metadata.
	self assert: metadata identity equals: id.
	self
		assert:
		(storage chronicleFileReferenceDo: [ :ref | ref ]) childNames
		equals: { id }.
	self assert: (storage ensureIdentity: metadata) equals: id.
	self assert: metadata identity equals: id
]

{ #category : 'tests' }
HiDeStorageTest >> testLoadNarratives [

	| narrative1 narrative2 |
	narrative1 := HiDeNarrative new
		              name: 'test narrative 1';
		              identity: 'narrative-1.json';
		              storage: storage;
		              save;
		              yourself.
	narrative2 := HiDeNarrative new
		              name: 'test narrative 2';
		              identity: 'narrative-2.json';
		              storage: storage;
		              save;
		              yourself.
	storage loadNarratives.
	self assert: (storage narratives collect: #name) asArray equals: ({
			 narrative1.
			 narrative2 } collect: #name)
]

{ #category : 'tests' }
HiDeStorageTest >> testLoadSettings [

	storage chronicleMaxDays: 10.
	storage chronicleMaxSize: 1000.
	storage saveSettings.
	storage chronicleMaxDays: nil.
	storage chronicleMaxSize: nil.
	storage loadSettings.
	self assert: storage chronicleMaxDays equals: 10.
	self assert: storage chronicleMaxSize equals: 1000
]

{ #category : 'tests' }
HiDeStorageTest >> testNarrative [

	| item narrative |
	item := HiDePersistencyObjectForTesting new
		        hideStorage: storage;
		        hideSave;
		        yourself.
	narrative := HiDeNarrative new
		             name: 'test narrative';
		             storage: storage;
		             add: item;
		             yourself.
	storage narrativeSave: narrative.
	self assert: (storage narrative: narrative identity) equals: { item }
]

{ #category : 'tests' }
HiDeStorageTest >> testNarrativeAt [

	| narrative1 narrative2 |
	narrative1 := HiDeNarrative new
		              name: 'test narrative 1';
		              identity: 'narrative-1.json';
		              storage: storage;
		              save;
		              yourself.
	narrative2 := HiDeNarrative new
		              name: 'test narrative 2';
		              identity: 'narrative-2.json';
		              storage: storage;
		              save;
		              yourself.
	storage loadNarratives.
	self
		assert: (storage narrativeAt: 'narrative-1.json') name
		equals: 'test narrative 1'.
	self
		assert: (storage narrativeAt: 'narrative-2.json') name
		equals: 'test narrative 2'
]

{ #category : 'tests' }
HiDeStorageTest >> testNarrativeAtDo [

	| item narrative |
	item := HiDePersistencyObjectForTesting new
		        hideStorage: storage;
		        hideSave;
		        yourself.
	narrative := HiDeNarrative new
		             name: 'test narrative';
		             storage: storage;
		             add: item;
		             yourself.
	storage narrativeSave: narrative.
	self
		assert: (Array streamContents: [ :stream |
				 storage
					 narrativeAt: narrative identity
					 do: [ :i | stream nextPut: i ] ])
		equals: { item }
]

{ #category : 'tests' }
HiDeStorageTest >> testNarrativeNameAt [

	| narrative1 narrative2 |
	narrative1 := HiDeNarrative new
		              name: 'test narrative 1';
		              identity: 'narrative-1.json';
		              storage: storage;
		              save;
		              yourself.
	narrative2 := HiDeNarrative new
		              name: 'test narrative 2';
		              identity: 'narrative-2.json';
		              storage: storage;
		              save;
		              yourself.
	storage loadNarratives.
	self
		assert: (storage narrativeNameAt: 'narrative-1.json')
		equals: 'test narrative 1'.
	self
		assert: (storage narrativeNameAt: 'narrative-2.json')
		equals: 'test narrative 2'
]

{ #category : 'tests' }
HiDeStorageTest >> testSaveSettings [

	| json |
	storage chronicleMaxDays: 10.
	storage chronicleMaxSize: 1000.
	storage saveSettings.
	json := storage settingsFileReferenceDo: [ :ref |
		        STONJSON fromStream: ref readStream ].
	self assert: (json at: 'chronicle-max-days') equals: 10.
	self assert: (json at: 'chronicle-max-size') equals: 1000
]

{ #category : 'tests' }
HiDeStorageTest >> testTemporaryDirectoryReferenceDo [

	| x y tmpRef |
	x := 10.
	y := nil.
	tmpRef := nil.
	storage temporaryDirectoryReferenceDo: [ :ref |
		tmpRef := ref.
		(ref / 'test')
			writeStreamDo: [ :stream | STONJSON put: x onStreamPretty: stream ];
			readStreamDo: [ :stream | y := STONJSON fromStream: stream ] ].
	self assert: y equals: x.
	self deny: tmpRef exists
]
