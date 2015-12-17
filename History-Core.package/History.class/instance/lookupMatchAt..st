lookup
lookupMatchAt: aDate
	"Private - Lookups the element of receiver which date is equal to aDate."

	^ self elements detect: [ :one | (one perform: self magnitudeSelector) = aDate ] ifNone: [ nil ]