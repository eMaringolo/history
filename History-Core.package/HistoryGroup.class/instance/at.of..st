querying
at: aDate of: anObject
	"Answer the element of the history belonging to anObject which 
	is located at aDate in time, raise an error if no element is found."
	
	^self at: aDate of: anObject ifAbsent: []