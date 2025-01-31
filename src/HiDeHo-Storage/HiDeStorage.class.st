Class {
	#name : 'HiDeStorage',
	#superclass : 'Object',
	#instVars : [
		'basepath',
		'chronicleMaxLifetime',
		'chronicleMaxSize'
	],
	#category : 'HiDeHo-Storage',
	#package : 'HiDeHo-Storage'
}

{ #category : 'accessing-files' }
HiDeStorage >> basepath: aFileReference [

	basepath := aFileReference
]

{ #category : 'accessing-files' }
HiDeStorage >> basepathDo: aBlock [

	^ basepath ifNotNil: [ :ref |
		  ref ensureCreateDirectory.
		  aBlock cull: ref ]
]

{ #category : 'accessing-files' }
HiDeStorage >> chronicleDirname [

	^ 'chronicle'
]

{ #category : 'accessing-files' }
HiDeStorage >> chronicleFileReferenceDo: aBlock [

	^ self basepathDo: [ :ref |
		  aBlock cull: ((ref / self chronicleDirname)
				   ensureCreateDirectory;
				   yourself) ]
]

{ #category : 'accessing' }
HiDeStorage >> chronicleMaxLifetime [

	^ chronicleMaxLifetime
]

{ #category : 'accessing' }
HiDeStorage >> chronicleMaxSize [

	^ chronicleMaxSize
]

{ #category : 'operations' }
HiDeStorage >> loadSettings [

	self settingsFileReferenceDo: [ :ref |
		([ ref readStreamDo: [ :stream | STONJSON fromStream: stream ] ]
			 on: Exception
			 do: [ :ex | ex return: nil ]) ifNotNil: [ :json |
			self settings: json ] ]
]

{ #category : 'operations' }
HiDeStorage >> saveSettings [

	self settingsFileReferenceDo: [ :ref |
		ref
			ensureDelete;
			writeStreamDo: [ :stream |
				STONJSON put: self settings onStreamPretty: stream ] ]
]

{ #category : 'accessing' }
HiDeStorage >> settings [

	| json |
	json := OrderedDictionary new.
	chronicleMaxLifetime ifNotNil: [
		json at: 'chronicle-max-lifetime' put: chronicleMaxLifetime ].
	chronicleMaxSize ifNotNil: [
		json at: 'chronicle-max-size' put: chronicleMaxSize ].
	^ json
]

{ #category : 'accessing' }
HiDeStorage >> settings: aDictionary [

	aDictionary
		at: 'chronicle-max-lifetime'
		ifPresent: [ :value | chronicleMaxLifetime := value ];
		at: 'chronicle-max-size'
		ifPresent: [ :value | chronicleMaxSize := value ]
]

{ #category : 'accessing-files' }
HiDeStorage >> settingsFileReferenceDo: aBlock [

	^ self basepathDo: [ :ref | aBlock cull: ref / self settingsFilename ]
]

{ #category : 'accessing-files' }
HiDeStorage >> settingsFilename [

	^ 'settings.json'
]
