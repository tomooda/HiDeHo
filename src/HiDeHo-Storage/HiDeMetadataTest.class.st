Class {
	#name : 'HiDeMetadataTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem',
		'root',
		'metadata'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeMetadataTest >> setUp [

	filesystem := FileSystem memory.
	root := filesystem root.
	metadata := HiDeMetadata new
]

{ #category : 'tests' }
HiDeMetadataTest >> testHideSaveMetaData [

	metadata identity: 'test identity'.
	metadata at: 'name' put: 'test name'.
	metadata save: root.
	self assert: (HiDeMetadata load: root) equals: metadata
]

{ #category : 'tests' }
HiDeMetadataTest >> testIdentity [

	self assert: metadata identity isNil.
	metadata identity: 'test identity'.
	self assert: metadata identity equals: 'test identity'
]

{ #category : 'tests' }
HiDeMetadataTest >> testLoad [

	| past |
	past := '1999-12-31T23:59:59.123456+09:00' asDateAndTime.
	root / 'metadata.json' writeStreamDo: [ :stream |
		stream
			nextPutAll: '{"id":"test identity", "timestamp":"';
			nextPutAll: past asString;
			nextPutAll: '", "foo":10}' ].
	self assert: metadata identity isNil.
	self assert: metadata timestamp > past.
	self assert: (metadata at: 'foo' ifAbsent: [ nil ]) isNil.
	metadata load: root.
	self assert: metadata identity equals: 'test identity'.
	self assert: metadata timestamp equals: past.
	self assert: (metadata at: 'foo') equals: 10
]

{ #category : 'tests' }
HiDeMetadataTest >> testSave [

	metadata identity: 'test identity'.
	metadata at: 'name' put: 'test name'.
	metadata save: root.
	self assert: (HiDeMetadata load: root) equals: metadata
]
