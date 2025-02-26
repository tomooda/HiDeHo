Class {
	#name : 'HiDeNarrativeTest',
	#superclass : 'TestCase',
	#instVars : [
		'filesystem',
		'root',
		'storage',
		'narrative'
	],
	#category : 'HiDeHo-Storage-Tests',
	#package : 'HiDeHo-Storage',
	#tag : 'Tests'
}

{ #category : 'running' }
HiDeNarrativeTest >> setUp [

	filesystem := FileSystem memory.
	root := filesystem root.
	storage := HiDeStorageForTesting new
		           basepath: root;
		           yourself.
	narrative := HiDeNarrative new
		             storage: storage;
		             yourself
]

{ #category : 'running' }
HiDeNarrativeTest >> testAdd [

	| testItem id |
	testItem := HiDePersistencyObjectForTesting new
		            hideStorage: storage;
		            yourself.
	narrative add: testItem.
	id := testItem hideMetadata identity.
	self assert: (narrative instVarNamed: #items) asArray equals: { id }
]

{ #category : 'running' }
HiDeNarrativeTest >> testAddAll [

	| id1 item1 id2 item2 |
	id1 := (item1 := HiDePersistencyObjectForTesting new
		                 hideStorage: storage;
		                 hideSave;
		                 yourself) hideMetadata identity.
	1 milliSeconds wait.
	id2 := (item2 := HiDePersistencyObjectForTesting new
		                 hideStorage: storage;
		                 hideSave;
		                 yourself) hideMetadata identity.
	self assert: id1 < id2.
	narrative addAll: {
			item1.
			item2 }.
	self assert: (narrative instVarNamed: #items) asArray equals: {
			id2.
			id1 }
]

{ #category : 'running' }
HiDeNarrativeTest >> testDo [

	| testItem |
	testItem := HiDePersistencyObjectForTesting new
		            hideStorage: storage;
		            hideSave;
		            yourself.
	narrative add: testItem.

	self
		assert: (Array streamContents: [ :stream |
				 narrative do: [ :item | stream nextPut: item ] ])
		equals: { testItem }
]

{ #category : 'running' }
HiDeNarrativeTest >> testIdentity [

	narrative identity: 'test identity'.
	self assert: narrative identity equals: 'test identity'
]

{ #category : 'running' }
HiDeNarrativeTest >> testLoad [

	(root / 'test identity')
		ensureDelete;
		writeStreamDo: [ :stream |
			STONJSON
				put: {
						('identity' -> 'test identity').
						('name' -> 'test name').
						('items' -> { 'test item' }) } asDictionary
				onStream: stream ].
	narrative identity: 'test identity'.
	narrative load.
	self assert: narrative identity equals: 'test identity'.
	self assert: narrative name equals: 'test name'.
	self
		assert: (narrative instVarNamed: #items) asArray
		equals: { 'test item' }
]

{ #category : 'running' }
HiDeNarrativeTest >> testName [

	narrative name: 'test name'.
	self assert: narrative name equals: 'test name'
]

{ #category : 'running' }
HiDeNarrativeTest >> testRemove [

	| testItem id |
	testItem := HiDePersistencyObjectForTesting new
		            hideStorage: storage;
		            hideSave;
		            yourself.
	id := testItem hideMetadata identity.
	narrative add: testItem.
	self assert: ((narrative instVarNamed: #items) includes: id).
	narrative remove: testItem.
	self deny: ((narrative instVarNamed: #items) includes: id)
]

{ #category : 'running' }
HiDeNarrativeTest >> testRemoveAll [

	| id1 item1 id2 item2 |
	id1 := (item1 := HiDePersistencyObjectForTesting new
		                 hideStorage: storage;
		                 hideSave;
		                 yourself) hideMetadata identity.
	id2 := (item2 := HiDePersistencyObjectForTesting new
		                 hideStorage: storage;
		                 hideSave;
		                 yourself) hideMetadata identity.
	narrative addAll: {
			item1.
			item2 }.
	self assert: (narrative instVarNamed: #items) asArray equals: {
			id2.
			id1 }.
	narrative removeAll: {
			item1.
			item2 }.
	self assert: (narrative instVarNamed: #items) isEmpty
]

{ #category : 'running' }
HiDeNarrativeTest >> testSave [

	| testItem json |
	testItem := HiDePersistencyObjectForTesting new
		            hideStorage: storage;
		            hideSave;
		            yourself.
	narrative add: testItem.
	narrative name: 'test name'.
	narrative identity: 'test identity'.
	narrative save.
	root / 'test identity' readStreamDo: [ :stream |
		json := STONJSON fromStream: stream ].
	self assert: (json at: 'name') equals: 'test name'.
	self assert: (json at: 'identity') equals: 'test identity'.
	self
		assert: (json at: 'items')
		equals: { testItem hideMetadata identity }
]

{ #category : 'running' }
HiDeNarrativeTest >> testStorage [

	narrative storage: nil.
	self assert: narrative storage isNil.
	narrative storage: storage.
	self assert: narrative storage identicalTo: storage
]
