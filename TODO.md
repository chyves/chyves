This early in the project, a road map is not defined. However these are ideas and some may happen but the idea is more likely to happen if interest is expressed:

`chyves update`
- Finish after repo becomes public.

Address issue with 88 character limit.
- Impacts snapshot rollback
- Importing ISO and firmware resources
  - Do a character count and then see if you can add a `$var` as the numeric portion of a regex.

Global: `prompt_on_destruction` = `yes|no`
- Prompt the user to confirm deletion of snapshots, guests, etc.
- This is to not hinder scripts that may run chyves

Finish dataset commands.

`chyves dataset <pool> offline`
- Can not be primary pool, ever.
- Check that `chyves_offline` does not already exists on pool.
- Rename the dataset to `chyves_offline`

`chyves dataset <pool> online`
- Check that `chyves` does not already exists on pool.
- Check that guests do not already exists with same name.

`chyves <guest> move <pool>`
- Move guest from one pool to another.
  - Use snapshots

`chyves <guest> reload`
- Reload a running guest to use new properties.

`chyves <guest> snapshot list`

Create guest groups:
- This would allow for a group of guests to be addressed easily.
- This would effectively be like custom keywords
- Easiest way probably would be to use ':' as a beginning delimiter for group based replacements
- Likely would need something like:
  - `chyves list groups`
  - `chyves <guest> group add <:group>`
  - `chyves <guest> group remove <:group>`
  - Special guest name 'rcboot'
- Clones add a layer of complication, similar to the networking bit.
- <strike>Store in global as `group_<name>`</strike> Want something more dynamic so that guests that find their way on the system do not need to be added.
  - Store as guest property `groups`
- Address bug when using `chyves all delete force`, basically clones are deleted and then referenced by the all. (Do top level guests only.)

`rc.d` script changes:
- Allow for `service chyves start|stop <guest>|MG|all`
- Fix output when not starting any guests.

`chyves guest log {n}|-f`
-show current month's log files.
  - -f to follow
  - {n} to show number of lines

`chyves network import` - Maybe?
- Import network design layout from current configuration on the host.
  - No guests - simple to import
  - If there are guests
    - Find tap interfaces for guests

`chyves debug`
- Pre-formatted for Github
- Prompts for guest and type of problem and then handling.

`chyves <guest> prompt` - Maybe?
- Dumps into "$guest> " prompt to execute command after command against guest.
- Escaping exits will be fun.

Write "Request for help" page

Finish/release `chyves-utils`.

`chyves info -H`
- For machine parsible.

#### Changes requiring meticulous testing:

#### Implement at a later time if interest is expressed:

- `bridge{n}_phy_attach=nat{n}`
  - `.config` properties
    - `nat{n}_gateway_ip`=0.0.0.0/0
    - `nat{n}_dhcp`=enable|disabled
    - `nat_gateway_ip_offset`=0.0.0.0/0

<strike>FreeNAS verification out of setup and into a function.</strike>
- Will be used elsewhere to tell user to configure tunables
- Write code to `grep` FreeNAS config file and see if the tunables are actually set. (This would be another function)
- Use API to set tunables: http://api.freenas.org/resources/system.html#tunable

Use non-ISO resources for optical media?
- Use `./`, `../`, or `/` as a trigger.

Add handling for network hardware offloaders?
- `bce` maybe `em`
- `chyves network <iface> disable tso`
- Property `network_disable_tso_auto` and `network_disable_tso_prompt`

#### Not looking like it is possible within Bourne:

Create a variable section of commonly used `grep` pipes to increase readability. Prefix `_GREP_action`.
- Do not think this is going to work. Preliminary tests did not work.

#### Considerations:

#### General plan:
Normalize variables to a consistent verbose naming scheme.
- _On-going_.

##### Need help with:
- Spelling and grammar checking `man`, UI, and internal notes.
- <strike>Pre-release testers</strike> Thanks Andrew and Chris!
- Fill in gaps for v0.0.0 `CHANGELOG.MD` - Still not completed.
- Feedback
- Reprioritize 'stdout_level' output.
- Testing edge cases with `network` sub-commands when 'auto' is set for 'network_design_mode'.
- Refining the following commands:
  - `chyves <guest>|MG|all console tmux`
  - `chyves network *`
- Creating ports - good for exposure but negated by `chyves upgrade`
 - Find someone who can help with this.
 - chyves
   - Require / Optional
     - `tmux` "Used with `chyves console $guest -t` to create a console pane and rename it."
      - grub2-bhyve "Used to boot non-UEFI and non-bhyveload guests (Read: Non-FreeBSD guests)"
 -  chyves-dev
   - Require / Optional
     - tmux "Used with `chyves console $guest -t` to create a console pane and rename it."
      - `grub2`-bhyve Used to boot non-UEFI and non-bhyveload guests (Read: Non-FreeBSD guests)"
      - `ronn` "Used to rebuild man page file after edits. Use `make docs`"
 -  chyves-util - Future
   -  Require / Optional
     - `chyves`
     - `qemu` / Virtualbox "Used to convert ESXi guest disk images."
- AMD tester.
  - Verify AMD-Vi / IOMMU check method (svm?) works. Possible rewrite??

## Testing!!!

- Test upgrading from version 0.0.1 and upgrading to current version (`chyves datatset <pool> upgrade` working correctly across multiple jumps?).

- Test a reverted guest with an ISO attached.
