lookup
lookupElementAt: aDate
	"Private - Lookups the element of receiver in the receiver cache using the lookup strategy."

	^ self lookupPolicy == self class matchLookup
		ifTrue: [ self lookupMatchAt: aDate ]
		ifFalse: [ self lookupApplicableAt: aDate ]