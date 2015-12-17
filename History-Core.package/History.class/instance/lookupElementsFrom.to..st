lookup
lookupElementsFrom: aDate to: anotherDate
	"Private - Lookups the elements in the receiver cache from aDate to abotherDate using the lookup strategy."
	
	| current result |
	self lookupPolicy == self class currentPolicy ifTrue: [current := self lookupElementAt: aDate].
	result := self elements select: [:each | (each perform: self dateSelector) between: aDate and: anotherDate].
	current ifNotNil: [:value | result add: value ].
	^result