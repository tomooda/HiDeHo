Class {
	#name : 'HiDeAbstractSorter',
	#superclass : 'Object',
	#instVars : [
		'sequences'
	],
	#category : 'HiDeHo-Sorter',
	#package : 'HiDeHo-Sorter'
}

{ #category : 'initialization' }
HiDeAbstractSorter >> initialize [

	super initialize.
	sequences := OrderedCollection new
]
