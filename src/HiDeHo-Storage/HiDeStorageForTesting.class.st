Class {
	#name : 'HiDeStorageForTesting',
	#superclass : 'HiDeStorage',
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'class access' }
HiDeStorageForTesting >> payloadClassFor: aHiDeMetadata [

	^ HiDePersistencyObjectForTesting
]
