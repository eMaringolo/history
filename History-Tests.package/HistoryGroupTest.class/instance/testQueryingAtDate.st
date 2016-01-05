tests
testQueryingAtDate
	| group |
	group := (HistoryGroup new
		owners: self sampleOwners;
		ownerSelector: #tag;
		magnitudeSelector: #magnitude;
		setElements: self sampleElements) yourself.
	group useApplicabilityLookup.
	self assert: (group allAt: '2015-01-15' asDate) size equals: 1.
	self assert: (group allAt: '2015-02-01' asDate) size equals: 2.
	self assert: (group allAt: '2015-03-01' asDate) size equals: 2.
	self assert: (group allAt: '2015-04-15' asDate) size equals: 2.
	group useMatchLookup.
	self assert: (group allAt: '2015-01-15' asDate) size equals: 0.
	self assert: (group allAt: '2015-02-01' asDate) size equals: 1.
	self assert: (group allAt: '2015-03-01' asDate) size equals: 1.
	self assert: (group allAt: '2015-04-15' asDate) size equals: 0.	