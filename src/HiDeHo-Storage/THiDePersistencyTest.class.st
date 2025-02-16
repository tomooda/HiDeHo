Class {
	#name : 'THiDePersistencyTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem',
		'root',
		'object',
		'storage'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'running' }
THiDePersistencyTest >> setUp [

	filesystem := FileSystem memory.
	root := filesystem root.
	storage := HiDeStorageForTesting new
		           basepath: root;
		           yourself.
	object := HiDePersistencyObjectForTesting new
		          hideStorage: storage;
		          yourself
]

{ #category : 'tests' }
THiDePersistencyTest >> testHiDeSave [

	| copy |
	object x: 10.
	object hideSave.
	copy := HiDePersistencyObjectForTesting new.
	copy hideStorage: storage.
	copy hideMetadata identity: object hideMetadata identity.
	copy hideLoad.
	self assert: copy x equals: object x
]

{ #category : 'tests' }
THiDePersistencyTest >> testHideLoad [

	root / 'x.json' writeStreamDo: [ :stream | stream nextPutAll: '10' ].
	object hideStorage: storage.
	object hideLoad: root.
	self assert: object x equals: 10
]

{ #category : 'tests' }
THiDePersistencyTest >> testHideLoadMetadata [

	| metadata |
	metadata := HiDeMetadata new.
	metadata identity: 'test identity'.
	metadata addTag: 'test tag'.
	metadata at: 'name' put: 'test name'.
	metadata save: root.
	object hideLoadMetadata: root.
	self assert: object hideMetadata identity equals: 'test identity'.
	self assert: object hideMetadata tags equals: { 'test tag' }.
	self assert: (object hideMetadata at: 'name') equals: 'test name'
]
