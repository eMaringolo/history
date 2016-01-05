versions
version10: spec
	<version: '1.0' imports: #('1-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #stable.
			spec description: 'version 1.0'.
			spec author: 'EstebanMaringolo'.
			spec timestamp: '12/17/2015 00:34'.
			spec
				package: #'History-Core' with: 'History-Core-EstebanMaringolo.1';
				package: #'History-Tests' with: 'History-Tests-EstebanMaringolo.1' ]