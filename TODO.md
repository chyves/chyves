This early in the project, a map is not defined. However many goals are planned:

Add bridge property and handling.

Deprecate chyves:name property

Checks for more than one .default, ISO, and Firmware dataset on system.

Check and test to see if secondary pools store the device.map and grub.cfg files with the correct dataset.

Get redundant code into functions. Use a standard nomenclature to denote internal use functions. See vm-bhyve for help.

Changed the output of `info` to be more verbose with command line flags.

Added comments throughout the code to indicate what is going on.

Added more output to indicate to the end user what is happening in the script

Restructured command layout to have less sub-commands.
- `get` for `get` `getall`
- `iso` for `fetchiso` `cpiso` `renameiso` and `rmiso`
- `firmware` for `fetchfw` `cpfw` `renamefw` and `rmfw`
- `remove` for `remove` `rmiso` `rmfw` `rmpci`

Add checksum check for ftp/http copied ISOs.

Add ability to use `chyves console bguest -t` to open new pane in tmux and rename pane.
- Check if tmux is installed
- Check if guest is valid
- Check is cu is openned for guest already (shared)

Testing!!!
