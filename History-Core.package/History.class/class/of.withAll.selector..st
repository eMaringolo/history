instance-creation
of: anObject withAll: elements selector: aSymbol
	^ self new
		owner: anObject;
		magnitudeSelector: aSymbol;
		addAll: elements;
		yourself