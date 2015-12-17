enumerating
detect: aBlock ifNone: exceptionBlock
	"Answer the first element of the receiver for which the evaluation 
	 of the one argument block, aBlock returns true."

	^ self elements detect: aBlock ifNone: exceptionBlock