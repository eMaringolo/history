accessing
registry
	"Return the value of registry."

	registry isNil ifTrue: [self initializeRegistry].
	^registry