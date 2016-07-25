# chyves v0.0.7:

<img src="https://github.com/chyves/chyves-media/raw/master/chyves-logo-v1-medium.png" alt="chyves logo version 1" width="449" height="439" align="right">

chyves is a `bhyve` front end manager. chyves is a direct code descendent of `iohyve` and a complete code rewrite was started in April 2016.

The goal of this project is to provide a bhyve front end tool that is easy to use, develop for, and debug. `chyves` is developed for an out of the box experience suited for the most basic of users. However power users will find just as much utility with features such as true ZFS clones, PCI passthrough, rapid deployment, disk images, and snapshot reverted states on boot/reboot. Many features are targeted for large VM fleets where multiple or all guests can be specified, such as `chyves gst1,gst2,gst3 start`, `chyves all stop`, and `chyves GoldMasterVM clone devel,production01,production02`.

`chyves` utilizes FreeBSD’s `bhyve` hypervisor to start and manage type 2 virtualized guests. `bhyve`'s primary interface to guests is through a serial interface. However UEFI GOP code was released for `bhyve` in May 2016. This code allows for a VNC console be used to manage UEFI guests. `chyves` supports UEFI GOP if on a supporting host, [see here for instructions](http://justinholcomb.me/blog/2016/05/28/bhyve-uefi-gop-support.html) on what is involved and look in the man page at `uefi_vnc_*` guest parameters.

`chyves` is primary tested on FreeBSD 11.0, however some resources go into testing on FreeBSD 12-CURRENT. Should work on 10.3-RELEASE as `chyves` was initially developed on it but some features are not available.

See the following documents for their respective purpose:
- [BUG-REPORTS.md](BUG-REPORTS.md) - How to report issues and get them resolved.
- [CHANGELOG.md](CHANGELOG.md) - See a summarized list of changes to this project.
- [CREDITS.md](CREDITS.md) - See who has contributed to this project.
- [DEVELOPMENT.md](DEVELOPMENT.md) - Coding practices for chyves.
- [LICENSE](LICENSE) - BSD 2-Clause License notice.
- [Makefile](Makefile) - Used to install chyves from GitHub clone.
- [MAN PAGE](man/chyves.8.html) - man page in html format.
- [README.md](README.md) - This document.
- [TODO.md](TODO.md) - Project goals.
- [UPGRADING.md](UPGRADING.md) - Reference for needed changes from version to version
- [USAGE.md](USAGE.md) - How to use chyves.
