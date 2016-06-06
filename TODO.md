This early in the project, a map is not defined. However many goals are planned:

Rewrite to have a CPU manufacture variable. A Intel/AMD/* check, *=dragons.

Fix `network remove` and likely `network add`.
- Error when does not exist on system. Is this still a problem?

Change `__convert_list_to_grep_string` to take both new-line delimited lists and space delimited lists.
- Really just an addition `tr` call will implement this. BUT test it.

Add way to use non-ISO resources for installation.
- Use `./`, `../`, or `/` as a trigger.

VNC client
- `__console_vnc` function
- Global property
  - vnc_client=freerdp|custom
  - vnc_client_cmd=<command-to-start-client-complete-with
  - vnc_client_action=execute|print

Must create way to have auto mode and manual mode with network design.
- Global property `network_design_mode=chyves|system`

Change 'offline' mode for dataset to rename the dataset to chyves_offline
- This will simplify management and reduce a lot of the overhead.

`chyves network import`
- Import network design layout from current configuration on the host.
- No guests - simple to import
- If there are guests
  - Find tap interfaces for guests

Function `__tap_owner`

Change the way to store tap devices under a bridge membership.
- Current limit is ~180 devices due to 1024 character limit
  - tap{n} to t{n}
  - vale{n} to v{n}

Create `lib/chyves-version`.
- Does _not_ need to maintain history.

Create `lib/chyves-get`.
- _Does_ need to maintain history.

Create `lib/chyves-verify`.
- _Does_ need to maintain history.

Commit code from `chyves-utils` for dataset upgrade to `lib/chyves-dataset`
- Move `__setup()` > `__dataset_sub_setup()`
  - _Does_ need to maintain history.
- Create
  - `__dataset_sub_promote`
  - `__dataset_sub_remove`
  - `__dataset_sub_upgrade`

Look into and test if setting the VNC `fbuf` on PCI slot 2 would work.
- Could do a more shared handling in `__start`

Fix issue with `chyves list <unknown-property>`
- probably an issue with "-"

Look into size always being 1.5x that of the guest drive.

Load libraries on demand?
- Like in `__parse_cmd`
- Intended to fix slowness
- Trace source of slowness

Globalize `_GUEST_name`
- Use at `__parse_cmd` to set
- `_GUEST_pool` not possible due to multi-guest, or at least another solution needs to be had.
  - Could even be part of `__load_guest_parameters` - Probably the best solution, do verification here.
- "all" points to variable set at start: "_ALL_GUEST_NAMES"
  - [ "$_guest" = "all" ] && $_GUEST_name="$( echo "$_ALL_GUEST_NAMES" | tr ' ' ','   )"
- This would handle this:
  - _Write `__bulk_verify` to be supplied a guest name and maybe a pool to run the necessary checks as a lot of that code a repeated over and over._

Create variables
- `_GUEST_NAMES_ALL` - All guest, no restrictions
- `_GUEST_NAMES_ACTIVE` - Active guest
- `_GUEST_NAMES_TEMPLATE` - Guests set in template mode
- `_GUEST_NAMES_OFFLINE` - Guests on offline pools
- Change `_FORBIDDEN_GUEST_NAMES` to `_GUEST_NAMES_FORBIDDEN`

Create `__validate_correct_name_format`
 - 31-4=27 character limit for name (create, clone, rename)
   - `"^[a-zA-Z0-9_.-]{1,27}$"`

Rework `__verify_valid_guest` to reference `_ALL_GUEST_NAMES`

Change `__get_corrected_byte_nomenclature` to be a little looser, allow for [a-zA-Z]{0,3} suffix for any potential and then only use the first letter.

`__are_guests_running()`
- `$1` is list of guests
- Otherwise all guests are checked.

Create restrictions in `__set` for:
- tap numbers +32768
- .config
   - restriction to: check_for_updates|console_start_offset|dev_mode|log_mode|restrict_new_property_names|tap_start_offset|tap_up_by_default|vlan_iface_base_name
   - redirection to __network for: bridge([0-9]{1,5})_phy_attach|bridge([0-9]{1,5})_tap_members
   - input verification for check_for_updates: daily|weekly|monthly|off

Move guest properties to `guests/bguest/.config`?

Add ability to set properties from `__create()`
- use `shift`
  - Figure a way to decide how far to shift, probably just a three layer descending `if` statement.

Write in code for `__cloneguest` to actually support a real clones.
- How to handle multiple datasets?
- "origin" ZFS property important
- `clone` and `clone_assc` properties to keep track of this
- Multi-disk support
- Flags
  - Rename `-r` to `-i` for independent
  - `-c` becomes proper clone
  - `-d` becomes duplicate

Add ability to use commas with guest names for (aka multi-guest support):
- <strike>`chyves create`</strike>
- <strike>`chyves set`</strike>
- <strike>`chyves clone`</strike>
- <strike>`chyves get`</strike>
- <strike>`chyves start`</strike>
- `chyves stop`
- `chyves destroy`
- <strike>`chyves delete`</strike>
- `chyves forcekill`

Console changes
- Add `conreset` for individual guests in addition to all.
   - Poll assigned guest con name
- Write `__reorder_consoles` function
 - Will reorder all the console numbers
 - All guests must be stopped
 - <strike>Settable offset to start at.</strike>
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

Write check in `/boot/loader.conf` for ppt devices. Should be fairly easy to implement.
- Maybe check `dmesg` instead?

Adapt `__verify_valid_guest` to `__verify_valid_dataset` and add flags to function.
- Or write something to check in `__resource_functions`

Change `__generate_grub_bhyve_command` to use the first disk OR property the `grub_boot_disk`

<strike>Add chyves.github.io</strike> Create webpage for chyves.org
- Create CNAME file
- https://github.com/t413/SinglePaged
  - What is it?
  - Preannouncement > Announcement
  - Demo
    - Use https://asciinema.org or https://showterm.io/
    - Use `tmux` and point out.
    - Simple demo
      - `chyves dataset demo-zpool setup`
      - `chyves network bridge0 attach bce1`
      - `chyves create guest1`
      - `chyves iso import freebsd.iso`
      - `chyves set cpu=2 guest1`
      - New tmux pane
      - `chyves console guest1`
      - `chyves start guest1`
    - Complex guests demo
      - `chyves dataset demo-zpool setup`
      - `chyves network bridge0 attach bce1`
      - `chyves create deb,cent,arch 8G demo-ssd`
      - `chyves iso import centos.iso`
      - `chyves iso import debian.iso`
      - `chyves iso import arch-linux.iso`
      - `chyves set cpu=2 deb,cent,arch ram=2048 loader=grub-bhyve deb os=debian centos os=centos7 arch os=arch`
      - create tmux 4x panes
      - `chyves console deb`
      - `chyves console cent`
      - `chyves console arch`
      - `chyves iso list`
      - `chyves start centos.iso`
      - `chyves start debian.iso`
      - `chyves start arch-linux.iso`
    - Complex network demo
      - `chyves dataset demo-zpool setup`
      - `chyves set tap_start_offset=1600 .config`
      - `chyves network bridge32 default`
      - `chyves network bridge32 attach bce1`
      - `chyves network bridge128 private`
      - `chyves create guest1`
      - `chyves network guest1 add`
      - `chyves network guest1 add`
      - `chyves list bridges`
      - `chyves list tap`
  - Download it
  - Thank you
  - About this page

Add handling for known haters of the network hardware offloaders.
- `bce` maybe `em`
- `chyves network <iface> disable tso`
- Property `network_disable_tso_auto` and `network_disable_tso_prompt`

Write "Request for help" page

#### Changes requiring meticulous testing:

##### Restructured command layout to have less sub-commands.
- `chyves scram` > `chyves stop all`
- `chyves disk` > `chyves list disks`
- `chyves list tap` > `chyves list net` ???

```
chyves $_guest create
               clone
               start
               stop [all]
               destroy
               rename
               delete
               set - This might get involved.
               get
               snapshot $DATE
                        <name>
                        rollback [<snap-name>]
                        list
               console [reset|tmux|vnc]
               disk add
                    remove
                    resize
```

```
chyves dataset [pool-name] setup                   Move remaining code from `__setup()`
                           promote                 Promote a dataset to primary role
                           remove                  Completely remove chyves from pool
                           upgrade                 Upgrade a dataset version
```

#### No interest to implement:

- `bridge{n}_phy_attach=nat{n}`
  - `.config` properties
    - `nat{n}_gateway_ip`=0.0.0.0/0
    - `nat{n}_dhcp`=enable|disabled
    - `nat_gateway_ip_offset`=0.0.0.0/0

<strike>FreeNAS verification out of setup and into a function.</strike>
- Will be used elsewhere to tell user to configure tunables
- Write code to `grep` FreeNAS config file and see if the tunables are actually set. (This would be another function)

#### Not looking like it is possible within Bourne:

Add `for` loop to reduce code for `zfs get`s in that start sequences and elsewhere
- Change to global variables with `_guest_$var` variables.
- Preliminary tests with `sh` do no work, `bash` does work.

Create a variable section of commonly used `grep` pipes to increase readability. Prefix `_GREP_action`.
- Do not think this is going to work. Preliminary tests did not work.

#### Considerations:

Logs?
- Dual console with one being logged on startup? <strike>Is that possible?</strike>
- `echo "blah blah" | tee -a log.txt`
- `__log "_lvl" "message"`
  - If -z $_GUEST_name then
    - echo -n "<time-stamp>" >> /chyves/Logs/YYYYMMDD-global_log
    - echo "Message to user" | tee > /chyves/Logs/YYYYMMDD-global_log
  - else
    - echo -n "<time-stamp>" >> /chyves/Logs/YYYYMMDD-global_log
    - echo "Message to user" | tee > /chyves/Logs/YYYYMMDD-global_log > /chyves/guests/$_GUEST_name/Logs/YYYYMMDD-global_log

```
stdout_level = level of output.
            0 off
            1 minimal
            2 regular
            3 verbose
            4 developer
log_to_file=yes|no
log_mode=host|guest|dual
/chyves/logs
/chyves/guests/$_GUEST_name/logs
```

<strike>Thoughts on using $1 as a guest name for action???</strike> Happening - Using two stage for __parse_cmd_main

#### General plan:
Added comments throughout the code to indicate what is going on.

Added more output to indicate to the end user what is happening in the script

Get redundant code into functions.
- _Doing the duty_

Use a standard nomenclature to denote internal use functions? See vm-bhyve for help.
- `__functions` - Start with two underscores
  - `__verb_future_variable_name` - Function called to set global variable.
- `_variables` - Start with one underscore
  - `_CAPS_ONLY_VARIABLES` - Variable with all capitalization are created in beginning of script.
  - `_CAP_mixed_variables` - Variable start with capitalization for first word and lower case for the remaining. Used for Global variables set later in script by called function.
  - `_only_lower` - Local variable

Normalize variables to a consistent verbose naming scheme.
- _On-going_.

Need help with:
- Spelling and grammar checking `man`, UI, and internal notes.
- Pre-release testers
- Fill in gaps in `CHANGELOG.MD`
- Feedback
- Creating ports
 - Find someone who can help with this.
 - chyves
   - Require / Optional
     - `tmux` "Used with `chyves console $guest -t` to create a console pane and rename it."
      - grub2-bhyve "Used to boot non-UEFI and non-bhyveload guests (Read: Non-FreeBSD guests)"
 -  chyves-devel
   - Require / Optional
     - tmux "Used with `chyves console $guest -t` to create a console pane and rename it."
      - `grub2`-bhyve "Used to boot non-UEFI and non-bhyveload guests (Read: Non-FreeBSD guests)"
      - `txt2man` "Used to rebuild man page file after edits. Use make buildman"
 -  chyves-util
   -  Require / Optional
     - `chyves`
     - `qemu` / Virtualbox "Used to convert ESXi guest disk images."
 - Verify AMD-Vi / IOMMU check method (svm?) Rewrite??

## Testing!!!

- Testing speed - Noticeably slower than iohyve

- Grab an object (variable or function) and follow it throughout the entire project and check it behaves the way it is designed for.
