Extension { #name : 'Object' }

{ #category : '*HiDeHo-Node' }
Object >> asHiDeClosure [

	^ self asHiDeItem asHiDeClosure
]

{ #category : '*HiDeHo-Node' }
Object >> asHiDeItem [
	^ HiDeItem on: self
]

{ #category : '*HiDeHo-Node' }
Object >> asHiDeNode [

	^ self asHiDeItem
]
