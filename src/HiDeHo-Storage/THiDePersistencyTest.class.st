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
		          persistencyFileReference: root
]

{ #category : 'as yet unclassified' }
THiDePersistencyTest >> testLoad [

	| copy |
	object name: 'test object'.
	object timestamp: DateAndTime now.
	object comment: 'test comment'.
	object x: 10.
	object save.
	copy := HiDePersistencyObjectForTesting new
		        persistencyFileReference: root.
	copy load.
	self assert: copy metadata equals: object metadata.
	self assert: copy x equals: object x
]

{ #category : 'as yet unclassified' }
THiDePersistencyTest >> testLoadMetadata [

	| now |
	object metadataFileReference writeStreamDo: [ :stream |
		STONJSON put: {  } asDictionary onStreamPretty: stream ].
	object loadMetadata.
	self assert: object name isNil.
	self assert: object timestamp notNil.
	self assert: object comment isNil.
	self assert: object x isNil.
	now := DateAndTime now.
	object metadataFileReference writeStreamDo: [ :stream |
		STONJSON
			put: {
					('name' -> 'test name').
					('timestamp' -> now asString).
					('comment' -> 'test comment') } asDictionary
			onStreamPretty: stream ].
	object loadMetadata.
	self assert: object name equals: 'test name'.
	self assert: object timestamp equals: now.
	self assert: object comment equals: 'test comment'.
	self assert: object x isNil
]

{ #category : 'as yet unclassified' }
THiDePersistencyTest >> testPersistencyFileReference [

	object persistencyFileReference: nil.
	self assert: object persistencyFileReference isNil.
	object persistencyFileReference: root.
	self assert: object persistencyFileReference equals: root
]

{ #category : 'as yet unclassified' }
THiDePersistencyTest >> testSave [

	object name: 'test object'.
	object timestamp: DateAndTime now.
	object comment: 'test comment'.
	object x: 10.
	object save.
	self assert: object metadataFileReference exists.
	self assert: object payloadFileReference exists.
	self
		assert:
			(STONJSON fromStream: object metadataFileReference readStream)
				asDictionary
		equals: object metadata asDictionary.
	self
		assert:
		(STONJSON fromStream: object payloadFileReference readStream)
		equals: 10
]

{ #category : 'as yet unclassified' }
THiDePersistencyTest >> testSaveMetadata [

	| json |
	object saveMetadata.
	self assert: (root / object metadataFilename) exists.
	json := STONJSON fromStream:
		        (root / object metadataFilename) readStream.
	self assert: json isDictionary.
	self assert: json keys asSet equals: { 'timestamp' } asSet.
	self
		assert: (json at: 'timestamp') asDateAndTime
		equals: object timestamp.
	object name: 'test object'.
	object timestamp: DateAndTime now.
	object comment: 'test comment'.
	object saveMetadata.
	json := STONJSON fromStream:
		        (root / object metadataFilename) readStream.
	self assert: json isDictionary.
	self assert: (json at: 'name') equals: object name.
	self
		assert: (json at: 'timestamp') asDateAndTime
		equals: object timestamp.
	self assert: (json at: 'comment') equals: object comment
]
