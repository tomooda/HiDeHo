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

{ #category : 'hideho-initialization' }
HiDePersistencyObjectForTesting >> hideDefaultTimestamp [

	^ DateAndTime now
]

{ #category : 'hideho-operations' }
HiDePersistencyObjectForTesting >> hideLoadPayload: aFileReference [

	x := aFileReference / 'x.json' readStreamDo: [ :stream |
		     STONJSON fromStream: stream ]
]

{ #category : 'hideho-operations' }
HiDePersistencyObjectForTesting >> hideSavePayload: aFileReference [

	(aFileReference / 'x.json') ensureDelete;
		writeStreamDo: [ :stream | STONJSON put: x onStreamPretty: stream ]
]

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> x [

	^ x
]

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> x: anInteger [

	x := anInteger
]
