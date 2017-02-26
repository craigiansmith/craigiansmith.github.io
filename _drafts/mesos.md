# Mesos

These notes are based on 'Mesos in Action' by Roger Ignazio.

Mesos makes running a data centre much simpler. 

It is useful when you have a bunch of computers, and you have software that can
run in a distributed fashion. You can also add extra agents to the cluster as
needed.

Initial configuration of mesos masters and agents (and zookeeper instances) can
be done using a configuration management tool such as Chef, Puppet and orchestrated
with a tool like Fabric or Ansible.

To install on ubuntu, add the repo key. Then install mesos and zookeeperd.

To try it out on your local machine, edit the /etc/zookeeper/zk.cfg file and 
uncomment one server name. 

Then configure /etc/mesos-master.

Then configure /etc/mesos-slave.

Then start the mesos-master service, and the mesos-slave service.

Visit localhost:5050 to see the UI managing the resources available on the local
machine.

In a nutshell, the Apache Zookeeper will keep track of which mesos master is 
in charge. The mesos master that is in charge will receive resource offers from
the mesos slaves and farm them out to registered frameworks.

To configure mesos add a file with the name of the option to be configured to
/etc/mesos and in the file place the values for that option, either separated
by commas on one line, or on separate lines. For instance to add roles create a
file named `roles` in `/etc/mesos` and add the roles you would like to use in
your resource allocation.

To upgrade mesos masters, start with the stand by masters, then when they are 
ready, failover the leader and upgrade that after one of the previously upgraded
stand by masters has been elected leader.

Use the authentication and authorization facilities built in to mesos, so that
no one else can sign up a rogue mesos agent to tap into your workflow and 
compromise your data; and so that no one else can register a framework to 
utilise your pool of agents.

Beware of additional newlines being added to configuration files by vim or emacs.

Marathon can be used to run apps in a distributed fasion on a mesos cluster.
Write the app, define what resources it needs, then say how many instances of
the app you want and let Marathon manage it. Marathon will launch a mesos task
and automatically relaunch it when a node fails.

## Commands

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
    echo "deb http://repos.mesosphere.io/ubuntu xenial main" | \
        sudo tee /etc/apt/sources.list.d/mesosphere.list
    sudo apt-get update
    sudo apt-get install zookeeperd mesos marathon
    echo "zk://localhost:2181/mesos" | sudo tee /etc/mesos/zk
    sudo service mesos-master start
    sudo service mesos-slave start
    sudo service marathon start

## Check your work

Visit localhost:5050 for Mesos master. 
Visit localhost:8080 for Marathon UI.
