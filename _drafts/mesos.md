# Mesos

Mesos makes running a data centre much simpler. 

These notes are based on 'Mesos in Action' by Roger Ignazio.

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
