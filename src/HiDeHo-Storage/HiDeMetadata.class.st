Class {
	#name : 'HiDeMetadata',
	#superclass : 'OrderedDictionary',
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeMetadata class >> load: aFileReference [

	^ self new
		  load: aFileReference;
		  yourself
]

{ #category : 'accessing' }
HiDeMetadata >> identity [

	^ self at: self identityKey ifAbsent: [ nil ]
]

{ #category : 'accessing' }
HiDeMetadata >> identity: aString [

	aString
		ifNotNil: [ self at: self identityKey put: aString ]
		ifNil: [ self removeKey: self identityKey ifAbsent: [  ] ]
]

{ #category : 'accessing' }
HiDeMetadata >> identityKey [

	^ 'id'
]

{ #category : 'initialization' }
HiDeMetadata >> initialize [

	super initialize.
	self at: self identityKey put: nil.
	self at: self timestampKey put: DateAndTime now
]

{ #category : 'storage' }
HiDeMetadata >> load: aFileReference [

	aFileReference / self metadataFilename ifExists: [ :ref |
		[
		(ref readStreamDo: [ :stream | STONJSON fromStream: stream ])
			keysAndValuesDo: [ :key :value | self at: key put: value ] ]
			on: Exception
			do: [ :ex | ex return: nil ] ]
]

{ #category : 'accessing' }
HiDeMetadata >> metadataFilename [

	^ 'metadata.json'
]

{ #category : 'storage' }
HiDeMetadata >> save: aFileReference [

	aFileReference isDirectory ifTrue: [
		(aFileReference / self metadataFilename)
			ensureDelete;
			writeStreamDo: [ :stream | STONJSON put: self onStream: stream ] ]
]

{ #category : 'accessing' }
HiDeMetadata >> timestamp [

	^ (self
		   at: self timestampKey
		   ifAbsentPut: [ DateAndTime now asString ]) asDateAndTime
]

{ #category : 'accessing' }
HiDeMetadata >> timestamp: aDateAndTimeOrString [

	aDateAndTimeOrString
		ifNotNil: [
		self at: self timestampKey put: aDateAndTimeOrString asString ]
		ifNil: [ self removeKey: self timestampKey ifAbsent: [  ] ]
]

{ #category : 'accessing' }
HiDeMetadata >> timestampKey [

	^ 'timestamp'
]
