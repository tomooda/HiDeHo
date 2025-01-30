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

{ #category : 'accessing' }
HiDeStorage >> basepath: aFileReference [

	basepath := aFileReference
]

{ #category : 'accessing' }
HiDeStorage >> basepathDo: aBlock [

	^ basepath ifNotNil: [ :ref |
		  ref ensureCreateDirectory.
		  aBlock cull: ref ]
]

{ #category : 'accessing' }
HiDeStorage >> chronicleDirname [

	^ 'chronicle'
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
HiDeStorage >> settingsFileReferenceDo: aBlock [

	^ self basepathDo: [ :ref | aBlock cull: ref / self settingsFilename ]
]

{ #category : 'accessing' }
HiDeStorage >> settingsFilename [

	^ 'settings.json'
]
