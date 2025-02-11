Class {
	#name : 'HiDeButtonTableColumn',
	#superclass : 'SpTableColumn',
	#instVars : [
		'action',
		'color'
	],
	#category : 'HiDeHo-UI',
	#package : 'HiDeHo-UI'
}

{ #category : 'visiting' }
HiDeButtonTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitButtonColumn: self
]

{ #category : 'accessing' }
HiDeButtonTableColumn >> action [

	^ action
]

{ #category : 'accessing' }
HiDeButtonTableColumn >> action: aBlock [

	action := aBlock
]

{ #category : 'accessing' }
HiDeButtonTableColumn >> color [

	^ color
]

{ #category : 'accessing' }
HiDeButtonTableColumn >> color: aColor [

	color := aColor
]
