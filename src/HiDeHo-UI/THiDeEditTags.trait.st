Trait {
	#name : 'THiDeEditTags',
	#category : 'HiDeHo-UI',
	#package : 'HiDeHo-UI'
}

{ #category : 'operations' }
THiDeEditTags >> editTags: aCollectionOfString on: aHiDePersistency title: aString createNewTagTitle: anotherString okAction: aBlock [

	| listEditor |
	listEditor := HiDeListEditPresenter new.
	listEditor
		items: aHiDePersistency hideMetadata tags;
		addAction: [
			| menu |
			menu := listEditor newMenu.
			(aCollectionOfString asArray copyWithoutAll: listEditor items)
				asSortedCollection do: [ :tag |
					menu addItem: [ :item |
							item
								name: tag;
								action: [
									listEditor items: (listEditor items asSortedCollection
												 add: tag;
												 yourself) ] ] ].
			menu addItem: [ :item |
				item
					name: anotherString , '...';
					action: [
						(UIManager default request: anotherString) ifNotNil: [ :tag |
								listEditor items: (listEditor items asSortedCollection
											 add: tag trim;
											 yourself) ] ] ].
			menu openWithSpecAtPointer ];
		removeAction: [
			listEditor items:
				(listEditor items copyWithout: listEditor selectedItem) ].
	listEditor openDialog
		title: aString;
		okAction: [
			aHiDePersistency hideMetadata tags: listEditor items.
			aHiDePersistency hideSave.
			aBlock ifNotNil: #value ]
]
