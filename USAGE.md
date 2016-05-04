This document provides a quick start guide for setting up guests and zpools. However, the man page is the ultimate source of truth (just after the source).

### Installing `chyves`

Via pkg:
````
root@bhost:~ # pkg update
root@bhost:~ # pkg install chyves
````
Via ports:
````
user@bhost:~ $ portsnap fetch update
user@bhost:~ $ cd /usr/ports/sysutils/chyves                    # chyves-devel is also available
root@bhost:/usr/ports/sysutils/chyves # make install            # No options to configure
````
Via git clone:
````
user@bhost:~ $ git clone https://github.com/chyves/chyves.git
user@bhost:~ $ cd chyves
root@bhost:/home/user/chyves # make install
````
Via source install
````
user@bhost:~ $ fetch https://github.com/chyves/chyves/archive/master.zip
user@bhost:~ $ unzip master.zip
user@bhost:~ $ cd chyves-master
root@bhost:/home/user/chyves-master # make install
````

### Dependencies
`bhyve` and `chyves` will run on a base installation, however kernel modules are required that are not loaded by default. There are also certain applications that enchance their capabilities. `chyves` checks for these components and exits if not detected.

Kernel Modules
- `vmm` (Required to run the guests as this allocates the resources)
- `nmdm` (Required for serial console access to the guests)
- `if_tap` (Required for network access to the guests)
- `if_bridge` (Required for network access to the guests)
 - `bridgestp` (Required by `if_bridge`)

Applications
- grub2-bhyve (Required for non-FreeBSD guests)
- cu (Install in base - provide serial console access)
- tmux (Required only when using the -t flag in `chyves console bguest -t`)

### Finer details
````
man chyves
````

### Setup

This tool does require at least one ZFS pool. Multiple pools are supported, the first pool is assigned the primary pool role but can be changed afterwards. The primary pool is also the only pool containing with the firmware resources, ISO resources, and .default values. The primary pool can be changed with `chyves set primarypool=zroot`.

To setup a pool for `chyves` use run:
````
chyves setup pool=zroot
````
To load the necessary modules run (nmdm, vmm, if_tap, if_bridge):
````
chyves setup kmod=1
````
To automatically setup the necessary networking run the follow:
````
chyves setup net=em0
````
Where `em0` is the name of your network interface. This creates a `bridge0` interface and attaches `tap#` interfaces for each guest. The `tap` interfaces are process locked, meaning only one guest can be assigned per `tap` interface.

All three can be use together like so:
````
chyves setup pool=tank kmod=1 net=em0
````
If you want `chyves` to set up the kernel modules and bridge0 every time you boot, add these lines to `/etc/rc.conf`:
````
chyves_enable="YES"
chyves_flags="kmod=1 net=em0"
````
If you want more control over your setup, feel free to read the [handbook](https://www.freebsd.org/doc/en/books/handbook/virtualization-host-bhyve.html).


**Usage Examples**

List all guests created with:

    chyves list

You can change guest properties by using set:

    chyves set bsdguest ram=512M                 #set ram to 512 Megabytes
    chyves set bsdguest cpu=1                    #set cpus to 1 core
    chyves set bsdguest pcidev:1=passthru,2/0/0  #pass through a pci device

You can also set more than one property at once:
```
chyves set bsdguest tap=tap0 con=nmdm0
```
You can also set a description that contain spaces will need to be double quoted (")
````
chyves set bguest description="A chyves guest."
````
It is always prudent to `stop` (and then `destroy` in some cases) a guest before changing settings. `chyves` runs off the current state of the properties and not the settings the guest started with.
Destroying a guest does not `delete` a guest from the host, it `destroys` the guest in `VMM`.
```
chyves destroy bsdguest
```

Get a specific guest property:

    chyves get bsdguest ram

Get all guest properties:

    chyves getall bsdguest

Do cool ZFS stuff to a guest:
````
#Take a snapshot of a guest.
chyves snap bsdguest@beforeupdate  #take snapshot
chyves snaplist                    #list snapshots
chyves roll bsdguest@beforeupdate  #rollback to snapshot

# Make an independent clone of a guest
# This is not a zfs clone, but a true copy of a dataset
chyves clone bsdguest dolly	   #make a clone of bsdguest to dolly
````
**FreeBSD Guests**

Fetch FreeBSD install ISO for later:

    chyves fetchiso ftp://ftp.freebsd.org/.../10.1/FreeBSD-10.1-RELEASE-amd64-bootonly.iso

Rename the ISO if you would like:

    chyves renameiso FreeBSD-10.1-RELEASE-amd64-bootonly.iso fbsd10.iso

Create a new FreeBSD guest named bsdguest with an 8Gigabyte virtual HDD:

    chyves create bsdguest 8G

List ISO's:

    chyves isolist

Install the FreeBSD guest bsdguest:

    chyves install bsdguest FreeBSD-10.1-RELEASE-amd64-bootonly.iso

Console into the installation:

    chyves console bsdguest

Once installation is done, exit console (~~.) and stop guest:

    chyves stop bsdguest

Now that the guest is installed, it can be started like usual:

    chyves start bsdguest

Some guest os's can be gracefully stopped:

    chyves stop bsdguest

If you are having problems with a guest that is unresponsive you can forcekill it as a last resort.
USE THIS WITH CAUTION, IT WILL KILL ALL PROCESSES THAT MATCH THE NAME OF THE GUEST.
```
chyves forcekill grubguest
```
**Other BSDs:**

Try out OpenBSD:
````
chyves set obsdguest loader=grub-bhyve os=openbsd58
chyves install obsdguest install58.iso
chyves console obsdguest
````
Try out NetBSD:
````
chyves set nbsdguest loader=grub-bhyve
chyves set nbsdguest os=netbsd
chyves install nbsdguest NetBSD-6.1.5-amd64.iso
chyves console nbsdguest
````
**Linux flavors:**

Try out Debian or Ubuntu _(note LVM installs should work with os=d8lvm)_:
````
chyves set debguest loader=grub-bhyve
chyves set debguest os=debian
chyves install debguest debian-8.2.0-amd64-i386-netinst.iso
chyves console debguest
````
Try out ArchLinux:
````
chyves set archguest loader=grub-bhyve
chyves set archguest os=arch
chyves install archguest archlinux-2015.10.01-dual.iso
chyves console archguest
````
Try out CentOS or RHEL _(note version 6 would use os=centos6)_:
````
chyves set centosguest loader=grub-bhyve
chyves set centosguest os=centos7
chyves install centosguest CentOS-7-x86_64-Everything-1511.iso
chyves console centosguest
````
Try out Gentoo:
 ````
 chyves set loader=grub-bhyve gentooguest
 chyves set os=gentoo gentooguest
 chyves install gentooguest install-amd64-minimal-20160414.iso
 chyves console gentooguest
 ````
#####Use your own custom `grub.cfg` and `device.map` files

If you don't want chyves to take care of the `grub.cfg` and `device.map` files, you can now "roll your own" and place them in the guests dataset (`/chyves/guestname/`).
Of course, you must set the guest properties `loader=grub-bhyve` and `os=custom`.
For instance, if you have an OpenBSD guest located in `/chyves/obsd59/` and an install ISO in `/chyves/ISO/install59.iso/` and your pool is `zroot`, your files will look like this:

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
