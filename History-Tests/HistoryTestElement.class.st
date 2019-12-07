"
I'm a class existing only for the purpose of unit testing.

I contain a magnitude (usually a date, time, or similar) and a tag, just for identifying me.
"
Class {
	#name : #HistoryTestElement,
	#superclass : #Object,
	#instVars : [
		'magnitude',
		'tag'
	],
	#category : 'History-Tests'
}

{ #category : #'instance creation' }
HistoryTestElement class >> at: magnitude [
	^ self new
		magnitude: magnitude;
		yourself
]

{ #category : #'instance creation' }
HistoryTestElement class >> at: magnitude tag: anObject [
	^ self new
		magnitude: magnitude;
		tag: anObject;
		yourself
]

{ #category : #accessing }
HistoryTestElement >> magnitude [
	^ magnitude
]

{ #category : #accessing }
HistoryTestElement >> magnitude: anObject [
	magnitude := anObject
]

{ #category : #accessing }
HistoryTestElement >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	magnitude printOn: aStream.
	aStream nextPut: $-.
	tag printOn: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
HistoryTestElement >> tag [
	^ tag
]

{ #category : #accessing }
HistoryTestElement >> tag: anObject [
	tag := anObject
]
