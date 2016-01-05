tests
testApplicabilityLookup
	| h |
	h := History
		of: $A
		withAll:
			{(HistoryTestElement at: '2015-01-01' asDate tag: $A).
			(HistoryTestElement at: '2015-03-01' asDate tag: $A).
			(HistoryTestElement at: '2015-06-01' asDate tag: $A).
			(HistoryTestElement at: '2015-09-01' asDate tag: $A)}
		selector: #magnitude.
	h lookupPolicy: History applicabilityLookup.
	self assert: (h at: '2014-01-01' asDate ifAbsent: [ nil ]) equals: nil.
	self assert: (h at: '2015-01-15' asDate) magnitude equals: '2015-01-01' asDate.
	self assert: (h at: '2015-03-01' asDate) magnitude equals: '2015-03-01' asDate.
	self assert: (h at: '2015-12-12' asDate) magnitude equals: '2015-09-01' asDate