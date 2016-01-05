tests
testInstantiationFromHistories
	| group histories |
	histories := self sampleOwners
		collect: [ :owner | History of: owner withAll: (self sampleElements select: [ :each | each tag = owner ]) selector: #magnitude ].
	group := HistoryGroup withAll: histories.
	self assert: group histories size equals: 2.
	self assert: group owners size equals: 2.
	self assert: self sampleOwners = (group histories collect: #owner) asArray