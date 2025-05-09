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
			package: 'HiDeHo-Sorter'
			with: [ spec requires: #( 'HiDeHo-Node' ) ];
			package: 'HiDeHo-Syntax' with: [ spec requires: #(  ) ];
			package: 'HiDeHo-Storage' with: [ spec requires: #(  ) ];
			package: 'HiDeHo-UI' with: [ spec requires: #(  ) ] ].
	spec
		group: 'core'
		with:
			#( 'HiDeHo-Node' 'HiDeHo-Sorter' 'HiDeHo-Syntax' 'HiDeHo-Storage'
			   'HiDeHo-UI' );
		group: 'full' with: #( 'core' );
		group: 'default' with: #( 'full' )
]
