This early in the project, a map is not defined. However many goals are planned:

Modify the check for which dataset version is in use.
- This is because there might be multiple versions of chyves install (stable, dev, and/or sid)
- A warning will be required for version that do make changes that are not backwards compatiable.
- A range might be necessary.

Add `__verify_console_unused` function
- Get guest name
- Get guest console
- `ps-aux | grep $console`

Change networking handling
- Use `chyves:bridge` property to guests
 - Handling so that multiple bridges can used
 - Requirement:
   - A physical interface/vlan can only be assigned to one bridge
     - Add `chyves:bridgeXX_physical_parent` to `.config`
       - Valid values would be physical|vlan|null
        - null would be used for internal networks only.
- Deprecate `chyves setup net=em0`
- Rewritten start of a guest to include:
 - Creation or verification of `bridge`
 - Creation or verification of `tap`
 - Addition or verfication of `tap` membership of `bridge`
 - Verify sysctl
 - Verify all interfaces are `UP`
- Add `.default` property for bridge
- Write handling for simple systems to guess the the defaults

Create handling for configuring `.config`.

Write `__reorder_consoles` function
- Will reorder all the console numbers
- All guests must be stopped
- Settable offset to start at.
- This will increase compatiability on systems using multiple bhyve management tools

Write `__check_guest_running` function
- Insert where necessary.

Write `__get_property` function
- Use flags to specify either the guest|`.defaults`|`.config` properties.

Write some function to simplify the YES|NO blocks in `__list` and `__info`

Pull FreeNAS verification out of setup and into a function.
- Will be used elsewhere to tell user to configure tunables
- Likley just a true|false return
- Maybe write code to `grep` config file and see if the tunables are actually set. (This would be another function)

Add check for `set` for properties in `.defaults` that way a property can not be set that does not get pulled in for guests.
- Create variable with list of approved variables

Checks for more than one `.default`, `ISO`, and `Firmware` dataset on system.
- Use `wc -l`
- Adapt `__verify_valid_guest` to `__verify_valid_dataset` and add flags to function.

Check and test to see if secondary pools store the `device.map` and `grub.cfg` files with the correct dataset. Is this even necessary? Even imported `iohyve` guests will copy from the wrong location to the right location.

Restructured command layout to have less sub-commands.
- `remove` for `remove` `rmiso` `rmfw` `rmpci`

Add ability to use `chyves console bguest -t` to open new pane in tmux and rename pane.
- Check if tmux is installed (use `__verify_binary_available`) 
- Check if guest is valid
- Check is cu is openned for guest already (shared)

Debug mode?
- Print populated command used to execute grub-bhyve, bhyvectl, and bhyve.
- Add `chyves:verbose_mode` [1|0] to `.config`

#### General plan:
Added comments throughout the code to indicate what is going on.

Added more output to indicate to the end user what is happening in the script

Get redundant code into functions. Use a standard nomenclature to denote internal use functions? See vm-bhyve for help.

Normalize variables to a consistent verbose naming scheme.

Need help with:
- Spelling and grammar checking `man`, UI, and internal notes.
- Pre-release testers
- Fill in gaps in `CHANGELOG.MD` 
- Feedback
- Creating ports
 - Find someone who can help with this. 
 - chyves
   - Require / Optional
     - tmux "Used with `chyves console $guest -t` to create a console pane and rename it."
      - grub2-bhyve "Used to boot non-UEFI and non-bhyveload guests (Read: Non-FreeBSD guests)"
 -  chyves-devel
   - Require / Optional
     - tmux "Used with `chyves console $guest -t` to create a console pane and rename it."
      - grub2-bhyve "Used to boot non-UEFI and non-bhyveload guests (Read: Non-FreeBSD guests)"
      - txt2man "Used to rebuild man page file after edits. Use make buildman"
 -  chyves-util
   -  Require / Optional
     - qemu / Virtualbox "Used to convert ESXi guest disk images."

## Testing!!!
