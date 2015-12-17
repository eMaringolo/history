configuring
defaultOwnerSelector
	"Answer the default owner selector of receiver instances."

	DefaultOwnerSelector ifNil: [ DefaultOwnerSelector := #owner ].
	^ DefaultOwnerSelector