Securing Linux

Getting serious about using my laptop I decided to take a first step towards
conscious security. 

Installed 
0. lynis : to perform a security audit of my kubuntu system
1. rkhunter : to check for malware and rootkits
2. fail2ban : to lock out IPs that try unsuccessfully to connect via ssh,
too many times
3. acct : to enable process accounting
4. debsums : to match md5 checksums for downloaded packages
5. ufw : raise a firewall

Seems like a lot, but taking it a step at a time I managed to gain a little
more peace of mine in a short time.

The packages can be installed with a single command:
    
    sudo apt-get install -y lynis rkhunter fail2ban acct debsums

Then it's good to start with an overview so fire up lynis:

    sudo lynis -c

Next I ran rkhunter to check for rootkits and malware. To begin with rkhunter 
needs to set up it's data files. By running the following command it will do so
based on the files that are already on the machine, as well as information
from the package manager.

    sudo rkhunter --propupd

To actually run the root kit hunter you can use the following command. It must
be run as root. However, if you simply want to see the usage screen you can
run it as any user without any options.

    sudo rkhunter --checkall

On the first run, you may well see some warnings. There's probably no need to
worry, but each one should be investigated and dealt with. Some hidden files
are supposed to be on your system. On my Kubuntu 16.10 machine rkhunter found
`/etc/.java` and `/dev/shm/pulse*`. After a little research it seems that both
these are okay. The first is presumably for java, and the second is for shared
memory files used by pulse audio. Both of these are included in the rkhunter 
config file located at `/etc/rkhunter.conf`, simply search for those lines and
uncomment them.

To see if your change is successful, and get that immediate feedback which is
so valuable, run the rkhunter check again. This time you might not want to have
to press a key to get through it so add the `--sk` option, and you only need to
be concerned with warnings so use the report warnings only `--rwo` option, and
then use `--c` to tell rkhunter to run the check.

    sudo rkhunter --sk --rwo -c

Rkhunter also complained of a binary file being replaced by a script. In this 
case it was `/usr/bin/lwp-request`. Having never heard of this script before I 
was a little concerned, so I inspected the file. It was a perl text file and it's
been a little while since I last used perl so I eyeballed it to see if anything
stood out as malicious, and then started searching online. The fix for this is
to set the `PKGMGR` variable in `/etc/rkhunter.conf.local` (create a new file, if
necessary). Set it to the package manager for your system. On Kubuntu that's
`PKGMGR=DPKG` (no spaces). And run rkhunter again.
[mailing list](https://sourceforge.net/p/rkhunter/mailman/message/31460254/)
The final warning that rkhunter gave was that SSH was configured to allow root
access. To fix this warning you need to set rkhunter and ssh to the same
expectations, either allow it or not. I no longer needed to allow it so I
edited `/etc/ssh/sshd_config` according to the suggestion given by rkhunter.

Now it's time to run rkhunter again. And this time it gave no output. Hooray!

Setting up process accouting is straightforward. Create a log file and start it.
[blog](http://www.shibuvarkala.com/2009/04/howto-enable-process-accounting-in.html)

    sudo touch /var/log/process_accounting.log
    sudo accton /var/log/process_accounting.log 
