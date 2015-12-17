sorting
value: a value: b
	"Private - Compares object a and object b, answer true if a is greater than b.
	Implemented to use receiver as sort block for it's elements sorted collection."

	| dateS |
	^ (b perform: (dateS := self magnitudeSelector)) < (a perform: dateS)