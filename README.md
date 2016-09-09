# chyves v0.1.7-dev:

<img src="https://github.com/chyves/chyves-media/raw/master/chyves-logo-v1-medium.png" alt="chyves logo version 1" width="449" height="439" align="right">

chyves is a `bhyve` front end manager. chyves is a direct code descendent of `iohyve` and a complete code rewrite was started in April 2016.

The goal of this project is to provide a bhyve front end tool that is easy to use, develop for, and debug. `chyves` is developed for an out of the box experience suited for the most basic of users. However power users will find just as much utility with features such as true ZFS clones, PCI passthrough, rapid deployment, disk images, and snapshot reverted states on boot/reboot. Many features are targeted for large VM fleets where multiple or all guests can be specified, such as `chyves gst1,gst2,gst3 start`, `chyves all stop`, and `chyves GoldMasterVM clone devel,production01,production02`.

`chyves` utilizes FreeBSD’s `bhyve` hypervisor to start and manage type 2 virtualized guests and their resources. `bhyve`'s primary interface to guests is through a serial interface. However with the release of FreeBSD version 11 came UEFI GOP support. This allows for a VNC console to be used to manage UEFI guests.

This project has two branches it uses: `master` and `dev`. The ingress branch for all PRs and development is the `dev` branch. After a chunk of code has been tested in `dev`, it gets merge back into `master`. See [DEVELOPMENT.md](DEVELOPMENT.md) for details.

`chyves` is primary developed on FreeBSD 12-CURRENT and further tested on 11.0-STABLE. Most features should work on 10.3-STABLE as `chyves` was initially developed on 10.3 but some features are not available such as UEFI GOP.

For the 'show-me' types, watch terminal play back of most features on [chyves.org](http://chyves.org/) under the [demo section](http://chyves.org/#demo).

See the following documents for their respective purpose:
- [BUG-REPORTS.md](BUG-REPORTS.md) - How to report issues and get them resolved.
- [CHANGELOG.md](CHANGELOG.md) - See a summarized list of changes to this project.
- [CREDITS.md](CREDITS.md) - See who has contributed to this project.
- [DEVELOPMENT.md](DEVELOPMENT.md) - Coding practices for chyves.
- [LICENSE](LICENSE) - BSD 2-Clause License notice.
- [Makefile](Makefile) - Used to install chyves from GitHub clone.
- [MAN PAGE](http://htmlpreview.github.com/?https://raw.githubusercontent.com/chyves/chyves/master/man/chyves.8.html) - man page in html format.
- [README.md](README.md) - This document.
- [TODO.md](TODO.md) - Project goals.
- [UPGRADING.md](UPGRADING.md) - Reference for needed changes from version to version
- [USAGE.md](USAGE.md) - Brief crash-course on how-to use chyves.
