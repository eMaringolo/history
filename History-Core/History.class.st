"
I represent the concrete  implementation of a history of elements belonging to an owner.

I implement most of the typical operations expected for a collection with the added methods for the lookup of elements that can be accessed by means of some sort of date/time magnitude.

My elements are stored in a sorted collection with the newest element first and the oldest later, because most of the times the history is queried for magnitudes close to the present.

The owner variable is not necessary unless the receiver is used as part of a group.
"
Class {
	#name : #History,
	#superclass : #AbstractHistory,
	#instVars : [
		'owner',
		'elements'
	],
	#category : #'History-Core'
}

{ #category : #'instance-creation' }
History class >> of: anObject selector: aSymbol [
	^ self of: anObject withAll: #() selector: aSymbol
]

{ #category : #'instance-creation' }
History class >> of: anObject withAll: elements [
	^ self of: anObject withAll: elements selector: self defaultMagnitudeSelector
]

{ #category : #'instance-creation' }
History class >> of: anObject withAll: elements selector: aSymbol [
	^ self new
		owner: anObject;
		magnitudeSelector: aSymbol;
		addAll: elements;
		yourself
]

{ #category : #'instance-creation' }
History class >> withAll: elements [
	^ self of: nil withAll: elements selector: self defaultMagnitudeSelector
]

{ #category : #adding }
History >> add: anObject [
	"Add anObject into the elements of receiver."

	self elements add: anObject

]

{ #category : #adding }
History >> addAll: aCollection [
	"Private - Adds aCollection of elements into the elements of receiver."

	self elements addAll: aCollection

]

{ #category : #accessing }
History >> at: aDate [
	"Answer the element of receiver which is located at aDate in time,
	raise an error if no element is found."

	^self at: aDate ifAbsent: [self errorNotFound]
]

{ #category : #accessing }
History >> at: aDate ifAbsent: aBlock [
	^ (self lookupElementAt: aDate) ifNil: [ aBlock value ]
]

{ #category : #accessing }
History >> basicElements [
	^elements
]

{ #category : #enumerating }
History >> detect: aBlock ifNone: exceptionBlock [
	"Answer the first element of the receiver for which the evaluation 
	 of the one argument block, aBlock returns true."

	^ self elements detect: aBlock ifNone: exceptionBlock
]

{ #category : #iterating }
History >> do: aBlockClosure [ 
	self elements do: aBlockClosure 
]

{ #category : #accessing }
History >> elements [
	"Return the value of elements."

	elements isNil ifTrue: [self initializeElements].
	(elements isKindOf: SortedCollection) ifFalse: [ self ensureSortedElements ].
	^elements
]

{ #category : #accessing }
History >> ensureSortedElements [

	elements := elements asSortedCollection: self
]

{ #category : #accessing }
History >> from: aDate to: anotherDate [
	"Answer the elements of receiver which is located between aDate and anotherDate in time."

	^ self lookupElementsFrom: aDate to: anotherDate
]

{ #category : #initializing }
History >> initializeElements [
	"Private - Initializes the elements of receiver."

	self setElements: (SortedCollection sortBlock: self)
]

{ #category : #accessing }
History >> latest [
	"Answer the latest element of receiver that is loaded."
	
	^self elements notEmpty ifTrue: [self elements first]
	
]

{ #category : #lookup }
History >> lookupApplicableAt: aDate [
	"Private - Lookups the element of receiver which is valid at aDate in the receiver cache."

	^ self elements detect: [ :one | (one perform: self magnitudeSelector) <= aDate ] ifNone: [ nil ]
]

{ #category : #lookup }
History >> lookupElementAt: aDate [
	"Private - Lookups the element of receiver in the receiver cache using the lookup strategy."

	^ self lookupPolicy == self class matchLookup
		ifTrue: [ self lookupMatchAt: aDate ]
		ifFalse: [ self lookupApplicableAt: aDate ]
]

{ #category : #lookup }
History >> lookupElementsFrom: aDate to: anotherDate [
	"Private - Lookups the elements in the receiver cache from aDate to abotherDate using the lookup strategy."
	
	| current result |
	self lookupPolicy == self class currentPolicy ifTrue: [current := self lookupElementAt: aDate].
	result := self elements select: [:each | (each perform: self dateSelector) between: aDate and: anotherDate].
	current ifNotNil: [:value | result add: value ].
	^result
]

{ #category : #lookup }
History >> lookupMatchAt: aDate [
	"Private - Lookups the element of receiver which date is equal to aDate."

	^ self elements detect: [ :one | (one perform: self magnitudeSelector) = aDate ] ifNone: [ nil ]
]

{ #category : #accessing }
History >> owner [
	"Return the value of owner."

	^owner
]

{ #category : #accessing }
History >> owner: anObject [
	"Save the value of owner."

	owner := anObject
]

{ #category : #removing }
History >> remove: anObject [
	"Removes anObject from the elements of receiver,
	ignores any error if anObject is not in the receiver elements."

	self elements remove: anObject ifAbsent: []
]

{ #category : #removing }
History >> removeAll [

	self elements removeAll
]

{ #category : #enumerating }
History >> select: aBlock [
	"Answer the elements of the receiver for which the evaluation 
	 of the one argument block, aBlock returns true."
	
	^self elements asOrderedCollection select: aBlock
]

{ #category : #initializing }
History >> setElements: aCollection [

	elements := aCollection
]

{ #category : #accessing }
History >> size [
	"Anwer the size of receiver. The size of receiver is the size of the elements loaded."
	
	^self elements size
]

{ #category : #sorting }
History >> value: a value: b [
	"Private - Compares object a and object b, answer true if a is greater than b.
	Implemented to use receiver as sort block for it's elements sorted collection."

	| dateS |
	^ (b perform: (dateS := self magnitudeSelector)) < (a perform: dateS)
]

{ #category : #iterating }
History >> writeStream [
	
	^WriteStream on: self elements
]
