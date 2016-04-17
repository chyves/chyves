# chyves v0.0.0:

bhyve front end manager using ZFS to store guest data and parameters.

`chyves` enters the market of bhyve front end manager tools. It follows the lead set by `iocage` of using ZFS properties to store guest parameters and is a direct descendent of `iohyve`.

chyves utilizes FreeBSD’s bhyve to start and manage type 2 virtualized guests. This is akin to VirtualBox and KVM. Currently bhyve only provides a serial interface to it's guests, however work is being done to add VNC support via UEFI GOP support. `chyves` attempts to bridge the high entry point of bhyve to a level most technical beginners can use.

The goal of this project is to provide a bhyve front end tool that is easy to use, develop, and debug. This project has a different structure and some differing goals than `iohyve`. For the time being, best effort is given to provide upstream bug fixes to their project as a gratitude for the leg up on this project's start.

`chyves` has also developed a series of tools at `chyves/chyves-utils` to import supported virtual guests from other platforms. This currently includes `iohyve` and snapshotless ESXi guests. Converting from other platforms should be possible if interest is expressed. `chyves-utils` is developed as a separate project as it requires dependancies with VirtualBox for the conversion of disk images.

`chyves` is primary tested on FreeBSD 10.3, however some resources go into testing FreeNAS 9.10 as well.

See the following documents for their respective purpose:
````
BUG-REPORTS.md        How to report issues and get them resolved
CHANGELOG.md          See a summarized list of changes to this project
CONTRIBUTING.md       Ways to contribute to this project
CREDITS.md            See who has contributed to this project
LICENSE               BSD License
README.md             This document.
TODO.md               Project goals
UPGRADING.md          Indicates needed changes version to version
USAGE.md              How to use chyves
````
