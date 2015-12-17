querying
allFrom: aDate to: anotherDate
	"Answer a collection of elements in the receiver for all the owners from aDate to anotherDate."

	^self registry values
		inject: Set new
		into: [:result :each | result addAll: (each from: aDate to: anotherDate); yourself]