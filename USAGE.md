`chyves` has a lot of power, everything from: PCI passthrough devices to the guest from the host; to running Windows guests; to using a VNC console for UEFI guests; to VALE network support; to rapidly managing 50 guests with a single command; to private networks; to assigning multiple NICs on a guest with separate bridges/vlans; to designing and managing that complex network design; to attaching 208 PCI devices to a guest; and much more.... but this document does not to go into detail about that.

This document only provides a quick start guide for setting up `chyves` and then basic guest management. Running `chyves help` will give you a quick overview of the commands and syntax, however the man page is the ultimate source of truth (just after the source of course). Reading the man page is highly recommended to get maximum utilization out of this utility.

The [chyves.org](http://chyves.org) page has [text based demonstrations](http://chyves.org/demo) of chyves using the __ platform.

### Installing `chyves`
The recommended way to install `chyves` is from downloading the project zip from GitHub from your preferred branch. This will have the latest stable code from the project. `chyves` is based on the Bourne shell for execution. This means that when running 'make install' a complier is not required and simply copies the files to their install locations with the correct permissions. To uninstall `make deinstall` will just as easily remove the same files and folders from the system.

#### Via source install from GitHub:
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
#### Via ports:
Lags slightly behind the newest code on GitHub.
```
                         user@bhost:~ $ portsnap fetch update
                         user@bhost:~ $ cd /usr/ports/sysutils/chyves           # chyves-dev is also available
root@bhost:/usr/ports/sysutils/chyves # make install                            # No options to configure
```
#### Via pkg:
Lags a little further behind, relying on code in ports.
```
root@bhost:~ # pkg update
root@bhost:~ # pkg install chyves
```

### Dependencies
`bhyve` and `chyves` will run on a base FreeBSD installation, however the required kernel modules are not loaded by default. There are also certain binaries that enhance their capabilities. `chyves` checks for these components and exits if not detected. The default settings for `chyves` attempts to get users running with minimal effort, so the kernel modules are loaded by default.

#### Kernel Modules
- `vmm` (Required to run the guests, this allocates the resources)
- `nmdm` (Required for serial console access to the guests)
- `if_tap` (Required for network access to the guests)
- `if_bridge` (Required for network access to the guests)
 - `bridgestp` (Required by `if_bridge`)

#### Other binaries
- `bhyveload` - Installed with base - Required to boot FreeBSD guests.
- `cu` - Installed with base - provides serial console access
- `grub2-bhyve` - On ports - Required for booting non-FreeBSD or non-UEFI guests
- `[BHYVE_UEFI_20151002.fd](https://people.freebsd.org/~grehan/bhyve_uefi/BHYVE_UEFI_20151002.fd)` - Required to boot UEFI guests.
- `[BHYVE_UEFI_20160526.fd](https://people.freebsd.org/~grehan/bhyve_uefi/BHYVE_UEFI_20160526.fd)` - Required to boot UEFI guests with VNC support.
- `tmux` - Required when using the command `chyves bguest console tmux`
- `vale-ctl` - Required for VALE networking support.

### Finer details
```
man chyves
```

### Setup

#### ZFS pool
This tool does require at least one ZFS pool as all the data and properties are stored on a ZFS pool. Multiple pools are supported, the first pool is assigned the primary pool role but can be changed afterwards. The primary pool is also the only pool containing with the firmware resources, ISO resources, and the global .config values. The primary pool can be changed with `chyves dataset new-prim-pool promote` which moves the resources and global configuration to `new-prim-pool` from the current primary pool.

To setup a pool for `chyves` use run:
```
chyves dataset zroot setup
```

#### Kernel modules
By default kernel modules are automatically loaded when trying to run a command that requires a loaded modules:

#### Networking
To automatically setup the necessary networking run the follow:
````
chyves network bridge0 attach em0
````
Where "`em0`" is the name of your network interface. This creates a `bridge0` interface and attaches `tap#` interfaces for each guest. The `tap` interfaces are process locked, meaning only one guest can be assigned per `tap` interface.

### `/etc/rc.conf`
If you want `chyves` to boot guests at startup set up the kernel modules and bridge0 every time you boot, add these lines to `/etc/rc.conf`:
````
chyves_enable="YES"
chyves_flags="kmod=1 net=em0"
````

### Brief crash course:

Lists all guests:
```
chyves list
```

You can change guest properties by using set:
```
chyves bguest set ram=512M                 # Set ram to 512 Megabytes
chyves bguest set cpu=1                    # Set cpu core count to 1
```

You can also set more than one property at once:
```
chyves bguest set tap=tap0 con=nmdm0
```
You can also set a description that contain spaces will need to be double quoted (")
```
chyves bguest set description="A chyves guest."
```
It is always prudent to `stop` (and then `reclaim` in some cases) a guest before changing settings. `chyves` runs off the current state of the properties and not the settings the guest started with.
```
chyves bguest reclaim
```

Get a specific guest property:
```
chyves bguest get ram
```

Get all guest properties:
```
chyves bguest get all
```

Do cool ZFS stuff to a guest:
```
#Take a snapshot of a guest.
chyves snap bguest@beforeupdate  #take snapshot
chyves snaplist                    #list snapshots
chyves roll bguest@beforeupdate  #rollback to snapshot

# Make an independent clone of a guest
# This is not a zfs clone, but a true copy of a dataset
chyves clone bsdguest dolly	   #make a clone of bsdguest to dolly
````

#### Install and manage a FreeBSD Guest

Fetch FreeBSD install ISO for later:
```
chyves iso import ftp://ftp.freebsd.org/pub/FreeBSD/releases/amd64/amd64/ISO-IMAGES/10.3/FreeBSD-10.3-RELEASE-amd64-bootonly.iso
```
Importing an ISO resource direct from a ftp/http/https location will require inputting a hash. The hash is prompted for before beginning the download and then hash is computed and compared after downloading. Also importing `iso.gz` and `iso.xz` files directly, these files are hash checked and then decompressed.

Rename the ISO if you would like:
```
chyves iso rename FreeBSD-10.3-RELEASE-amd64-bootonly.iso fbsd103-boot.iso
```

List ISO's:
```
chyves iso list
```

Create a new FreeBSD guest named "bsdguest":
```
chyves bsdguest create
```

Install the FreeBSD using the renamed ISO from above:
```
chyves bsdguest start fbsd103-boot.iso
```

Console into the installation:
```
chyves bsdguest console
```

Once installation is done, exit console (~~.) and stop guest:
```
chyves bsdguest stop
```

Now that the guest is installed, it can be started like usual:
```
chyves bsdguest start
```

Gracefully shutdown the guest externally with:
```
chyves bsdguest stop
```
This is effectively like pressing the power button on a computer tower, this means the guest OS determines how to respond. Running `poweroff` or the equivalent will shutdown a guest and `reboot`s are handle as expected.

#### Setup for other OSes
Here is incomplete list of how to get other OSes running on `chyves`:

##### Other BSDs:

Try out OpenBSD:
````
chyves openbsdgst create
chyves openbsdgst set loader=grub-bhyve os=openbsd59
chyves openbsdgst start install59.iso
chyves openbsdgst console
````
Try out NetBSD:
````
chyves netbsdgst create
chyves netbsdgst set loader=grub-bhyve os=netbsd
chyves netbsdgst start NetBSD-6.1.5-amd64.iso
chyves netbsdgst console
````
##### Linux:

Try out Debian or Ubuntu _(note LVM installs require "os" be set to "d8lvm")_:
```
chyves debguest create
chyves debguest set loader=grub-bhyve os=debian
chyves debguest start debian-8.2.0-amd64-i386-netinst.iso
chyves debguest console
```
Try out ArchLinux:
```
chyves archguest create
chyves archguest set loader=grub-bhyve os=arch
chyves archguest start archguest archlinux-2015.10.01-dual.iso
chyves archguest console archguest
```
Try out CentOS or RHEL _(note version 6 would use os=centos6)_:
```
chyves centosguest create
chyves centosguest set loader=grub-bhyve os=centos7
chyves centosguest start CentOS-7-x86_64-Everything-1511.iso
chyves centosguest console
```
Try out Gentoo:
```
chyves gentooguest create
chyves gentooguest set loader=grub-bhyve os=gentoo
chyves gentooguest start install-amd64-minimal-20160414.iso
chyves gentooguest console
````

### Use your own custom `grub.cfg` and `device.map` files

If you don't want `chyves` to take care of generating a `grub.cfg` and `device.map` files, you can now "roll your own" and place them in the guests dataset (`/chyves/guestname/` or `/chyves/secondary-pool-name/guestname/`). This requires setting the guest properties `loader` to `grub-bhyve` and `os` to `custom`.

An example is if you have an OpenBSD guest "obsd59" located in `/chyves/obsd59/` and an install ISO in `/chyves/ISO/install59.iso/` and your pool is `zroot`, your files will look like this:

`device.map` file:
```
(hd0) /dev/zvol/zroot/chyves/obsd59/disk0
(cd0) /chyves/ISO/install59.iso/install59.iso
```

`grub.cfg` file for installation:
```
kopenbsd -h com0 (cd0)/5.9/amd64/bsd.rd
boot
```

`grub.cfg` file after installation is complete:
```
kopenbsd -h com0 -r sd0a (hd0,openbsd1)/bsd
boot
```

If you would like to see your changes integrated into `chyves` please contact one of the developers or open an issue on GitHub. We love to integrate changes to save other people from having to re-discover how to get _x_ to work.
