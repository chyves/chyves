# chyves v0.0.5:

<img src="https://github.com/chyves/chyves-media/raw/master/chyves-logo-v1-medium.png" alt="chyves logo version 1" width="449" height="439" align="right">

chyves is a bhyve front end manager. chyves follows the lead set by iocage by storing guest parameters as ZFS user properties. chyves is a direct code descendent of iohyve and a complete code rewrite was started in April 2016.

The goal of this project is to provide a bhyve front end tool that is easy to use, develop for, and debug. `chyves` is developed for an out of the box experience suited for the most basic of users. However power users will find that much can be tweaked and configured. There are also many features targeted for large VM fleets as well.

`chyves` utilizes FreeBSD’s `bhyve` hypervisor to start and manage type 2 virtualized guests. This is akin to VirtualBox and KVM. `bhyve`'s primary interface to guests is through a serial interface. However UEFI GOP code was released in May 2016. This code allows for a VNC console be used to manage UEFI guests. `chyves` supports utilizing UEFI GOP if on a supporting host, [see here for instructions](http://justinholcomb.me/blog/2016/05/28/bhyve-uefi-gop-support.html) on what is involved.

`chyves` has also developed a series of tools at `chyves/chyves-utils`. One of the utilities imports supported virtual guests from other platforms. This currently includes `iohyve` and snapshotless ESXi guests. Converting from other platforms should be possible if interest is expressed. `chyves-utils` is developed as a separate project as it requires dependencies with VirtualBox for the conversion of disk images, many users would find a dependency on VirtualBox unacceptable.

This project has three branches it uses: master (stable), dev (testing but stable), and sid (considered unstable and experimental). The ingress branch for PRs and internal development is the `sid` branch. See [DEVELOPMENT.md](DEVELOPMENT.md) for details.

`chyves` is primary tested on FreeBSD 10.3, however some resources go into testing on FreeNAS 9.10 and FreeBSD 11-CURRENT.

See the following documents for their respective purpose:
- [BUG-REPORTS.md](BUG-REPORTS.md) - How to report issues and get them resolved.
- [CHANGELOG.md](CHANGELOG.md) - See a summarized list of changes to this project.
- [chyves.8.txt](man/chyves.8.txt) - man page in text format.
- [CREDITS.md](CREDITS.md) - See who has contributed to this project.
- [DEVELOPMENT.md](DEVELOPMENT.md) - Coding practices for chyves.
- [LICENSE](LICENSE) - BSD 2-Clause License notice.
- [Makefile](Makefile) - Used to install chyves from GitHub clone.
- [README.md](README.md) - This document.
- [TODO.md](TODO.md) - Project goals.
- [UPGRADING.md](UPGRADING.md) - Reference for needed changes from version to version
- [USAGE.md](USAGE.md) - How to use chyves.
