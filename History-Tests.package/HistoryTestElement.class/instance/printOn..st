accessing
printOn: aStream
	super printOn: aStream.
	aStream nextPut: $(.
	magnitude printOn: aStream.
	aStream nextPut: $-.
	tag printOn: aStream.
	aStream nextPut: $)