Extension { #name : 'Collection' }

{ #category : '*HiDeHo-Node' }
Collection >> asHiDeSequence [

	^ HiDeSequence withAll: self
]
