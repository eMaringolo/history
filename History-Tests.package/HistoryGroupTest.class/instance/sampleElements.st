sample data
sampleElements
	^ {(HistoryTestElement at: '2015-01-01' asDate tag: $A).
	(HistoryTestElement at: '2015-03-01' asDate tag: $A).
	(HistoryTestElement at: '2015-05-01' asDate tag: $A).
	(HistoryTestElement at: '2015-07-01' asDate tag: $A)}
		,
			{(HistoryTestElement at: '2015-02-01' asDate tag: $B).
			(HistoryTestElement at: '2015-04-01' asDate tag: $B).
			(HistoryTestElement at: '2015-06-01' asDate tag: $B).
			(HistoryTestElement at: '2015-08-01' asDate tag: $B)}