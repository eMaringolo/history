"
I represent a group of histories, that can provide a single point of entry to query histories belonging to more than one object, and retrieve elements of all those objects at once.


"
Class {
	#name : #HistoryGroup,
	#superclass : #AbstractHistory,
	#instVars : [
		'owners',
		'ownerSelector',
		'registry'
	],
	#classVars : [
		'DefaultOwnerSelector'
	],
	#category : 'History-Core'
}

{ #category : #'instance-creation' }
HistoryGroup class >> belongingToAll: aCollection elements: aCollectionOfTransactions [
	^ self belongingToAll: aCollection selector: self defaultOwnerSelector elements: aCollectionOfTransactions
]

{ #category : #'instance-creation' }
HistoryGroup class >> belongingToAll: aCollection selector: aSymbol elements: elements [
	^ self new
		owners: aCollection;
		magnitudeSelector: aSymbol;
		setElements: elements;
		yourself
]

{ #category : #configuring }
HistoryGroup class >> defaultOwnerSelector [
	"Answer the default owner selector of receiver instances."

	DefaultOwnerSelector ifNil: [ DefaultOwnerSelector := #owner ].
	^ DefaultOwnerSelector
]

{ #category : #configuring }
HistoryGroup class >> defaultOwnerSelector: aSymbol [
	"Set aSymbol as the default owner selector of receiver instances."
	
	DefaultOwnerSelector := aSymbol
]

{ #category : #'instance-creation' }
HistoryGroup class >> magnitude: aSymbol owner: ownerSymbol [

	^ self new
		  magnitudeSelector: aSymbol;
		  ownerSelector: ownerSymbol;
		  yourself
]

{ #category : #'instance-creation' }
HistoryGroup class >> withAll: aCollection [
	^self new
		setHistories: aCollection;
		yourself
]

{ #category : #querying }
HistoryGroup >> allAt: aDate [
	"Answer a collection of elements in the receiver for all the owners
	at aDate. If no element exist for a particular object in aDate, it will
	be ignored silently."

	| result |
	result := OrderedCollection new.	
	self registry values do: [:each | 
		(each at: aDate ifAbsent: []) ifNotNil:[:obj | result add: obj ]
	].
	^result
	
]

{ #category : #querying }
HistoryGroup >> allAt: aDate select: aBlockCondition [
	"Answer a collection of elements in the receiver for all the owners
	at aDate. If no element exist for a particular object in aDate, it will
	be ignored silently."

	| result |
	result := OrderedCollection new.	
	self registry do: [:each | 
		(each at: aDate ifAbsent: []) ifNotNil: [:obj | (aBlockCondition value: obj) ifTrue: [ result add: obj ] ]
	].
	^result
	
]

{ #category : #querying }
HistoryGroup >> allElements [
	"Private - Anwer a collection containing all the elements in the histories of receiver owners."
	
	^self histories
		inject: OrderedCollection new
		into: [:ans :history | ans addAll: history elements; yourself ]
]

{ #category : #querying }
HistoryGroup >> allFrom: aDate to: anotherDate [
	"Answer a collection of elements in the receiver for all the owners from aDate to anotherDate."

	^self registry values
		inject: Set new
		into: [:result :each | result addAll: (each from: aDate to: anotherDate); yourself]
]

{ #category : #querying }
HistoryGroup >> at: aDate of: anObject [
	"Answer the element of the history belonging to anObject which 
	is located at aDate in time, raise an error if no element is found."
	
	^self at: aDate of: anObject ifAbsent: []
]

{ #category : #querying }
HistoryGroup >> at: aDate of: anObject ifAbsent: aBlock [
	"Answer the element of the history belonging to anObject which 
	is located at aDate in time, evaluates aBlock if no element is found."

	^ (self historyOf: anObject) at: aDate ifAbsent: aBlock
]

{ #category : #initializing }
HistoryGroup >> basicInitializeRegistry [
	"Private - Initializes the registry of receiver."

	self registry: Dictionary new
]

{ #category : #accessing }
HistoryGroup >> histories [
	"Private - Answer the collecion of histories of receiver."

	^self registry values
	
]

{ #category : #accessing }
HistoryGroup >> historyOf: anObject [
	"Answer the history belonging to anObject."
	
	^self registry at: anObject ifAbsentPut: [self newHistoryFor: anObject]
]

{ #category : #initializing }
HistoryGroup >> initializeHistoriesUsing: aCollection [
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
]

{ #category : #initializing }
HistoryGroup >> initializeRegistry [
	"Private - Initializes the registry of receiver."

	self basicInitializeRegistry.
]

{ #category : #configuring }
HistoryGroup >> lookupPolicy: aSymbol [
	super lookupPolicy: aSymbol.
	self histories do: [ :each | each lookupPolicy: aSymbol ]
]

{ #category : #operations }
HistoryGroup >> newHistoryFor: anOwner [
	"Private - Answer a new history on the receiver for anOwner."

	^ (History of: anOwner selector: self magnitudeSelector)
		lookupPolicy: self lookupPolicy;
		yourself
]

{ #category : #configuring }
HistoryGroup >> ownerSelector [
	"Return the value of ownerSelector."

	^ownerSelector ifNil: [self class defaultOwnerSelector]
]

{ #category : #configuring }
HistoryGroup >> ownerSelector: aSymbol [
	"Save the value of ownerSelector."

	ownerSelector := aSymbol
]

{ #category : #accessing }
HistoryGroup >> owners [
	"Return the value of owners."

	^owners
]

{ #category : #accessing }
HistoryGroup >> owners: aCollection [
	"Save the value of owners."

	owners := aCollection
]

{ #category : #operations }
HistoryGroup >> registerNewHistoryFor: anOwner [ 
	"Private - Register and answer a new history on the receiver for anOwner."

	^self registry at: anOwner put: (self newHistoryFor: anOwner)
]

{ #category : #accessing }
HistoryGroup >> registry [
	"Return the value of registry."

	registry isNil ifTrue: [self initializeRegistry].
	^registry
]

{ #category : #accessing }
HistoryGroup >> registry: aDictionary [
	"Save the value of registry."

	registry := aDictionary
]

{ #category : #initializing }
HistoryGroup >> setElements: aCollection [
	self basicInitializeRegistry.
	self initializeHistoriesUsing: aCollection
]

{ #category : #initializing }
HistoryGroup >> setHistories: aCollection [

	self owners: (aCollection collect: [:each | each perform: self ownerSelector]).
	aCollection do: [ :each | self registry at: each owner put: each ]
	
]
