tests
testInstantiationFromElements
	| group |
	group := (HistoryGroup new
		owners: self sampleOwners;
		ownerSelector: #tag;
		magnitudeSelector: #magnitude;
		setElements: self sampleElements) yourself.
	self assert: group histories size equals: 2.
	self assert: group owners size equals: 2.
	self assert: self sampleOwners = (group histories collect: #owner) asArray