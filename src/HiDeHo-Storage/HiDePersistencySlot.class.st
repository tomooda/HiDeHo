Class {
	#name : 'HiDePersistencySlot',
	#superclass : 'InstanceVariableSlot',
	#instVars : [
		'loader',
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
HiDePersistencySlot >> initialize [

	super initialize.
	loader := #hideLoad
]

{ #category : 'initialization' }
HiDePersistencySlot >> initialize: aHiDePersistency [

	self initializeUnloaded
]

{ #category : 'initialization' }
HiDePersistencySlot >> initializeUnloaded [

	unloaded ifNil: [ unloaded := Object new ].
	loader ifNil: [ loader := #hideLoad ]
]

{ #category : 'accessing' }
HiDePersistencySlot >> loader [

	^ loader
]

{ #category : 'accessing' }
HiDePersistencySlot >> loader: aSymbolOrBlock [

	loader := aSymbolOrBlock
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> read: aHiDePersistency [

	| value |
	^ (value := self basicRead: aHiDePersistency) == unloaded
		  ifTrue: [
			  loader value: aHiDePersistency.
			  (value := self basicRead: aHiDePersistency) == unloaded
				  ifTrue: [ nil ]
				  ifFalse: [ value ] ]
		  ifFalse: [ value ]
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> unload: aHiDePersistency [

	self write: unloaded to: aHiDePersistency
]

{ #category : 'accessing' }
HiDePersistencySlot >> unloaded [

	^ unloaded
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> wantsInitialization [

	^ true
]
