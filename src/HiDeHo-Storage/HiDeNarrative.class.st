Class {
	#name : 'HiDeNarrative',
	#superclass : 'Object',
	#instVars : [
		'name',
		'identity',
		'items',
		'storage'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'instance creation' }
HiDeNarrative class >> fromFile: aFileReference [

	^ self new
		  load: aFileReference;
		  yourself
]

{ #category : 'instance creation' }
HiDeNarrative class >> id: aString storage: aHiDeStorage [

	^ self new
		  storage: aHiDeStorage;
		  id: aString;
		  load;
		  yourself
]

{ #category : 'adding-removing' }
HiDeNarrative >> add: aHiDePersistency [

	items add: (storage ensureIdentity: aHiDePersistency hideMetadata).
	self save.
	^ aHiDePersistency
]

{ #category : 'adding-removing' }
HiDeNarrative >> addAll: aCollectionOfHiDePersistency [

	aCollectionOfHiDePersistency do: [ :persistency |
		items add: persistency hideMetadata identity ].
	self save
]

{ #category : 'accessing' }
HiDeNarrative >> asArray [

	^ Array streamContents: [ :stream |
		  self do: [ :persistency | stream nextPut: persistency ] ]
]

{ #category : 'enumerating' }
HiDeNarrative >> do: aBlock [

	items do: [:id | storage chronicleAt: id ifPresent: aBlock]
]

{ #category : 'accessing' }
HiDeNarrative >> fileReference [

	^ (storage notNil and: [ identity notNil ])
		  ifTrue: [ storage basepathDo: [ :ref | ref / identity ] ]
		  ifFalse: [ nil ]
]

{ #category : 'accessing' }
HiDeNarrative >> identity [

	^ identity
]

{ #category : 'accessing' }
HiDeNarrative >> identity: aString [

	identity := aString
]

{ #category : 'initialization' }
HiDeNarrative >> initialize [

	super initialize.
	name := ''.
	items := SortedCollection sortBlock:
		         [ :id | (storage chronicleAt: id) hideMetadata timestamp ]
			         descending
]

{ #category : 'operations' }
HiDeNarrative >> load [

	^ self load: self fileReference
]

{ #category : 'operations' }
HiDeNarrative >> load: aFileReference [

	aFileReference ifNotNil: [
		aFileReference ifExists: [
			(aFileReference readStreamDo: [ :stream |
				 [ STONJSON fromStream: stream ]
					 on: Exception
					 do: [ :ex | ex return: nil ] ]) ifNotNil: [ :json |
				json
					at: 'identity' ifPresent: [ :str | identity := str ];
					at: 'name' ifPresent: [ :str | name := str ];
					at: 'items' ifPresent: [ :array |
						items := array asSortedCollection:
								         [ :id |
								         (storage chronicleAt: id) hideMetadata timestamp ]
									         descending ] ] ] ]
]

{ #category : 'accessing' }
HiDeNarrative >> name [

	^ name
]

{ #category : 'accessing' }
HiDeNarrative >> name: aString [

	name := aString
]

{ #category : 'adding-removing' }
HiDeNarrative >> remove: aHiDePersistency [

	items remove: aHiDePersistency hideMetadata identity ifAbsent: [  ].
	self save
]

{ #category : 'adding-removing' }
HiDeNarrative >> removeAll [

	items removeAll.
	self save
]

{ #category : 'adding-removing' }
HiDeNarrative >> removeAll: aCollectionOfHiDePersistency [

	aCollectionOfHiDePersistency do: [ :persistency |
		items remove: persistency hideMetadata identity ifAbsent: [  ] ].
	self save
]

{ #category : 'operations' }
HiDeNarrative >> save [

	^ self save: self fileReference
]

{ #category : 'operations' }
HiDeNarrative >> save: aFileReference [

	aFileReference ifNotNil: [
		aFileReference
			ensureDelete;
			writeStreamDo: [ :stream |
				STONJSON
					put: {
							('identity' -> identity).
							('name' -> name).
							('items' -> items asArray) } asDictionary
					onStream: stream ] ]
]

{ #category : 'accessing' }
HiDeNarrative >> storage [

	^ storage
]

{ #category : 'accessing' }
HiDeNarrative >> storage: aHiDeStorage [

	storage := aHiDeStorage
]
