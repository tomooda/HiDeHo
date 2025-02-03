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
	self assert: (object hideMetadata at: 'name') equals: 'test name'
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

	| object ref |
	object := HiDePersistencyObjectForTesting new.
	object hideMetadata at: 'name' put: 'test name'.
	ref := storage chronicleSave: object.
	self assert: ref basename equals: object hideMetadata identity.
	self assert: (ref / 'metadata.json') isFile.
	self assert: (ref / 'x.json') isFile
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
