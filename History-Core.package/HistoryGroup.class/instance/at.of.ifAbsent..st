querying
at: aDate of: anObject ifAbsent: aBlock
	"Answer the element of the history belonging to anObject which 
	is located at aDate in time, evaluates aBlock if no element is found."

	^ (self historyOf: anObject) at: aDate ifAbsent: aBlock