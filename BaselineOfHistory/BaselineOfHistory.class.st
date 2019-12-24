Class {
	#name : #BaselineOfHistory,
	#superclass : #BaselineOf,
	#category : #BaselineOfHistory
}

{ #category : #baselines }
BaselineOfHistory >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec package: 'History-Core'.
			spec
				package: 'History-Tests'
				with: [ spec requires: 'History-Core' ].
			spec group: 'default' with: #('History-Tests').
			spec
				group: 'core'
				with: #('History-Core') ]
]
