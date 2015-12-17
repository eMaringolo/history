operations
newHistoryFor: anOwner
	"Private - Answer a new history on the receiver for anOwner."

	^ (History of: anOwner selector: self magnitudeSelector)
		lookupPolicy: self lookupPolicy;
		yourself