Class {
	#name : 'HiDeUnloaded',
	#superclass : 'Object',
	#classInstVars : [
		'current'
	],
	#category : 'HiDeHo-Storage-Core',
	#package : 'HiDeHo-Storage',
	#tag : 'Core'
}

{ #category : 'accessing' }
HiDeUnloaded class >> current [

	^ current ifNil: [ current := self ]
]

{ #category : 'controlling' }
HiDeUnloaded >> ifHiDeLoaded: aBlock [

	
]

{ #category : 'controlling' }
HiDeUnloaded >> ifHiDeLoaded: aBlock unloaded: anotherBlock [

	^ anotherBlock value
]

{ #category : 'controlling' }
HiDeUnloaded >> ifHiDeUnloaded: aBlock [

	^ aBlock value
]
