# chyves v0.0.0:

<img src="https://github.com/chyves/chyves-media/raw/master/chyves-logo-v1-medium.png" alt="chyves logo version 1" width="449" height="439" align="right">

`chyves` is a bhyve front end manager using ZFS to store guest data and parameters.

`chyves` enters the market of bhyve front end manager tools. `chyves` follows the lead set by `iocage` by using ZFS properties to store guest parameters and data. `chyves` is a direct code descendent of `iohyve`. This project has a different structure and some differing goals than `iohyve`. For the time being, best effort is given to provide upstream bug fixes to the `iohyve` project as gratitude for the leg up on this project's start.

The goal of this project is to provide a bhyve front end tool that is easy to use, develop for, and debug.

chyves utilizes FreeBSD’s bhyve hypervisor to start and manage type 2 virtualized guests. This is akin to VirtualBox and KVM. Currently bhyve's only interface to guests is a serial interface. `chyves` attempts to bridge the high entry point of bhyve to a level most technical beginners can use.

`chyves` has also developed a series of tools at `chyves/chyves-utils`. One of the utilities imports supported virtual guests from other platforms. This currently includes `iohyve` and snapshotless ESXi guests. Converting from other platforms should be possible if interest is expressed. `chyves-utils` is developed as a separate project as it requires dependancies with VirtualBox for the conversion of disk images, many users would find a dependency on VirtualBox unacceptable.

`chyves` is primary tested on FreeBSD 10.3, however some resources go into testing FreeNAS 9.10 as well.

See the following documents for their respective purpose:
````
BUG-REPORTS.md        How to report issues and get them resolved.
CHANGELOG.md          See a summarized list of changes to this project.
CONTRIBUTING.md       Ways to contribute to this project.
CREDITS.md            See who has contributed to this project.
LICENSE               BSD 2-Clause License notice.
Makefile              Used to install chyves from GitHub clone.
man/chyves.8.txt      man page in text format.
README.md             This document.
TODO.md               Project goals.
UPGRADING.md          Reference for needed changes from version to version
USAGE.md              How to use chyves.
````
