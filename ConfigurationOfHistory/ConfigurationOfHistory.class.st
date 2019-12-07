Class {
	#name : #ConfigurationOfHistory,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfHistory'
}

{ #category : #'development support' }
ConfigurationOfHistory class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfHistory class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfHistory class >> catalogDescription [
	^ 'This package provides the utility class History that can help when dealing with dated objects. It is, objects that have a magnitude like Date, Time, DateAndTime, etc. and can be sorted historically according to this or any other magnitude.

So when you have to query for some element at certain date, the History class will perform the lookup. But the added value is that the lookup can be for a matching date or if you need to obtain an element that applies for a certain date, it will retrieve the closest to the queried date.

E.g. If the History contain aPermit dated 2015-03-01 14:00, and no other aftewards, then aHistory at: ''2015-05-15 00:00'' asDateAndTime will return the one from March.

For most purposes the History class can act as a Collection, supporting enumeration, adding, removing elements, filtering, etc. (it is #do:, #detect:ifNone:, etc.)

See the tests for more examples of how to use it.'
]

{ #category : #catalog }
ConfigurationOfHistory class >> catalogKeywords [
	^ #(#history #collections #utility #lookup)
]

{ #category : #private }
ConfigurationOfHistory class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfHistory class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfHistory class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfHistory class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfHistory class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfHistory class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfHistory class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfHistory class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfHistory >> baseline1: spec [
	<version: '1-baseline'>
	spec
		for: #common
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/emaringolo/History/main/'.
			spec
				package: #'History-Core';
				package: #'History-Tests' with: [ spec requires: #('History-Core') ].
			spec
				group: 'default' with: #('History-Tests');
				group: 'core' with: #('History-Core') ]
]

{ #category : #accessing }
ConfigurationOfHistory >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfHistory >> development: spec [
	<symbolicVersion: #development>
	spec for: #common version: '1-baseline'
]

{ #category : #accessing }
ConfigurationOfHistory >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfHistory >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.0'.

]

{ #category : #versions }
ConfigurationOfHistory >> version10: spec [
	<version: '1.0' imports: #('1-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #stable.
			spec description: 'version 1.0'.
			spec author: 'EstebanMaringolo'.
			spec timestamp: '12/17/2015 00:34'.
			spec
				package: #'History-Core' with: 'History-Core-EstebanMaringolo.1';
				package: #'History-Tests' with: 'History-Tests-EstebanMaringolo.1' ]
]
