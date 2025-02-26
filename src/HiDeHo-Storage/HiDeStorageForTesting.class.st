Class {
	#name : 'HiDeStorageForTesting',
	#superclass : 'HiDeStorageWithExpiration',
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'class access' }
HiDeStorageForTesting >> payloadClassFor: aHiDeMetadata [

	^ HiDePersistencyObjectForTesting
]
