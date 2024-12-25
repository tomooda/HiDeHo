Extension { #name : 'Object' }

{ #category : '*HiDeHo-Node' }
Object >> asHiDeNode [

	^ self asHiDeOperationHolder
]

{ #category : '*HiDeHo-Node' }
Object >> asHiDeOperationHolder [
	^ HiDeOperationHolder on: self
]

{ #category : '*HiDeHo-Node' }
Object >> asHiDeSequence [

	^ self asHiDeOperationHolder asHiDeSequence
]
