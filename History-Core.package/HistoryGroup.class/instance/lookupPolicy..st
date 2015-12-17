configuring
lookupPolicy: aSymbol
	super lookupPolicy: aSymbol.
	self histories do: [ :each | each lookupPolicy: aSymbol ]