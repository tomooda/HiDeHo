Class {
	#name : 'HiDePersistencySlot',
	#superclass : 'InstanceVariableSlot',
	#instVars : [
		'unloaded'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> basicRead: aHiDePersistency [

	^ self object: aHiDePersistency instVarAt: index
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> emitValue: aMethodBuilder [

	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read:
]

{ #category : 'initialization' }
HiDePersistencySlot >> initialize: aHiDePersistency [

	self initializeUnloaded.
	self write: unloaded to: aHiDePersistency
]

{ #category : 'initialization' }
HiDePersistencySlot >> initializeUnloaded [

	unloaded ifNil: [ unloaded := Object new ]
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> read: aHiDePersistency [

	| value |
	^ (value := self basicRead: aHiDePersistency) == unloaded
		  ifTrue: [
			  aHiDePersistency hideLoad.
			  (value := self basicRead: aHiDePersistency) == unloaded
				  ifTrue: [ nil ]
				  ifFalse: [ value ] ]
		  ifFalse: [ value ]
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> unload: aHiDePersistency [

	self write: unloaded to: aHiDePersistency
]

{ #category : 'initialization' }
HiDePersistencySlot >> unloaded [

	^ unloaded
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> wantsInitialization [

	^ true
]
