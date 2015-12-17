initializing
initializeHistoriesUsing: aCollection
	"Private - Initializes the histories of receiver using aCollection of elements.
	NOTE: For performance reasons we first store the elements in a separate collection
	and then asign them to each history, this way, we reduce the sorting overload on each history."

	| elementsByOwner |
	elementsByOwner := Dictionary new.
	self owners
		do: [ :owner | 
			elementsByOwner at: owner put: OrderedCollection new.
			self registerNewHistoryFor: owner ].
	aCollection do: [ :each | (elementsByOwner at: (each perform: self ownerSelector)) add: each ].
	registry
		keysAndValuesDo: [ :owner :history | history setElements: ((elementsByOwner at: owner) asSortedCollection: history) ]