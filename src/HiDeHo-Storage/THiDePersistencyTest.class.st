Class {
	#name : 'THiDePersistencyTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem',
		'root',
		'object'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'running' }
THiDePersistencyTest >> setUp [

	filesystem := FileSystem memory.
	root := filesystem root.
	object := HiDePersistencyObjectForTesting new
]

{ #category : 'tests' }
THiDePersistencyTest >> testHiDeSave [

	| copy |
	object x: 10.
	object hideMetadataAt: 'name' put: 'test name'.
	object hideSave: root.
	copy := HiDePersistencyObjectForTesting new.
	copy hideLoad: root.
	self assert: copy hideTimestamp equals: object hideTimestamp.
	self
		assert: (copy hideMetadataAt: 'name')
		equals: (object hideMetadataAt: 'name').
	self assert: copy x equals: object x
]

{ #category : 'tests' }
THiDePersistencyTest >> testHideLoad [

	root / 'metadata.json' writeStreamDo: [ :stream |
		stream nextPutAll:
			'{"timestamp" : "2025-02-01T15:19:51.16834+09:00", "name" : "test name" }' ].
	root / 'x.json' writeStreamDo: [ :stream | stream nextPutAll: '10' ].
	object hideLoad: root.
	self assert: object hideTimestamp year equals: 2025.
	self assert: object hideTimestamp hour equals: 15.
	self assert: (object hideMetadataAt: 'name') equals: 'test name'.
	self assert: object x equals: 10
]

{ #category : 'tests' }
THiDePersistencyTest >> testHideLoadMetaData [

	| copy |
	object x: 10.
	object hideMetadataAt: 'name' put: 'test name'.
	object hideSaveMetadata: root.
	copy := HiDePersistencyObjectForTesting new.
	copy hideLoadMetadata: root.
	self assert: copy hideTimestamp equals: object hideTimestamp.
	self
		assert: (copy hideMetadataAt: 'name')
		equals: (object hideMetadataAt: 'name').
	self assert: copy x isNil
]

{ #category : 'tests' }
THiDePersistencyTest >> testHideLoadMetadata [

	root / 'metadata.json' writeStreamDo: [ :stream |
		stream nextPutAll:
			'{"timestamp" : "2025-02-01T15:19:51.16834+09:00", "name" : "test name" }' ].
	object hideLoadMetadata: root.
	self assert: object hideTimestamp year equals: 2025.
	self assert: object hideTimestamp hour equals: 15.
	self assert: (object hideMetadataAt: 'name') equals: 'test name'.
	self assert: object x isNil
]

{ #category : 'tests' }
THiDePersistencyTest >> testHideSaveMetaData [

	| copy |
	object x: 10.
	object hideMetadataAt: 'name' put: 'test name'.
	object hideSaveMetadata: root.
	copy := HiDePersistencyObjectForTesting new.
	copy hideLoadMetadata: root.
	self assert: copy hideTimestamp equals: object hideTimestamp.
	self
		assert: (copy hideMetadataAt: 'name')
		equals: (object hideMetadataAt: 'name').
	self assert: copy x isNil
]
