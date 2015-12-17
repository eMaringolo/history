I represent the concrete  implementation of a history of elements belonging to an owner.

I implement most of the typical operations expected for a collection with the added methods for the lookup of elements that can be accessed by means of some sort of date/time magnitude.

My elements are stored in a sorted collection with the newest element first and the oldest later, because most of the times the history is queried for magnitudes close to the present.

The owner variable is not necessary unless the receiver is used as part of a group.