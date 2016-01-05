baselines
baseline1: spec
	<version: '1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/emaringolo/History/main/'.
			spec
				package: #'History-Core';
				package: #'History-Tests' with: [ spec requires: #('History-Core') ].
			spec
				group: 'default' with: #('History-Tests');
				group: 'core' with: #('History-Core') ]