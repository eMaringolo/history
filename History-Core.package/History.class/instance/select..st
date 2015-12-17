enumerating
select: aBlock
	"Answer the elements of the receiver for which the evaluation 
	 of the one argument block, aBlock returns true."
	
	^self elements asOrderedCollection select: aBlock