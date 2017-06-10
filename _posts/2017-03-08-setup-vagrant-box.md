# How to set up a Vagrant box

Add note to consider looking for a set up LEMP box.
Consider using a provisioning script to setup a LEMP box.
Build your own LEMP box
Look at how to create a vagrant password logon for the box



I was homeless once or twice, and sleeping amidst boxes is the bomb. You don't 
want them formed into their box shape though, you need them layered above to keep
you warm, and beneath to keep you comfortable. In fact, if you're blessed to 
have a sleeping bag it's even better. But if there are mozzies about, each 
pin prick extraction of blood will pierce your soul and increase the agony of
destitution.

Making a Vagrant box is much easier than being a vagrant sleeping on boxes.

This how to guide is for setting up a Vagrant base box on a Ubuntu host. You
can do the same thing on other OS's but the commands will be different. If you
are on Ubuntu, you can simply follow along. This assumes that you have Vagrant 
installed, along with virtualisation software, such as VirtualBox.

First up, why bother? 

There are plenty of Vagrant boxes out there, you can simply search for one that
meets your use case and download it. However, in some cases you might find that
the available boxes have installed software that you don't want, or they don't
have quite all that you do want. In the latter case, you can apply some of these
same steps to create your own box based on another base box. Then you have the 
flexibility to be able to create exactly the set of tools for each project or
type of project and you can enjoy the separation of concerns by keeping your
host system relatively free of whimsical installs. Simply spin up a VM to try 
something out.

For this how to guide I will focus on the specific use case of setting up a dev
box for designing drupal sites. I want to be able to start the VM and visit the
site in my browser. In a later post we will cover the additional step of deploying
the code using Vagrant push.


Next, initialize the Vagrant environment. From within the site directory, at the
top level, run:

    vagrant init

This will create a Vagrantfile for you. The next step is a couple on minor 
configuration changes that will have a big effect. First, we specify the box
to base it on, in this case I am opting for a recent version of Ubuntu.

    config.vm.box = "ubuntu/xenial64"

There are several ways to see what is being served from your Vagrant VM. In this
case we will set up a private network accessible only from the host computer. 
To do this just uncomment the following line:
    
    config.vm.network "private_network", ip: "192.168.33.10"

After you have saved those changes, in the same directory as the Vagrantfile, run:

    vagrant up

Now let's get into the Vagrant box and install the dependencies required for drupal.

    vagrant ssh
    sudo apt-get install php7.0 php7.0-fpm php7.0-mcrypt nginx mysql-client mysql-server

You will probably need to recreate the vagrant user and give them sudo power, at 
least I did.

    sudo su -
    useradd vagrant
    visudo

Add "vagrant ALL=(ALL) NOPASSWD:ALL" to the end of the /etc/sudoers.tmp file and
save it.

Now set up ssh access using the insecure keypair for public access to the box. If
you want a secure box, create your own keypair. You can install the insecure 
keypair with the following commands:[^1]

    cd /home/vagrant
    mkdir .ssh
    wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O .ssh/authorized_keys
    chmod 700 .ssh
    chmod 600 .ssh/authorized_keys
    chown -R vagrant .ssh

The last step is to package a new Vagrant base box from the VM. We will need to
know the name of the Virtualbox VM we are packaging. This can be found by running

    virtualbox &
    
This will launch virtualbox and you can see which VM is running. Then run

    vagrant package --base <Virtualbox VM name> --output <Chosen name>
    
I ran:

    vagrant package --base my-site_default_123983453 --output LEMP.box

This will output a file called "LEMP" to your current directory. Now install the
box with

    vagrant box add <Box name> <File name>

    vagrant box add LEMP LEMP.box

Now go to another directory and try it out with:

    vagrant init LEMP

###### References

[^1]: [Blog post by Angel Ruiz](http://aruizca.com/steps-to-create-a-vagrant-base-box-with-ubuntu-14-04-desktop-gui-and-virtualbox/)
[^2]: [Vagrant docs](https://www.vagrantup.com/docs/virtualbox/boxes.html)
[^3]: [Vagrant docs](https://www.vagrantup.com/docs/boxes/base.html)
