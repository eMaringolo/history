querying
allAt: aDate select: aBlockCondition
	"Answer a collection of elements in the receiver for all the owners
	at aDate. If no element exist for a particular object in aDate, it will
	be ignored silently."

	| result |
	result := OrderedCollection new.	
	self registry do: [:each | 
		(each at: aDate ifAbsent: []) ifNotNil: [:obj | (aBlockCondition value: obj) ifTrue: [ result add: obj ] ]
	].
	^result
	