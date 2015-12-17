accessing
at: aDate
	"Answer the element of receiver which is located at aDate in time,
	raise an error if no element is found."

	^self at: aDate ifAbsent: [self errorNotFound]