[python tutorial](https://docs.python.org/2/tutorial/index.html)
[learn python the hard way](https://learnpythonthehardway.org/book/ex1.html)

python
object oriented
dynamic typing
elegant syntax
interpreted

use `python -i <script_name.py>` to enter interactive mode in the interpreter
after running the script.

Can use `python -m <module_name>` to run a module as a script.

Python strings are immutable. Can't assign to them once created. Can concatenate
strings together using `+`. Can also access a char by `string[index]` or a 
substring by `string[start:(end+1)]`. Can create a unicode string with `u"string"`.

    if expression:
        code
    elif expression:
        code
    else:
        code

    for item in list:
        do stuff with item    
 
Or if you want to loop over a copy of the list and edit the original list then
use the slice syntax.

    for item in list[:]:
        do stuff to list with item

Pythonic Idioms
[ref](https://docs.python.org/2/howto/doanddont.html)

It's Easier to Ask Forgiveness than Permission. Try and do something and catch
exceptions, instead of checking it should work and then doing it, because in
between the check and doing the thing something might change leaving you with
a problem. The following idiom can be used:
    
    def do_something(file):
        with open(file) as fp:
            return fp.readline()

Use 
    import os
    os.path.join(dir, file)

And `reduce` will apply a binary operation to reduce input to a single value.
For instance, the factorial of n.

    import operator
    n = 4
    reduce(operator.mul, 1, n+1)

 
For continuing code over two lines, wrap the expression in parentheses.

Downloaded source code, found recommended [book list](https://wiki.python.org/moin/PythonBooks) in readme
Idioms [page](http://python.net/~goodger/projects/pycon/2007/idiomatic/handout.html)

Functions return None unless a return statement with an expression is used
If a default argument value is set by a variable, the value of the variable
in the place where the method is defined is the value of the argument. That
means that if the variable changes after the method definition, it won't affect
the value passed to the default argument.

Functions can be called with keyword arguments. This is done using the format
    function_call(argument_name='value')
Keyword arguments must come after positional arguments, but they can otherwise
be placed in any order.

Data structures

List
More stuff in Collections

Modules

The boiler plate at the bottom of a Python script can be really useful.

    if __name__ == "__main__":
        do stuff

The stuff you do here is done whenever the module or script is executed from the
command line. In that case the `__name__` variable will be set to `__main__` and
not the module name. You can do things such as execute tests for the module
when the module is executed from the command line, or you can make a command line
user interface, accepting arguments like so:

    if __name__ == "__main__":
        import sys
        fib(int(sys.argv[1]))


[ref](https://docs.python.org/2/tutorial/modules.html)

Trying things out

    try:
        a single command that might fail
    except SomeException as e:
        print e

You can even raise and exception and pass arguments to it:
    
    raise MyException (with, args)

Then you can catch the exception and print it out using format:

    Except MyException as e:
        print "Here's the first argument: {}\nAnd the second: {}".format(*e.args)

Notice the `*` operator on `e.args`. This will unpack the tuple so that the
format method can accept the individual arguments.
