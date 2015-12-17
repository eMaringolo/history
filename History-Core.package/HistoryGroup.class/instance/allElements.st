querying
allElements
	"Private - Anwer a collection containing all the elements in the histories of receiver owners."
	
	^self histories
		inject: OrderedCollection new
		into: [:ans :history | ans addAll: history elements; yourself ]