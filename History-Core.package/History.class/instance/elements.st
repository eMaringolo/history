accessing
elements
	"Return the value of elements."

	elements isNil ifTrue: [self initializeElements].
	^elements