## `__repr__` method

To be able to print an object, the class needs to be defined with a `__repr__`
method. This method needs to return a string.

## String concatentation

In Python a string can be concatenated to an existing string variable using `+=`.
Further strings can be concatenated using `+`. Concatenation in this way does
not add spaces between the strings, whereas `print string1, string2` does. If
you do `print "string 1" "string 2"` however, spaces will not be added between
the strings. If you are concatenating a lot of strings it will be necessary to
use the `+=` notation on each new line. 

## Builder pattern

For a class that has many arguments in its constructor, consider creating a
builder class. The builder class can set default values in it's init function
but not accept any parameters. To populate the class methods are chained 
together which set each desired parameter. Finally a build method is called, 
which returns the desired class.

A solution appears on [stackexchange](http://softwareengineering.stackexchange.com/questions/126765/c-design-many-properties-complex-constructor-and-equality)
and suggests to use a builder pattern where the address is created as a class
and the constructor can have defaults as necessary. To create the address object
the builder is called with as many chained arguments as necessary.

## Multiple Inheritance

This (answer on SO)[http://stackoverflow.com/questions/3277367/how-does-pythons-super-work-with-multiple-inheritance#answer-30187306] 
gives a good step through of the Method Resolution Ordering of classes with
multiple inheritance. The ordering can be inspected using `ClassName.__mro__`.
One interesting thing to note is that with an inheritance heirarchy in which
a particular method always makes a call to super, the calls will be made depth-
first, and return in the _reverse_ of the MRO. Similar to a recursive function.
It is briefly discussed in the (Python tutorial)[https://docs.python.org/2/tutorial/classes.html#multiple-inheritance],
and the BDFL wrote up an (informative post)[http://python-history.blogspot.com.au/2010/06/method-resolution-order.html] 
about how the MRO was introduced.
