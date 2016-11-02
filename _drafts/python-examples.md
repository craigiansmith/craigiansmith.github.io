## How Inheritance Effects Exceptions

The following example illustrates how class inheritance effects the except 
clause. It's straight from the (tutorial)[https://docs.python.org/2/tutorial/classes.html#exceptions-are-classes-too].
The tutorial description is correct, but due to the logic involved I found it
wasn't clear until I ran the example code myself. 

Exceptions are classes which inherit from a Python class that ships with your
Python installation, but they can actually be any class at all. In the except
clause a class, or several classes are nominated. For instance `except ClassName`.
The exceptions that `except ClassName` will catch are `ClassName` and any classes which 
`ClassName` inherits from. `except ClassName` will not catch any classes that
inherit from `ClassName`.

Example code:

    >>> class B: pass
    ... 
    >>> class C(B): pass
    ... 
    >>> class D(C): pass
    ... 
    >>> for c in [B, C, D]:
    ...     try:
    ...             raise c()
    ...     except D:
    ...             print "D"
    ...     except C:
    ...             print "C"
    ...     except B:
    ...             print "B"
    ... 
    B
    C
    D

    >>> for c in [B, C, D]:
    ...     try: 
    ...             raise c()
    ...     except B:
    ...             print "B caught {}".format(c.__name__)
    ... 
    B caught B
    B caught C
    B caught D

## Multiple Inheritance Method Resolution Ordering

This (answer on SO)[http://stackoverflow.com/questions/3277367/how-does-pythons-super-work-with-multiple-inheritance#answer-30187306] 
gives a good step through of the Method Resolution Ordering of classes with
multiple inheritance. The ordering can be inspected using `ClassName.__mro__`.
One interesting thing to note is that with an inheritance heirarchy in which
a particular method always makes a call to super, the calls will be made depth-
first, and return in the _reverse_ of the MRO. Similar to a recursive function.
It is briefly discussed in the (Python tutorial)[https://docs.python.org/2/tutorial/classes.html#multiple-inheritance],
and the BDFL wrote up an (informative post)[http://python-history.blogspot.com.au/2010/06/method-resolution-order.html] 
about how the MRO was introduced.

Example code:
    
    >>> class First(object):
    ...     def __init__(self):
    ...             super(First, self).__init__()
    ...             print "first"
    >>> class Second(object):
    ...     def __init__(self):
    ...             super(Second, self).__init__()
    ...             print "second"
    ... 
    >>> class Third(First, Second):
    ...     def __init__(self):
    ...             super(Third, self).__init__()
    ...             print "third\nThat's it."
    ... 
    >>> third = Third()
    second
    first
    third
    That's it.
    >>> Third.__mro__
    (<class '__main__.Third'>, <class '__main__.First'>, <class '__main__.Second'>, <type 'object'>)

