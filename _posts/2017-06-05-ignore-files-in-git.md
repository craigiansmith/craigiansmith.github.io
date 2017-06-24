# Git ignore Vim's .swp files 

Whenever I start a new project and start editing files in Vim, I need to double check that vim's temporary files won't be included in my commits. Up till now, I had just been using `echo "*.swp" >> .gitignore` in the project root. But there's an easier way, and this can apply for whatever temporary files your editor or IDE creates.

First check if $XDG_CONFIG_HOME is set with `echo $XDG_CONFIG_HOME`. If it's blank then check if you have a `~/.config/git` directory, if not create one with `mkdir ~/.config/git`. Then create a new file at `~/.config/git/ignore`. In this file place the patterns that you want git to ignore on your machine. The great thing about it is that you won't need to clutter up the project's gitignore file with patterns specific to your workflow.

If $XDG_CONFIG_HOME is set create the ignore file at `$XDG_CONFIG_HOME/git/ignore`.

### References

[Git manual](https://git-scm.com/docs/gitignore)
