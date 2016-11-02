#Devising descriptive variable names

Variable names should be short (up to 15 characters). They should describe in
meaningful terms what the variable is *used for* or what it *refers to*. They 
should follow the coding style guide for the language.

From PEP8 Python Style Guide, user facing names should reflect *usage* not 
implementation.

No need to include a prefix in the variable name to group similar variables,
since they will be contained in objects with the object name as prefix.

Use a single trailing underscore to avoid conflicts with reserved words. Even
better to use a synonym to avoid conflict altogether.

Never use 'l' (for lima), 'O' (for oscar), or 'o' (for oscar) as single letter
variable names. Using capital 'L' is okay.

## How to train for this skill

Read good code to see examples.
Record examples.
Read the (style guide)[https://www.python.org/dev/peps/pep-0008/#naming-conventions]
When writing code (even in the interpreter) come up with 3 to 5 possible names
for each variable before settling on one. Write these alternative variable names
in a comment. As well as the reason for the one I choose.
With file based code, reread the code to see if I can understand what the
variable names mean.

### Common variable names

i, j, k
: index counter variables in loops

x
: element variable in sequences

key, value
: element variables from dictionaries

### Variable naming principles

verb_noun
: Describe what is done to something else, useful for flags such as 
`close_connection`, `send_error`

adjective_noun
: Describe the content of the variable, useful for storing content. For example
`raw_requestline`

noun_noun
: Not 100% sure of the grammar on this, but an example is `request_version`, 
which records the version number of the request. It is useful for storing
content.



#Reading online documentation and practicing examples in the interpreter
#Reading online documentation and writing short script files
#Writing explanatory comments
#Breaking a problem down into smaller parts
#Designing a solution to a problem
#Devising descriptive method names
#Writing a test before writing code
#Reading online documentation and practicing writing methods

Method names should tell you *what the method does*.

#Writing conventional docstrings
#Devising descriptive class names

Class names should tell you *what the class is*.
#Reading online documentation and practicing writing classes
#Devising descriptive module names
#Reading online documentation and practicing writing modules
#Reading online documentation and practicing writing code to catch exceptions
#Writing classes to define exceptions
#Writing methods that raise exceptions

#Writing code to implement a well-known algorithm
#Writing code to implement a well-known data-structure
