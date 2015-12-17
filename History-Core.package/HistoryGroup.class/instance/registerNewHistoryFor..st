operations
registerNewHistoryFor: anOwner 
	"Private - Register and answer a new history on the receiver for anOwner."

	^self registry at: anOwner put: (self newHistoryFor: anOwner)