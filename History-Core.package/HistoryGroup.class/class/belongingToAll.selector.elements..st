instance-creation
belongingToAll: aCollection selector: aSymbol elements: elements
	^ self new
		owners: aCollection;
		magnitudeSelector: aSymbol;
		setElements: elements;
		yourself