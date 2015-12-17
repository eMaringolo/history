removing
remove: anObject
	"Removes anObject from the elements of receiver,
	ignores any error if anObject is not in the receiver elements."

	self elements remove: anObject ifAbsent: []