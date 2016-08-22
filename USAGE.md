`chyves` has a lot of power, everything from: PCI passthrough devices; to running Windows guests; to using a VNC console with certain UEFI guests; to VALE network support; to rapidly managing 50 guests with a single command; to private networks; to assigning multiple NICs on a guest with separate bridges/vlans; to designing and managing that complex network design; to attaching 208 PCI devices to a guest; and much more.... _but this document does not to go into detail about that_.

This document only provides a quick start guide for setting up `chyves` and then basic guest management. Running `chyves help` will give you a quick overview of the commands and syntax, however the [man page](http://htmlpreview.github.com/?https://raw.githubusercontent.com/chyves/chyves/master/man/chyves.8.html) is the ultimate source of truth (just after the source, of course). Reading the [man page](http://htmlpreview.github.com/?https://raw.githubusercontent.com/chyves/chyves/master/man/chyves.8.html) is highly recommended to get maximum utilization out of chyves.

The [chyves.org](http://chyves.org) page has [text based demonstrations](http://chyves.org/#demo) of chyves using the text based terminal player, [asciinema](https://asciinema.org).

### Installing `chyves`
The recommended way to install `chyves` is from downloading the project zip from GitHub from your preferred branch. This will have the latest stable code from the project. `chyves` is based on the Bourne shell for execution. This means that when running `make install` a complier _is not required_ and simply copies the files to their install locations with the correct permissions. To uninstall `make deinstall` will just as easily remove the same files and folders from the system.

#### Via source install from GitHub (preferred):
Using this method, the project files are downloaded directly from GitHub. This is a slimmer method than using `git clone` because it lacks the development history of each file.
```
                       user@bhost:~ $ fetch https://github.com/chyves/chyves/archive/master.zip
                       user@bhost:~ $ unzip master.zip
                       user@bhost:~ $ cd chyves-master
root@bhost:/home/user/chyves-master # make install
```
#### Via git clone:
This method provides the development history of all the files. This is the recommended method for developers.
```
                user@bhost:~ $ git clone https://github.com/chyves/chyves.git
                user@bhost:~ $ cd chyves
root@bhost:/home/user/chyves # make install
```
#### Via ports (future):
Lags slightly behind the newest code on GitHub.
```
                         user@bhost:~ $ portsnap fetch update
                         user@bhost:~ $ cd /usr/ports/sysutils/chyves           # chyves-dev is also available
root@bhost:/usr/ports/sysutils/chyves # make install                            # No options to configure
```
#### Via pkg (future):
Lags a little further behind, relying on code in ports.
```
root@bhost:~ # pkg update
root@bhost:~ # pkg install chyves
```

### Upgrading
`chyves` is designed with future changes in mind. There are a couple of mechanisms that ensure the guests and furthermore the datasets have all the parameters and necessary structure to be compatible with the latest version of `chyves`. A guest and/or pool from the first version of `chyves` is designed to be upgradable to the current version using the `chyves <guest> upgrade` and `chyves dataset <pool> upgrade` commands.

### Dependencies

See [here for details](http://htmlpreview.github.com/?https://raw.githubusercontent.com/chyves/chyves/master/man/chyves.8.html#DEPENDENCIES).

### Setup

#### ZFS pool
`chyves` does require at least one ZFS pool. See [DEPENDENCIES section in the man page](http://htmlpreview.github.com/?https://raw.githubusercontent.com/chyves/chyves/master/man/chyves.8.html#DEPENDENCIES) for details.

To setup '`zroot`' pool run:
```
chyves dataset zroot install
```

#### Kernel modules
By default kernel modules are automatically loaded when trying to run a command that requires a loaded modules.

#### Networking
The most basic network configuration will require the following command:
````
chyves network bridge0 attach em0
````
Where "`bridge0`" is the bridge you want to associate the network interface "`em0`" with. See `chyves list bridges` for networking design.

### Start chyves guests on host boot
If you want `chyves` to boot guests at startup set up the kernel modules and bridge0 every time you boot:

Add this line to `/etc/rc.conf`:
````
chyves_enable="YES"
````

Or use `sysrc(8)`:
```
sysrc chyves_enable="YES"
```

Or run the following from the source directory:
```
make installrc
```

### Brief crash course:

See [man page EXAMPLES section](http://htmlpreview.github.com/?https://raw.githubusercontent.com/chyves/chyves/master/man/chyves.8.html#EXAMPLES).
