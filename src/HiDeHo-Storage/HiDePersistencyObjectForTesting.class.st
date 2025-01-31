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

{ #category : 'comparing' }
HiDePersistencyObjectForTesting >> = anObject [

	^ self class = anObject class and: [
		  name = anObject name and: [
			  timestamp = anObject timestamp and: [
				  comment = anObject comment and: [ x = anObject x ] ] ] ]
]

{ #category : 'defaults' }
HiDePersistencyObjectForTesting >> defaultTimestamp [

	^ DateAndTime now
]

{ #category : 'comparing' }
HiDePersistencyObjectForTesting >> hash [

	^ self class hash bitXor: (name hash bitXor:
			   (timestamp hash bitXor: (comment hash bitXor: x hash)))
]

{ #category : 'storage' }
HiDePersistencyObjectForTesting >> loadPayload [

	x := self payloadFileReference readStreamDo: [ :stream |
		     STONJSON fromStream: stream ]
]

{ #category : 'accessing-files' }
HiDePersistencyObjectForTesting >> payloadFileReference [

	^ persistencyFileReference ifNotNil: [ persistencyFileReference / self payloadFilename ]
]

{ #category : 'accessing-files' }
HiDePersistencyObjectForTesting >> payloadFilename [

	^ 'x.json'
]

{ #category : 'storage' }
HiDePersistencyObjectForTesting >> savePayload [

	self payloadFileReference
		ensureDelete;
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
