lookup
lookupApplicableAt: aDate
	"Private - Lookups the element of receiver which is valid at aDate in the receiver cache."

	^ self elements detect: [ :one | (one perform: self magnitudeSelector) <= aDate ] ifNone: [ nil ]