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

## Adding a method to an existing class

It is very simple to add or replace methods on existing classes. Simply define
the method and then assign the method to an attribute on the class object. It
is possible to pass self to the new method since it is being bound to the class
object.

You can also add methods to instance objects in the same way, however `self` 
won't be passed to that method and the interpreter will complain if the method
expects it.

## Iterating over a dict

To extract keys and values from a dict in Python 2.7 you can use:

    for key, value in my_dict.iteritems():
        print "My {} is {}".format(key, value)

In Python 3 that becomes `my_dict.items()`.

## Find all methods on an object 

Use `[method for method in dir(object) if callable(getattr(object, method))]`.

## Doctest
Can embed a test in a docstring.

    """
    >>> print method_to_test(arg)
    expected_value
    """

    import doctest
    doctest.testmod(module_with_doctests_to_run)


## Timer

Can test out the performance of commands using the Timer module. 
    
    from timeit import Timer
    results_deque = []
    >>> for i in range(50):
    ...     results_deque.append(Timer('d.append(5); d.append(6); d.append(7)',\
    'from collections import deque; d = deque([1,2,3])').timeit())
    avg_deque = sum(results_deque) / len(results_deque)


## Getting the name of a method or class object

You can get the name by using `ClassName.__name__`. Similarly, if you want the
name of a method of a class instance you can do `class_instance.my_method.__name__`.
However, you can't use `.__name__` on an instance object.

New style classes (created with the `class ClassName(object)` statement), pass
`object` as a parent. This enables a couple of features missing from classic
classes. First, the new style class is actually a type. Any instances created
from it will reveal their type as being the class object that they were created
from. Secondly, new style classes can call 
`super(ClassName, self).method_on_ancestor()`.
