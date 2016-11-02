# Problems I have encountered in Python programming

When creating a class definition and it's `__init__` method, I want to know the
best way to order the arguments. For instance with an address class. If I want
separate arguments for unit number and street number and street name, let alone
suburb, postcode, state and country, what is the principle to follow in ordering
them? Some of them can have default arguments, known as keyword arguments in
Python, these, I believe, need to be placed after positional arguments (those 
without default values).

An address has several fields, it could be implemented as a dictionary or as a
class, which is to be preferred?

The benefit of implemeting address as a class is that it can be created by 
instantiating the class with the argument values given between parentheses. In
contrast creating a dictionary would involve naming the keys as well as the 
values. This creates a potential for programmer error if the keys are not named
properly. Also, a class could have presentation logic embedded in it, and other
logic to confirm the address or so on.

A solution appears on [stackexchange](http://softwareengineering.stackexchange.com/questions/126765/c-design-many-properties-complex-constructor-and-equality)
and suggests to use a builder pattern where the address is created as a class
and the constructor can have defaults as necessary. To create the address object
the builder is called with as many chained arguments as necessary.
