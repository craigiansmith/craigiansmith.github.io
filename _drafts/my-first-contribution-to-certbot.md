# My First Contribution to Certbot

Issue #3748
Generalize return types for plugin interfaces

For example, in interfaces.py we say that IInstaller.get_all_names() must return a list, yet both of our plugins return a set. We should both make sure our documentation doesn't specify unnecessary requirements as well as try and simplify our code if necessary so more general types such as any iterable works properly.

# Begin

Being my first contribution, I didn't know the codebase whatsoever. Also, my
Python skills were pretty minimal. I started with a preliminary Python refresh.
After about a week of deliberate practice based on working through the Python
tutorial and beginning to read throught the language reference and standard
library reference I was itching to get going.

The task at hand seems to be just updating the docstrings in `certbot/interfaces.py`.
That's simple enough. Yet I wanted to know what the return values will be used
for, so that I don't specify a return type that will break existing code.

This means that I have to learn enough about the code to find out where the 
return types are going to be used and track them through the code to see what
happens to them.

So I started looking at the codebase to see where these interfaces are used. It
was quickly obvious that the interfaces are for plugins. Certbot has two plugin
types: Installers and Authenticators, and one plugin can be both an Installer
and an Authenticator. The comment refers to two plugins, which I suppose are
`certbot-apache` and `certbot-nginx`. However, there are also four more plugins
that are internal to Certbot, being: `webroot`, `manual`, `standalone`, and 
`null`. The plugins have entry points defined in `setup.py` files, since Certbot
makes use of Python setuptools to package the software.

Certbot also uses Zope Components and Interfaces, and the plugin interfaces are
subclasses of `zope.interface.Interface`.

# Flow of control

The `setup.py` file in the project root specifies an entry point for 
`console_scripts`. This is a standard name for a program entry point. It specifies
`certbot.main:main` as the target. In the `certbot` folder in the project root
there is a `main.py` file. Yet looking at the boilerplate at the bottom of the
file, it throws an error if this file is called directly from the command line.
Of course, to run Certbot from the source, at the command line, we would use 
`certbot`. When I run `which certbot` it shows `./venv/bin/certbot` as the 
location. Inspecting that file I see that it uses `pkg_resources` (from 
setuptools) to `load_entry_point`, and that the entry point given is the
`console_scripts` entry point we noticed earlier. At least now we have found
the beginning. 

Let's look at `certbot.main:main`. The first line sets `sys.excepthook` to 
configure the exception reporting. The second line is where it starts to get 
interesting, as the `plugins` variable is set by 
`plugins_disco.PluginsRegistry.find_all()`. Doing a quick search on 
`plugins_disco` reveals that it is an alias for `certbot/plugins/disco.py`. This
method iterates through entry points for plugins. That indicates that the plugins
are also loaded using setuptools. It uses a constant, and when we look up the 
value of that constant it points to `certbot.plugins`. Not being an expert in
setuptools at this point, I decided to hunt around the codebase for `setup.py`
files to find the various entry points that have been defined. There are
entry points in the `certbot.plugins` group defined in setup files in
`certbot-apache` and `certbot-nginx` folders.


