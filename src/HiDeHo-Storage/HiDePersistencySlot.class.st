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

{ #category : 'comparing' }
HiDePersistencySlot >> = other [

	^ super = other and: [ loader = other loader ]
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> basicRead: aHiDePersistency [

	^ self object: aHiDePersistency instVarAt: index
]

{ #category : 'accessing' }
HiDePersistencySlot >> defaultLoader [

	^ #hideLoad
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> emitValue: aMethodBuilder [

	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read:
]

{ #category : 'comparing' }
HiDePersistencySlot >> hasSameDefinitionAs: otherVariable [
	
 	^(super hasSameDefinitionAs: otherVariable) 
		and: [ loader = otherVariable loader ]
]

{ #category : 'comparing' }
HiDePersistencySlot >> hash [

	^ super hash bitXor: loader hash
]

{ #category : 'initialization' }
HiDePersistencySlot >> initialize [

	super initialize.
	loader := self defaultLoader
]

{ #category : 'initialization' }
HiDePersistencySlot >> initialize: aHiDePersistency [

	self initializeUnloaded
]

{ #category : 'initialization' }
HiDePersistencySlot >> initializeUnloaded [

	unloaded ifNil: [ unloaded := Object new ].
	loader ifNil: [ loader := self defaultLoader ]
]

{ #category : 'accessing' }
HiDePersistencySlot >> loader [

	^ loader
]

{ #category : 'accessing' }
HiDePersistencySlot >> loader: aSymbolOrBlock [

	loader := aSymbolOrBlock
]

{ #category : 'printing' }
HiDePersistencySlot >> printOn: aStream [

	aStream
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name.
	loader ~= self defaultLoader ifTrue: [
		aStream nextPutAll: ' loader: '.
		loader printOn: aStream ]
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
