# How to automate deployment with git

http://stackoverflow.com/questions/7927750/specify-an-ssh-key-for-git-push-for-a-given-domain
https://www.digitalocean.com/community/tutorials/how-to-set-up-automatic-deployment-with-git-with-a-vps

## Set up ssh

Set up an ssh identity for the server that you will push to.

Create ~/.ssh/config so that it looks like this:
When you see <name> replace the whole thing with the correct name.

Host <name of identity>
    HostName <domain name to connect to, or ip I guess>
    User <name of user on remote system>
    IdentityFile /absolute/path/to/key/file
    IdentitiesOnly Yes

Now test it with ssh <name of identity> it should connect you straight in without specifying the remote host or the identity file, since these are specified in the ~/.ssh/config.

Be sure that the Identity File has permissions of 400, otherwise ssh will reject it as insecure.

## Create a remote git repo

On the remote server, say you want to set up a staging site. Make the repo directory somewhere your ssh user can access it and write to it, say /home/$USER/repos/staging.git

cd 
mkdir -p repos/staging.git
cd repos/staging.git
git init --bare

Here you might like to check that this step worked. So let's add a git remote to the staging repo.
cd into the local repo that you want to push. Then do:

git remote add staging ssh://<name of identity>:/abs/path/to/repo/on/remote/server
git push staging master

The above commands will use the ssh identity we configured in step one, and push the local code to the bare git repo we initialised on the remote server.

## Automate the workflow

Set up an automated workflow to carry out after you've pushed code to the remote server. Edit repos/staging.git/hooks/post-receive (create the file if it is not present). And add the following:

#! /bin/bash

git --work-tree=/path/to/web/host --git-dir=/path/to/repo checkout -f

Of course, it is essential to make the post-receive file executable. So run, 
chmod +x post-receive

http://www.cyberciti.biz/faq/howto-linux-add-user-to-group/
For this to work the file permissions in the web host will need to be set correctly. There's many ways to do this but for now, the following commands will do the job:

usermod -a -G www-data <your user name>

This will add you to the www-data group, which serves the web pages. 

sudo chown -R www-data:www-data /var/www/staging

This will change the owned and group of the web host directory.

sudo chmod -R 775 /var/www/staging

This will make the web host directory writable by the group that it belongs to, www-data, which your user also belongs to.

To test this, make a minor change to your repo (add an empty file) and commit it. The run git push staging master again.

After the repo is successfully copied into the web root. Make the storage directory writable by others. If it isn't laravel will only produce a white screen, i.e. it won't send anything in the http response.

sudo chmod -R o+w storage
