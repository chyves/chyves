This early in the project, a map is not defined. However many goals are planned:

Move to library files for use by `chyves-utils` for certain functions _but_ **maintain the commit history/blame**.
- Copy `sbin/chyves` to each file in `lib/`, rename, then modify out lines.
- Use `git diff --find-copies-harder` to catch changes.

Rewrite script to not use `__get_pool_for_guest` direct into a variable. Or at least write a something that at least checks the guest name is valid. Invalid names are not correctly exited. stage1/stage2?

Write `__bulk_verify` to be supplied a guest name and maybe a pool to run the necessary checks as a lot of that code a repeated over and over.

Rewrite to have a CPU manufacture variable. A Intel/AMD/* check, *=dragons.

Fix __network remove and likely add (error when does not exist on system.)

`__are_guests_running()`
- `$1` is list of guests
- Otherwise all guests are checked.

Create restrictions in `__set` for:
- tap numbers +32768
- .config
   - restriction to: check_for_updates|console_start_offset|dev_mode|log_mode|restrict_new_property_names|tap_start_offset|tap_up_by_default|vlan_iface_base_name
   - redirection to __network for: bridge([0-9]{1,5})_phy_attach|bridge([0-9]{1,5})_tap_members
   - input verification for check_for_updates: daily|weekly|monthly|off

31-4 character limit for name (create, clone, rename)

`__multi_chyves_zfs_property` tweaks:
- Remove more than one pool setting. Unnecessary as the properties on non-primary pools are not user settable.

Rewrite IO MMU check for AMD? (svm?)
- Verify AMD-Vi / IOMMU check method

Create guest properties in `guests/bguest/.config`?

Write in code for `__cloneguest` to actually support a real clone.
- How to handle multiple datasets?
- "origin" ZFS property important
- `clone` and `clone_assc` properties to keep track of this
- Multi-disk support
- Rename `-r` to `-i` for independent
- `-c` becomes proper clone
- `-d` becomes duplicate

Add ability to use commas with guest names for (aka multi-guest support):
- <strike>`chyves create`</strike>
- <strike>`chyves set`</strike>
- `chyves get`
- `chyves start` - Pending rewrite
- `chyves stop`
- `chyves destroy`
- `chyves delete`
- `chyves forcekill`

- Console changes
  - Add `conreset` for individual guests in addition to all.
     - Poll assigned guest con name
  - Write `__reorder_consoles` function
   - Will reorder all the console numbers
   - All guests must be stopped
   - <strike>Settable offset to start at.<strike>
   - This will increase compatibility on systems using multiple bhyve management tools
  - Add ability to use `chyves console bguest -t` to open new pane in tmux and rename pane.
   - Check if `tmux` is installed (use `__verify_binary_available`)
   - Check if guest is valid
   - Check is `cu` is opened for guest already (shared)
  - Console numbers are never reused. Always increment but can run reorder
  -Add `__verify_console_unused` function
    - Get guest name
    - Get guest console
    - `ps -aux | grep $console`

Input formatting for size and ram properties
- Function to be called __verify_byte_nomenclature

Modify the check for which dataset version is in use.
- This is because there might be multiple versions of chyves install (stable, dev, and/or sid)
- A warning will be required for version that do make changes that are not backwards compatible.
- A range might be necessary.
- Maybe just a "_DATASET_VERSION" instead?

Create handling for configuring `.config`.
- <strike>`chyves list .config` and `chyves list .config`</strike>
- Syntax for set will be `chyves set .config [pool] property`

<strike>FreeNAS verification out of setup and into a function.</strike>
- Will be used elsewhere to tell user to configure tunables
- Write code to `grep` FreeNAS config file and see if the tunables are actually set. (This would be another function)

Adapt `__verify_valid_guest` to `__verify_valid_dataset` and add flags to function.

Restructured command layout to have less sub-commands.
- `remove` for `remove` `rmiso` `rmfw` `rmpci`

#### Changes requiring meticulous testing:

Create __dataset with:
- `chyves dataset <pool-name> setup`  - Move remaining code from `__setup()`
- `chyves dataset <pool-name> upgrade`  - Upgrade a dataset version
- `chyves dataset <pool-name> promote`  - Promote a dataset to primary role

Consolidate or rewrite `__start` and `__uefi`
- Possibly `__boot` and `__load` as well.

Change networking handling
- **Nearly finished. Polishing at this point.**

#### Not looking like it is possible:

Add `for` loop to reduce code for `zfs get`s in that start sequences and elsewhere
- Change to global variables with `_guest_$var` variables.
- Preliminary tests with `sh` do no work, `bash` does work.

Create a variable section of commonly used `grep` pipes to increase readability. Prefix `_GREP_action`.
- Do not think this is going to work. Preliminary tests did not work.

#### Considerations:

Logs?
- Dual console with one being logged on startup? Is that possible?

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
