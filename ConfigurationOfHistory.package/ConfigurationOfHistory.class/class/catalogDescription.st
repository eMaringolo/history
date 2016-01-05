catalog
catalogDescription
	^ 'This package provides the utility class History that can help when dealing with dated objects. It is, objects that have a magnitude like Date, Time, DateAndTime, etc. and can be sorted historically according to this or any other magnitude.

So when you have to query for some element at certain date, the History class will perform the lookup. But the added value is that the lookup can be for a matching date or if you need to obtain an element that applies for a certain date, it will retrieve the closest to the queried date.

E.g. If the History contain aPermit dated 2015-03-01 14:00, and no other aftewards, then aHistory at: ''2015-05-15 00:00'' asDateAndTime will return the one from March.

For most purposes the History class can act as a Collection, supporting enumeration, adding, removing elements, filtering, etc. (it is #do:, #detect:ifNone:, etc.)

See the tests for more examples of how to use it.'