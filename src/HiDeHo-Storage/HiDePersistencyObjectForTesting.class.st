Class {
	#name : 'HiDePersistencyObjectForTesting',
	#superclass : 'Object',
	#traits : 'THiDePersistency',
	#classTraits : 'THiDePersistency classTrait',
	#instVars : [
		'x'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'hideho-operations' }
HiDePersistencyObjectForTesting >> hideLoad: aFileReference storage: aHiDeStorage [

	x := aFileReference / 'x.json' readStreamDo: [ :stream |
		     STONJSON fromStream: stream ]
]

{ #category : 'hideho-operations' }
HiDePersistencyObjectForTesting >> hideSave: aFileReference storage: aHiDeStorage [

	(aFileReference / 'x.json')
		ensureDelete;
		writeStreamDo: [ :stream | STONJSON put: x onStreamPretty: stream ]
]

{ #category : 'hideho-operations' }
HiDePersistencyObjectForTesting >> hideUpdateMetadataStorage: aHiDeStorage [

	hideMetadata at: 'x' put: x asString
]

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> x [

	^ x
]

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> x: anInteger [

	x := anInteger
]
