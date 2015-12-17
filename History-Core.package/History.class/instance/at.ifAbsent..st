accessing
at: aDate ifAbsent: aBlock
	^ (self lookupElementAt: aDate) ifNil: [ aBlock value ]