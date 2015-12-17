initializing
setHistories: aCollection

	self owners: (aCollection collect: [:each | each perform: self ownerSelector]).
	aCollection do: [ :each | self registry at: each owner put: each ]
	