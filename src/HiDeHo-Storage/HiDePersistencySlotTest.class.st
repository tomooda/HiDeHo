Class {
	#name : 'HiDePersistencySlotTest',
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
HiDePersistencySlotTest >> setUp [

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
HiDePersistencySlotTest >> testBasicRead [

	| copy |
	object x: 10.
	object hideSave.
	copy := HiDePersistencyObjectForTesting new.
	copy hideStorage: storage.
	copy hideMetadata identity: object hideMetadata identity.
	self
		assert: copy basicX
		equals: (object class slotNamed: #x) unloaded
]

{ #category : 'tests' }
HiDePersistencySlotTest >> testRead [

	| copy |
	object x: 10.
	object hideSave.
	copy := HiDePersistencyObjectForTesting new.
	self assert: copy x equals: nil.
	copy hideStorage: storage.
	copy hideMetadata identity: object hideMetadata identity.
	self assert: copy x equals: object x.
	copy hideStorage: nil.
	copy hideMetadata identity: nil.
	self assert: copy x equals: object x
]
