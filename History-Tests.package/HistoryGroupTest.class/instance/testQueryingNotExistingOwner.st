tests
testQueryingNotExistingOwner
	| group |
	group := (HistoryGroup new
		owners: self sampleOwners;
		ownerSelector: #tag;
		magnitudeSelector: #magnitude;
		setElements: self sampleElements) yourself.
	group useApplicabilityLookup.
	self assert: (group at: '2015-01-15' asDate of: $C) equals: nil