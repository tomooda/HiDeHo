Class {
	#name : 'HiDePersistencyObjectForTesting',
	#superclass : 'Object',
	#traits : 'THiDePersistency',
	#classTraits : 'THiDePersistency classTrait',
	#instVars : [
		'#x => HiDePersistencySlot'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> basicX [

	^ (self class slotNamed: #x) basicRead: self
]

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

{ #category : 'initialization' }
HiDePersistencyObjectForTesting >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeHideMetadata
]

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> x [

	^ x
]

{ #category : 'accessing' }
HiDePersistencyObjectForTesting >> x: anInteger [

	x := anInteger
]
