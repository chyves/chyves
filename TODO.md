This early in the project, a map is not defined. However many goals are planned:

Add __verify_console_unused function
- Get guest name
- Get guest console
- `ps-aux | grep $console`

Add `chyves:bridge` property to guests
- Handling so that multiple bridges can used
- Requirement:
 - A physical interface/vlan can only be assigned to one bridge
   - Maybe add `chyves:bridgeXX_physical_parent` to `.config`
     - Valid values would be physical|vlan|null
      - null would be used for internal networks only.

Add check for `set` for properties in `.defaults` that way a property can not be set that does not get pulled in for guests.

Checks for more than one `.default`, `ISO`, and `Firmware` dataset on system.
- Use `wc -l`

Check and test to see if secondary pools store the `device.map` and `grub.cfg` files with the correct dataset.

Restructured command layout to have less sub-commands.
- `remove` for `remove` `rmiso` `rmfw` `rmpci`

Add ability to use `chyves console bguest -t` to open new pane in tmux and rename pane.
- Check if tmux is installed
- Check if guest is valid
- Check is cu is openned for guest already (shared)

#### General plan:
Added comments throughout the code to indicate what is going on.

Added more output to indicate to the end user what is happening in the script

Get redundant code into functions. Use a standard nomenclature to denote internal use functions? See vm-bhyve for help.

## Testing!!!

