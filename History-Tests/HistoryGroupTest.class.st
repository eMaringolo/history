Class {
	#name : #HistoryGroupTest,
	#superclass : #TestCase,
	#category : 'History-Tests'
}

{ #category : #'sample data' }
HistoryGroupTest >> sampleElements [
	^ {(HistoryTestElement at: '2015-01-01' asDate tag: $A).
	(HistoryTestElement at: '2015-03-01' asDate tag: $A).
	(HistoryTestElement at: '2015-05-01' asDate tag: $A).
	(HistoryTestElement at: '2015-07-01' asDate tag: $A)}
		,
			{(HistoryTestElement at: '2015-02-01' asDate tag: $B).
			(HistoryTestElement at: '2015-04-01' asDate tag: $B).
			(HistoryTestElement at: '2015-06-01' asDate tag: $B).
			(HistoryTestElement at: '2015-08-01' asDate tag: $B)}
]

{ #category : #'sample data' }
HistoryGroupTest >> sampleOwners [
	^ {$A.
	$B}
]

{ #category : #tests }
HistoryGroupTest >> testInstantiationFromElements [
	| group |
	group := (HistoryGroup new
		owners: self sampleOwners;
		ownerSelector: #tag;
		magnitudeSelector: #magnitude;
		setElements: self sampleElements) yourself.
	self assert: group histories size equals: 2.
	self assert: group owners size equals: 2.
	self assert: self sampleOwners = (group histories collect: #owner) asArray
]

{ #category : #tests }
HistoryGroupTest >> testInstantiationFromHistories [
	| group histories |
	histories := self sampleOwners
		collect: [ :owner | History of: owner withAll: (self sampleElements select: [ :each | each tag = owner ]) selector: #magnitude ].
	group := HistoryGroup withAll: histories.
	self assert: group histories size equals: 2.
	self assert: group owners size equals: 2.
	self assert: self sampleOwners = (group histories collect: #owner) asArray
]

{ #category : #tests }
HistoryGroupTest >> testQueryingAtDate [
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
]

{ #category : #tests }
HistoryGroupTest >> testQueryingNotExistingOwner [
	| group |
	group := (HistoryGroup new
		owners: self sampleOwners;
		ownerSelector: #tag;
		magnitudeSelector: #magnitude;
		setElements: self sampleElements) yourself.
	group useApplicabilityLookup.
	self assert: (group at: '2015-01-15' asDate of: $C) equals: nil
]
