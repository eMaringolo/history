accessing
historyOf: anObject
	"Answer the history belonging to anObject."
	
	^self registry at: anObject ifAbsentPut: [self newHistoryFor: anObject]