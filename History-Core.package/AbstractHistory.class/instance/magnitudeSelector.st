configuring
magnitudeSelector
	"Return the value of dateSelector."

	^magnitudeSelector ifNil: [ magnitudeSelector := self defaultMagnitudeSelector]