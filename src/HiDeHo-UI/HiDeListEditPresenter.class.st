Class {
	#name : 'HiDeListEditPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'list',
		'addButton',
		'removeButton'
	],
	#category : 'HiDeHo-UI',
	#package : 'HiDeHo-UI'
}

{ #category : 'layout' }
HiDeListEditPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #list;
		  add: (SpBoxLayout newHorizontal
				   add: #addButton width: self buttonHeight;
				   add: #removeButton width: self buttonHeight)
		  expand: false;
		  yourself
]

{ #category : 'api' }
HiDeListEditPresenter >> addAction: aBlock [

	addButton action: aBlock
]

{ #category : 'accessing' }
HiDeListEditPresenter >> addButton [

	^ addButton
]

{ #category : 'api' }
HiDeListEditPresenter >> display: aBlock [

	list display: aBlock
]

{ #category : 'initialization' }
HiDeListEditPresenter >> initializePresenters [

	super initializePresenters.
	list := self newList
		        whenSelectedItemChangedDo: [ self selectionChanged ];
		        yourself.
	addButton := self newButton
		             icon: (self iconNamed: #add);
		             yourself.
	removeButton := self newButton
		                icon: (self iconNamed: #remove);
		                disable;
		                yourself
]

{ #category : 'api' }
HiDeListEditPresenter >> items [

	^ list items
]

{ #category : 'api' }
HiDeListEditPresenter >> items: aCollection [

	list items: aCollection
]

{ #category : 'accessing' }
HiDeListEditPresenter >> list [

	^ list
]

{ #category : 'api' }
HiDeListEditPresenter >> removeAction: aBlock [

	removeButton action: aBlock
]

{ #category : 'accessing' }
HiDeListEditPresenter >> removeButton [

	^ removeButton
]

{ #category : 'accessing' }
HiDeListEditPresenter >> selectedItem [

	^ list selectedItem
]

{ #category : 'updating' }
HiDeListEditPresenter >> selectionChanged [

	self updateButtons
]

{ #category : 'updating' }
HiDeListEditPresenter >> updateButtons [

	list selectedItem
		ifNotNil: [ removeButton enable ]
		ifNil: [ removeButton disable ]
]
