Extension { #name : 'SpMorphicTableCellBuilder' }

{ #category : '*HiDeHo-UI' }
SpMorphicTableCellBuilder >> visitButtonColumn: aTableColumn [

	| presenter morph |
	presenter := SpButtonPresenter new
		             addStyle: 'compact';
		             yourself.
	aTableColumn color ifNotNil: [ :color |
		presenter color: aTableColumn color ].

	(aTableColumn readObject: self item) ifNotNil: [ :obj |
		obj isForm
			ifTrue: [ presenter icon: obj ]
			ifFalse: [ presenter label: obj asString ] ].
	aTableColumn action ifNotNil: [ :valuable |
		presenter action: [ valuable cull: self item ] ].

	morph := presenter build.
	presenter adapter applyStyle: morph.
	aTableColumn width ifNotNil: [ :width | morph width: width ].
	morph
		borderColor: Color transparent;
		borderWidth: 0.

	self addCellMorph: morph column: aTableColumn
]
