"
I represent the abstract implementation of container of historical elements 

I perform the lookup using the magnitudeSelector symbol. E.g. #date, #dateAndTime, #timestamp, etc.
The magnitude word might cause confusion, but it is usually a Date, a Time, a DateAndTime or any other object representing a point in time that can be compared for sorting purposes.

I can lookup into my elements using a lookup strategy that can be #match to retrieve the elements at the magnitude that matches or #applicability to retrieve the element with a magnitude less than equal the queried magnitude. In the future the lookup strategy can be reified as an first class object.
"
Class {
	#name : #AbstractHistory,
	#superclass : #Object,
	#instVars : [
		'lookupPolicy',
		'magnitudeSelector'
	],
	#classVars : [
		'DefaultMagnitudeSelector'
	],
	#category : 'History-Core'
}

{ #category : #'as yet uncategorized' }
AbstractHistory class >> applicabilityLookup [
	"Answer the policy to be used in receiver instances to query it's history using a validity/in force criteria."

	^ #applicable
]

{ #category : #'as yet uncategorized' }
AbstractHistory class >> defaultMagnitudeSelector [
	^ DefaultMagnitudeSelector
]

{ #category : #'as yet uncategorized' }
AbstractHistory class >> defaultMagnitudeSelector: aSymbol [
	DefaultMagnitudeSelector := aSymbol
]

{ #category : #'as yet uncategorized' }
AbstractHistory class >> initialize [
	"Private - Initializes receiver."

	super initialize.
	DefaultMagnitudeSelector := #timestamp
]

{ #category : #'as yet uncategorized' }
AbstractHistory class >> matchLookup [
	"Answer the policy to be used in receiver instances for exact lookup of element."
	
	^#exact
]

{ #category : #'as yet uncategorized' }
AbstractHistory class >> new [
	"Answer a new initialized instance of receiver."

	^super new initialize
]

{ #category : #configuring }
AbstractHistory >> defaultMagnitudeSelector [
	"Private - Answer the default selector used to obtain the date object of receiver elements."

	^self class defaultMagnitudeSelector
]

{ #category : #exceptions }
AbstractHistory >> errorNotFound [
	NotFound signal: 'Element not found in the receiver'
]

{ #category : #initializing }
AbstractHistory >> initialize [
	super initialize.
	lookupPolicy := self class applicabilityLookup
]

{ #category : #configuring }
AbstractHistory >> lookupPolicy [
	"Answer the lookup strategy of receiver."

	^lookupPolicy
]

{ #category : #configuring }
AbstractHistory >> lookupPolicy: anObject [
	lookupPolicy := anObject
]

{ #category : #configuring }
AbstractHistory >> magnitudeSelector [
	"Return the value of dateSelector."

	^magnitudeSelector ifNil: [ magnitudeSelector := self defaultMagnitudeSelector]
]

{ #category : #configuring }
AbstractHistory >> magnitudeSelector: aSymbol [
	"Save the value of dateSelector."

	magnitudeSelector := aSymbol
]

{ #category : #configuring }
AbstractHistory >> useApplicabilityLookup [
	"Makes the receiver a history with an current policy."
	
	self lookupPolicy: self class applicabilityLookup
]

{ #category : #configuring }
AbstractHistory >> useMatchLookup [
	"Makes the receiver a history with an exact policy."
	
	self lookupPolicy: self class matchLookup
]
