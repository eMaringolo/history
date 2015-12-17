accessing
latest
	"Answer the latest element of receiver that is loaded."
	
	^self elements notEmpty ifTrue: [self elements first]
	