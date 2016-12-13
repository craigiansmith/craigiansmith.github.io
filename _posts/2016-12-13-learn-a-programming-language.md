---
layout: default
title: Learn Bash
---
There's a lot of media about learning programming languages. This little contribution is simply my best effort at attempting to learn a programming language in 3 days, since I've been told that it's possible. I'm so confident that it can be done, that I'll count today, even though it will only be a short day. 

There's 6 things I want to know about a programming language in order to feel like I have learnt it:

1. Syntax. Without this I won't even get to 'Hello, world'. 
2. Control structures. What are the basic methods for controlling program flow?
3. Available functions. Whether built-ins or externally available. Perhaps I won't learn every single function that I could possibly use, but I want to get a grasp of the most commonly used funtions for the language.
4. How can I extend the language? What type of language is it? Procedural? Object oriented? Class based or prototype based? 
5. Best practices. 
6. Testing.

And of course, to begin with:
0. how do I get set up for development. 

## Let's start with the shell

### Get set up

Getting set up to develop shell scripts is straightforward on linux and Mac OS. You can do it on Windows with cygwin, or by making your machine a dual boot. I work on Kubuntu, so using Konsole is simple. I like to configure it a bit, remove the menu, hide the KDE task bar, select colours and font size, etc. I even installed zsh and oh-my-zsh (mainly for the pretty and useful prompts). I also need a text editor. I've chosen vim, and there are a great set of videos on [Laracasts](www.laracasts.com) about how to master vim step by step.

### Syntax

To learn a new language a good guide is important. I picked up Classic Shell Scripting by Arnold Robbins to read through so a lot of what follows is what I have learnt from his book. If you need to go deeper that's a great place to start.
A \*nix shell script has a shebang to as the first line to tell the program loader to use the shell interpreter.

    #! /bin/sh -

The `-` at the end is a security feature to tell the interpreter there are no more options to be passed to the shell.[^2]
By typing in `ls -l /bin/sh` on a Ubuntu system (>6.10) you can see that the `/bin/sh` interpreter directive refers to a symlink which points to `/bin/dash` which is the Debian Almquist Shell. The reason for this is that dash is more efficient than the standard Ubuntu login shell, bash.[^1] The upshot of this, is that if you call `/bin/sh` you need to make sure your script is [POSIX](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap01.html) compliant.

To get to the first milestone in learning we need to add only one line:

    echo 'Hello, Creation!'

That was easy enough. After saving the file. There is one last thing to do before we can run the script itself, which is to make it executable. 

    chmod u+x hello.sh 

Now I can run the script with `./hello.sh`

#### Variables

To assign variables in a shell script like so: `variable=value`. This can be done multiple times on one line. Make sure there are no spaces around the equals sign, and if your value is a string with spaces in it, surround it with quotation marks.

    var2="A string with spaces"

To then refer to the value use a `$` like `$var2` to access the string we stored earlier.

To provide a default value for a variable use the `${variable:- default_value}` construct.

    empty_var=
    echo ${empty_var:- "Important safeguard"}

Or you can use `=` instead of `-` to set the `$empty_var`.

    echo ${empty_var:= "Now my name isn't accurate."}

##### Special Variables

`$$` contains the process ID of the current script.
`$?` contains the exit status of the previous program.
`$0` is the name of the current program.
`$-` is the options passed to the shell on invocation (not the script when it is called).
`$@` contains all the command line arguments as separate strings. To access them, wrap it in double quotes.
`$\*` contains all the command line arguments as a single string.
`$!` contains the process ID of the previous command.

##### Variable operators

`${#variable}` will return the length of the string the variable contains.
`${variable#pattern}` will match the beginning of the string with the pattern and delete the shortest match and return the rest.
`${variable##pattern}` will match the beginning of the string with the pattern and delete the longest match and return the rest.
`${variable%pattern}` will match the end of the string with the pattern and delete the shortest match and return the rest.
`${variable%%pattern}` will match the end of the string with the pattern and delete the longest match and return the rest.


##### Command separation

Several commands can be entered on the same line. Simply separate them with `;`. If you use `&` instead, the previous command will run in the background while the following command will be run immediately without waiting for the first command to finish.

Try it out. Let's revise our script a little.

    #! /bin/sh
    name=Craig
    printf "Hello, %s" $name; echo "Yay!"

Printf takes a string as it's first argument. In the string you can place substitutionary characters like `%s` here. For each of these substiutionary characters you need to provide another argument and printf will output the revised string. In this example `$name` is the argument. 

If you provide a variable as the first argument to printf, make sure it is wrapped in quotes.

    message="Using a %s to delimit the command\n"
    printf "$message" ";"
    printf "Hello, Neighbour"; echo "Yay!"

Then we see a semi-colon to end the command, and an echo command after it. Making sure the script is executable, run it and see the output. Now swap out the `;` for a `&` and run it again. The line order will be reversed since the first command was started in the background and control was passed directly to the second command to output it's message before returning to the first command once it had completed it's work.

##### Get user input

Use `read` to get user input like so:

    read input < /dev/tty

##### Positional parameters

Refer to arguments passed in on the command line with `$1`, `$2`, `$n`, etc. If there are more than 10 arguments you need to wrap multiple digit numbers in curly braces like `${12}`.

##### See what commands are being run

To debug commands pass the `-x` to the interpreter, or use `set -x` in your script to turn tracing on and `set +x` to turn tracing off.

##### Arithmetic expressions

To do basic arithmetic, wrap the expression in `$((...))`.

### Control Structures

#### If, elif, else, fi

An if statement looks like so:

    command="ls ./"
    expression="-d /home/$USER"
    if $command
    then
        echo "Command worked"
    # Test has two syntaxes 'test ...' and '[...]'
    # In each case, wrap variables in "" so that test will always
    # receive an argument, even if it is just an empty string.
    elif test "$expression" 
        echo "Expression is true"
    elif [ -e "$0" ]
        echo "This file exists"
    else
        echo "Everything else failed"
    fi

#### case, esac

A case statement like so:

    case $argument in
        $match1)
            echo "Match 1 found."
            ;;
        $match2 | $match3)
            echo "2nd or 3rd match found."
            ;;
        *)
            echo "Something unexpected found."
            ;;
    esac

#### for

A for loop looks like so:

    for file in ls 
    do
        echo "$file"
    done

#### while
    
    while condition
    do
        stuff
    done

### Shell Globbing, Wildcard Expansion

Wildcards:
    
?
: Matches any single character

*
: Matches any string of characters

[ set ]
: Matches any character in the set

[! set ]
: Matches any character not in the set

### Command Substitution

Use \``command`\` or `$(command)`

### eval

When storing a command sequence in a variable, it is often useful to 
execute it using `eval`.

    command="ls | sort"
    eval $command

The above approach will work where `$command` will not execute properly.


Redirection using >, < and piping using |

Quoting with '' to prevent substitution, or with "" to preserve whitespace.

Sourcing a file full of functions with `. filename` will make the functions 
available to the calling script. The source file doesn't need to be executable.
### References

[^1]: [Dash shell on ubuntu](https://wiki.ubuntu.com/DashAsBinSh)
[^2]: [Classic Shell Scripting](amazon.com)
[Bash Guide for Beginners](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/index.html)
[Gnu Bash guide](https://www.gnu.org/software/bash/manual/html_node/index.html#SEC_Contents)
