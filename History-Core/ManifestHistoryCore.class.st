"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestHistoryCore,
	#superclass : #PackageManifest,
	#category : #'History-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestHistoryCore class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'History-Core')) #'2022-11-02T17:42:26.400559-03:00') )
]
