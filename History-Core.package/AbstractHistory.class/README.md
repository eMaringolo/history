I represent the abstract implementation of container of historical elements 

I perform the lookup using the magnitudeSelector symbol. E.g. #date, #dateAndTime, #timestamp, etc.
The magnitude word might cause confusion, but it is usually a Date, a Time, a DateAndTime or any other object representing a point in time that can be compared for sorting purposes.

I can lookup into my elements using a lookup strategy that can be #match to retrieve the elements at the magnitude that matches or #applicability to retrieve the element with a magnitude less than equal the queried magnitude. In the future the lookup strategy can be reified as an first class object.