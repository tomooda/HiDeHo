Class {
	#name : 'BaselineOfHiDeHo',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfHiDeHo',
	#package : 'BaselineOfHiDeHo'
}

{ #category : 'baselines' }
BaselineOfHiDeHo >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec blessing: #baseline.
		spec
			package: 'HiDeHo-Node' with: [ spec requires: #(  ) ];
			package: 'HiDeHo-Sorter' with: [ spec requires: #(  ) ] ].
	spec
		group: 'core' with: #( 'HiDeHo-Node' 'HiDeHo-Sorter' );
		group: 'full' with: #( 'core' );
		group: 'default' with: #( 'full' )
]
