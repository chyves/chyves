This early in the project, a map is not defined. However many goals are planned:

Add ability to use commas with guest names for things like `chyves create`, `chyves set`, `chyves start`, `chyves stop`, `chyves forcekill` and maybe `chyves get`.
- This would make rapid deploy of guests possible.
- `for` loops
- This does make `__verify_valid_guest` a little complicated

Create a variable section of commonly used `grep` pipes to increase readability. Prefix `_GREP_action`.
- Do not think this is going to work. Preliminary tests did not work.

Add `conreset` for individual guests in addition to all.
- Poll assigned guest con name

Add `for` loop to reduce code for `zfs get`s in that start sequences and elsewhere
- Change to global variables with `_guest_$var` variables.

Modify the check for which dataset version is in use.
- This is because there might be multiple versions of chyves install (stable, dev, and/or sid)
- A warning will be required for version that do make changes that are not backwards compatible.
- A range might be necessary.

Add `__verify_console_unused` function
- Get guest name
- Get guest console
- `ps -aux | grep $console`

Create handling for configuring `.config`.
- <strike>`chyves list .config` and `chyves list .config`</strike>
- Syntax for set will be `chyves set .config [pool] property`

Write `__reorder_consoles` function
- Will reorder all the console numbers
- All guests must be stopped
- Settable offset to start at.
- This will increase compatibility on systems using multiple bhyve management tools

<strike>FreeNAS verification out of setup and into a function.</strike>
- Will be used elsewhere to tell user to configure tunables
- Write code to `grep` FreeNAS config file and see if the tunables are actually set. (This would be another function)

Adapt `__verify_valid_guest` to `__verify_valid_dataset` and add flags to function.

Restructured command layout to have less sub-commands.
- `remove` for `remove` `rmiso` `rmfw` `rmpci`

Add ability to use `chyves console bguest -t` to open new pane in tmux and rename pane.
- Check if `tmux` is installed (use `__verify_binary_available`)
- Check if guest is valid
- Check is `cu` is opened for guest already (shared)

#### Changes requiring meticulous testing:

Consolidate or rewrite `__start` and `__uefi`
- Possibly `__boot` and `__load` as well.

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
 - Addition or verification of `tap` membership of `bridge`
 - Verify sysctl
 - Verify all interfaces are `UP`
- Add `.default` property for bridge
- Write handling for simple systems to guess the the defaults

#### Considerations:

Logs?
- Dual console with one being logged on startup? Is that possible.

Thoughts on using $1 as a guest name for action???

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
