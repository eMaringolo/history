configuring
ownerSelector
	"Return the value of ownerSelector."

	^ownerSelector ifNil: [self class defaultOwnerSelector]