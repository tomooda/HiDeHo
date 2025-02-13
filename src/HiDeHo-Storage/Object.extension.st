Extension { #name : 'Object' }

{ #category : '*HiDeHo-Storage' }
Object >> ifHiDeLoaded: aBlock [

	^ aBlock cull: self
]

{ #category : '*HiDeHo-Storage' }
Object >> ifHiDeLoaded: aBlock unloaded: anotherBlock [

	^ aBlock cull: self
]

{ #category : '*HiDeHo-Storage' }
Object >> ifHiDeUnloaded: aBlock [

	
]
