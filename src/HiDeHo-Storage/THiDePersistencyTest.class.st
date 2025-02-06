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
]

{ #category : 'tests' }
THiDePersistencyTest >> testHiDeSave [

	| copy |
	object x: 10.
	object hideStorage: storage.
	object hideSave: root.
	copy := HiDePersistencyObjectForTesting new.
	copy hideLoad: root storage: storage.
	self assert: copy x equals: object x
]

{ #category : 'tests' }
THiDePersistencyTest >> testHiDeSaveStorage [

	| copy |
	object x: 10.
	object hideSave: root storage: storage.
	copy := HiDePersistencyObjectForTesting new.
	copy hideLoad: root storage: storage.
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
THiDePersistencyTest >> testHideLoadStorage [

	root / 'x.json' writeStreamDo: [ :stream | stream nextPutAll: '10' ].
	object hideLoad: root storage: storage.
	self assert: object x equals: 10
]
