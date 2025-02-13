Class {
	#name : 'HiDePersistencySlot',
	#superclass : 'InstanceVariableSlot',
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> emitValue: aMethodBuilder [

	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read:
]

{ #category : 'initialization' }
HiDePersistencySlot >> initialize: aHiDePersistency [

	self write: HiDeUnloaded current to: aHiDePersistency
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> read: aHiDePersistency [

	^ (super read: aHiDePersistency) ifHiDeUnloaded: [
		  aHiDePersistency hideLoad.
		  super read: aHiDePersistency ]
]

{ #category : 'meta-object-protocol' }
HiDePersistencySlot >> wantsInitialization [

	^ true
]
