
#### Version 0.0.5 (2016 July 21)

Enhancements and fixes.

- Added e1000 emulation possibility for tap interfaces on 12-CURRENT hosts. [4039608](https://github.com/chyves/chyves/commit/4039608f4fdc6c693ebb965dda7f36e5f012f666)

- Added 'keepnet' keyword for `chyves <guest> delete keepnet`, which keeps network associations when deleting guests. [a787daf](https://github.com/chyves/chyves/commit/a787daf113da82733703af6ff2e0d87ae4e3240d)

- Added 'system' network design handling mode, draft quality. [2737704](https://github.com/chyves/chyves/commit/2737704ada836aa068d869e12fb2a6c2c78d50d7)

- Added `chyves dataset <pool> upgrade` as an upgrade mechanism. [31500b9](https://github.com/chyves/chyves/commit/31500b98ee15eb133ba134686d37a44ccb3dc7ff)

- Fixed edge case when cloning templates. [34c374b](https://github.com/chyves/chyves/commit/34c374b0f7ccb978bfcf66944f8366c9f46abc4f)

- Fixed typos and minor code cleanup, various commits.

- Fixed issue when setting bridge to private mode and physical/vlan interfaces were on bridge. Added function `__network_private` for expanded functionality. [3939444](https://github.com/chyves/chyves/commit/39394444ff50b2d977413973b9ca80c6f6184116)

- Added keyword 'all' for `chyves <guest> set <property>=<value>`, so now `chyves all set <property>=<value>` now works too. [9d0e05b](https://github.com/chyves/chyves/commit/9d0e05bb1682dd5bc9f82431ea2cd0c5310928c0)

#### Version 0.0.3 (2016 July 16)

@croquagei feedback fixes.

- Fixed issue when renaming ISO or firmware resources.[ed94890](https://github.com/chyves/chyves/commit/ed94890bed629bf70e835e9422177da38a3f4670)

- Fixed syntax in man page for starting guests. [1040c1b](https://github.com/chyves/chyves/commit/1040c1b2378e66d6699b622917f85ee82901d46b)

#### Version 0.0.1 (2016 July 11)

First private release. Shared with @croquagei for testing.

- Fixed minor issue with `__generate_bhyve_net_string`. [a41906e](https://github.com/chyves/chyves/commit/a41906ee8b9d04345c3cb70dcbf6d43a352cd067)

#### Version 0.0.0 (2016 April 16 through 2016 July 11)

Internal development.

`chyves` is the pluralized, big endian alphabetic increment of `bhyve`, it manages bhyve guests using ZFS, `nmdm`, `virtio`, `cu` and optionally `tmux` and `grub-bhyve` through the Bourne shell.

##### Changes made to fork from `iohyve`:

- Forked from `iohyve` at 0.7.5 "Tennessee Cherry Moonshine Edition" release at commit [2ff5b50](https://github.com/pr1ntf/iohyve/tree/2ff5b50d8cda61a8364bd79319152142ac1b4c33).

- Changed command from `iohyve` to `chyves`.

- Changed other internal references from `iohyve` to `chyves`. For example, the VMM names now reference `chy-$guest`.

##### General enhancement and bug fixes:

- Fixed various typos and expanded man page.
 - Created and expanded properties section. Bulk of section was moved from `set` section.

- Updated `chyves help`.
 - Added a nomenclature syntax map.


- Created new folder structure and project documents.
 - The root directory of the project contains documents about the project and also the Makefile for installing from source.
 - The installed files are now in their respective places `sbin/`, `rc.d/`, and `man/`.


- Created a new dataset to house all the guests under `$pool/chyves/guests/$guest`.
 - Changed code to correctly reference this new location, including `cut` commands.


- Created a new dataset for referencing the default values for new guests.
 - The ZFS properties contained in `$pool/chyves/guests/.defaults` replace the old hardcoded values.
 - Use `chyves set .defaults` to change from the initial values.


- Created the dataset `$pool/chyves/.config` with two ZFS user properties, `chyves:pool_version` and `chyves:dataset_role` as explained below.

 - The `chyves:dataset_version` ZFS property within `$pool/chyves/.config` contains the chyves dataset version the dataset is compatible with. This will be set upon dataset creation and then updated via chyves dataset <pool-name> upgrade`, non-contiguous updates are possible. This will be the automated process of ensuring the dataset contains the necessary properties to run correctly. This will also make future dataset changes easier to implement. This feature will make the file `UPGRADING.md` a matter of reference. There is also a check ran before anything else to ensure the dataset is upgraded, even if the only change made to the dataset structure is an increment in the version. Setup is still able to run if multiple datasets exist. This setup use-case is if you want to migrate guests from one pool to another pool that is not currently setup, limited but possible.

 - The `chyves:dataset_role` ZFS property within `$pool/chyves/.config` contains which role the dataset is used for. The valid values are `primary`, `secondary`, and `offline`. The primary pool will *always* host the ISO and Firmware resources. The primary pool will also own the `mountpoint` "`/chyves`". All pool that are active and not the primary are considered `secondary`.

 - Using `chyves list .config` will display the current properties for all the pools and using `chyves list .config [pool]` will list the properties for a single pool.

- Rewrote `chyves info` to use flags for verbosity. See `man chyves` for available flags or `chyves info -h`.

- Guests now use a specified UUID.
 - This is helpful for Windows guests to maintain licensing activation when moving guests from one host to another. However other use-cases exist.
 - A UUID is generated at guest creation by `/bin/uuidgen` and stored in the ZFS property chyves:uuid
 - Imported `iohyve` guests will have this number generated upon import with `chyves-import iohyve $guest` in `sysutils/chyves-utils`.

- Additional kernel modules are loaded with `chyves setup kmod=1` for networking taps and bridges.
 - Creation of bridges and taps would fail without these modules.

- Consolidated `list`, `isolist`, `fwlist`, `snaplist`, `taplist`, `activetaps`, and `conlist` into one function/command: `chyves list` with the use of arguments. For example `chyves isolist` is replaced by `chyves list iso` and so forth. Not to worry, `chyves list` still displays the traditional output.

- Expanded `chyves list <property name>` to display that property value for each guest.
 - This is dynamically determined so if a user manually sets a properties with `zfs` using a `chyves:` prefix this will display that property.
 - This can be helpful in installations where custom properties are set when more information is necessary.

 - Expanded `chyves list pools` to display pool and their roles.

 - Expanded `chyves list processes` to display all *hyve processes or just for one guest.

- Deprecated the distinction of using `fetch` and `cp` for ISO and Firmware resources.
  - Both are handled by the same function of `import`.
  - A regular expression is used to determine if the source starts with `http` or `ftp` and uses `fetch` to download the file. Otherwise `cp` is used.


- Consolidated `fetchiso`, `cpiso,` `renameiso`, and `rmiso` into one function/command: `chyves iso` with the use of arguments. For example `chyves fetchiso` is replaced by `chyves iso fetch` and so forth.
 - Added hash check function for remotely imported ISOs.
   - Before the ISO is downloaded, the user is prompted for a hash. The following hashes are supported md5, sha1, sha256, and sha512.
   - After the file is downloaded the file is hashed, if the hashes match then "Hashes matched" is displayed. If the hashes do not match, the user is prompted to delete the file.
   - If no hash checksum is entered, the user is heckled into feeling bad about their life choices of supporting evil.
 - Added support to for `.gz` and `.xz` compressed iso images for both local and remote imports.
   - These formats are commonly used for pfSense and FreeBSD releases respectively. Now saving bandwidth costs for the projects is even easier.


- Consolidated  `fetchfw`, `cpfw`, `renamefw`, and `rmfw` into one function/command: `chyves firmware` with the use of arguments. For example `chyves fetchfw` is replaced by `chyves firmware import` and so forth.


- Changed `get` command syntax to `chyves get [property] [name]`. This follows the syntax of `iocage`.

- Deprecated `chyves getall [name]` in favor of `chyves get all [name]`.

- Added version information to `help` output.

- Added `make deinstall` directives to `Makefile` for source installations. This removes all the installed files from the system.

- Added `make rcremove` directives to `Makefile` for source installations. This removes the configuration contained in the `/etc/rc.conf` file using the `sysrc` command.

- Added checks to verify pool name and guest name when supplied from command line.
 - An error message is displayed and exits when an invalid name is used.

- Added dependencies section to `USAGE.md` to clarify the components being used in `chyves`.

- Added check that the necessary kernel modules are loaded or built-in before starting a guest.

- Deprecated properties `chyves:name` and `chyves:size`

- Added check when starting guest to see if  `grub2-bhyve` is installed for guests using the `grub-bhyve` loader property value.

- Added prompt when using the `chyves forcekill $guest` command and also displays processes that will be killed.

- Added check to see if CPU has the necessary features to run `bhyve`. This includes `POPCNT` for AMD and Intel CPUs. Intel CPUs also require the unrestricted guest `UG` feature for allocating more than one virtual CPU to a guest and also `UG` is required for UEFI support. These restrictions are enforced by `chyves` so that error messages do not spew across the screen.

- Boot priority can now be set for guests. Guests with the highest boot priority are booted first. This is set by assigning a positive integer to the "boot" property. Zero still indicates to not start the guest on host boot.

- `chyves list` and `chyves info -s` now shows the boot priority of each guest and the bhyve PID if the guest is running.

- Changed syntax for `chyves set`, the correct syntax is now `chyves set property1=value guest-name`
  - The ability to set multiple properties is still available and the syntax is: `chyves set property1=value guest-name property2=value property3=value property4=value`

- Added the ability for multi-set guest support. This allows you set properties for multiple guests in one go.
  - For example: `chyves set cpu=2 debian ram=4G windows cpu=4 ram=12G fw=BHYVE_UEFI_20151002.fd loader=uefi centos os=centos7`
    - For guest: `debian` the CPU is set to "2" and RAM to "4G"
    - For guest: `windows` the CPU is set to "4", RAM to "12G", firmware to "BHYVE_UEFI_20151002.fd", and loader to `UEFI`.
    - For guest: `centos` the OS is set to "centos7"

- Removed the ability to create additional guest disks on a different pool. This functionality was never implemented, impractical, is dangerous to leave. See [commit  85274ad](https://github.com/chyves/chyves/commit/85274adddd94d1280a658920101278720391ecdc) for removed code.

- Created guest property `creation` to contain the creation date and origin. This replaces the text that used to be populated in `description` on guest.

- Added `chyves list .defaults` to display guest defaults for newly created guests.

- `null.iso` is created and imported as an ISO resource with `chyves setup <pool>` on the primary pool. `chyves` references this file when an ISO resource is not specified for `chyves start` on UEFI guests.

- Added multi-guest support for some sub-functions. Multi-guest support is the ability to specify multiple guests in one command. This includes `clone`, `get`, `set`

- Deprecated `kmod` and `net` from `setup` command. These have been replaced by an auto loader/checker for kernel modules and there is now the `chyves network` for network related tasks.
 
- Deprecated `persist` property.

- Guests now reboot properly and all other `bhyve` exit codes destroy the VMM.

##### Internal code changes:


- Added function `__fault_detected_exit` function to standardized the way to exit with a message and why the exit was necessary.

- Added functions `__verify_valid_pool` and `__verify_valid_guest` functions to verify a pool and guest are valid and exit if not.

- Added function `__generate_generic_device_map` to create device map used in `__load`.

- Added function `__get_path_for_guest_dataset` to get the mount path of a guest.


- Added functions `__get_next_console` and `__get_next_tap` to set the global variables `_NEXT_tap` and `_NEXT_console` with the respective next unused device.

- Added `__verify_kernel_module_loaded` function to verify, load `-l`, or unload `-u` kernels modules. Exits when no argument is given and the module is not loaded.

- Added variable `_KERNEL_MODULES` to keep track of modules to check for, load, or unload.

- Added `__verify_all_kernel_modules` function to check and load `-l` or unload `-u` kernel modules set in `_KERNEL_MODULES`.

- Added function `__resource_functions` to fetch, rename, delete, and list for Firmware and ISO resources. Also works compatiable with rename and delete for guests resources Potentially can be used for guest disk operations as well.
 - This deprecates the following functions: `__fetchiso`, `__cpiso`, `__renameiso`, `__deleteiso`, `__fetchfw`, `__cpfw`, `__renamefw`, and `__deletefw`.

- Added function `__verify_binary_available` to check if an executable is available on the system.

- Added function `__multi_chyves_zfs_property` to get or set `chyves:` ZFS properties. Works with `.config`, `.defaults`, and guests.
   - `__multi_chyves_zfs_property get` will return the value of "1" for the CPU core count when the `UG` CPU feature is missing on Intel CPUs to be compliant.
   - `__multi_chyves_zfs_property set` will only set a value of "16" when a greater number is attempted to be set for the "cpu" guest property. This is to be compliant with `bhyve`'s limits.

- Names longer than 31 characters are truncated to be compliant with `bhyve`'s limits as the name is used as the unique identifier.

- Added function `__preflight_check` to run before any other code is to make sure the environment is safe for flight.
 - Added CPU feature check in this section.
   - The variable `_CPU_MISSING_UG` is set to "1" when the running on an Intel CPU that lacks the unrestricted guest `UG` feature is unavailable.
   - chyves exits if the host does not have `POPCNT` feature which is known as Extended Page Table (EPT) on Intel CPUs or Rapid Virtualization Indexing (RVI) on AMD CPUs.
   - `chyves` will only start guests with the `loader` set as `bhyveload` as further restriction when the CPU lacks `UG`.

- Added function `__get_cpu_section_from_dmesg` to print out the CPU section from the `dmesg`. This is used in the `__preflight_check` to determine the CPU features.

- Added variable `_FORBIDDEN_GUEST_NAMES` to prevent guests with these names from being created.

- Added function `__check_if_freenas` to return nothing or "1" if on FreeNAS system.

- Added function `__display_rcboot_priority` to display a human friendly "NO" or "YES ($boot-priority-number)" when called.

- Added function `__check_bhyve_process_running` to display a human friendly "NO" or "YES ($bhyve-PID)" when called using the `-h` flag. If no flag is used then the bhyve PID is returned.

- Added function `__check_vmm_alocated` to display a human friendly "NO" or "YES" when called using the `-h` flag. If no flag is used then a "1" is returned.

- Added function `__verify_number_of_arguments` to check the number of parameters and exits if not met or if exceeded.

- Changed parameters to be function indexed rather than script indexed.
  - This limits the number of addressable parameters to nine due to the Bourne shell, which does not matter.
  - `chyves set` is the one exception, it is still script indexed.

- Added variable `_PRIMARY_POOL` to global variables instead of polling `__get_primary_pool_name` more than once.

- Deprecated commands `chyves boot` and `chyves load` from users. These functions can still be called from developer mode.

- Added variable `_RESTRICT_NEW_PROPERTY_NAMES` to control whether `__multi_chyves_zfs_property` can create new property names.

- Added variable `_NUMBER_OF_ALL_GUESTS` to count number of guests. All guests are in the count and this is specifically used to set the properties for the first guest when `_RESTRICT_NEW_PROPERTY_NAMES` is set to "on".

- Added function `__load_guest_parameters` to load a guest's parameters into global variables.

- Added function `__load_guest_default_parameters` to load guest defaults into global variables.

- Deprecated the of using underscores for storing `bargs`.

- <strike>Added variable `_NUMBER_OF_ACTIVE_POOLS`. Currently used in `__set` when setting properties for `.config`. When only one active pool is on the system, then the multiple `.config` property can be set, otherwise the [pool] field must be used and only property can be set at a time.</strike> Deprecated.
 
- Added variables `_VERSION_BRANCH`, `_PROJECT_URL`, and `_PROJECT_URL_GIT` to keep track of aspect for use in `__check_for_chyves_update`.

- Added variables `_OS`, `_OS_VERSION_DATE`, `_OS_VERSION_FREENAS`, `_OS_VERSION_REL`, and `_OS_VERSION_REV` to keep track of aspects of the host system OS.

- Added variable `_DATE_YMD` to store date information for general reference in YYYYMMDD format.

- Added function `__check_for_chyves_update` to check GitHub for latest version.

- Added properties and variables `_CHECK_FOR_UPDATES`, `_CHECK_FOR_UPDATES_TIMEOUT_SECONDS`, `_CHECK_FOR_UPDATES_LAST_CHECK`, `_CHECK_FOR_UPDATES_LAST_CHECK_STATUS`, `_CHECK_FOR_UPDATES_UNIQUE_ID`, and `_CHECK_FOR_UPDATES_URL` for use by `__check_for_chyves_update`.

- <Out of order> Added function `__convert_list_to_grep_string` to have a raw list of anything be converted to a `grep`-able string. $2 is used to append an existing `grep`-able list to what is converted.

- Added variable `_FREEBSD_NET_DRIVERS_GREP_STRING` to keep a string of valid FreeBSD network drivers (names of interfaces effectively) for use in the networking methods.

- Added variable `_VLAN_IFACE_BASE_NAME` to keep track of the base name used on system for vlan interfaces. Typically vlan0, vlan1, vlan2 is the standard naming nomenclature but specifying “clone_interfaces” in /etc/rc.conf you can deviate from this standard.

- Added property and variable `_TAP_UP_BY_DEFAULT` to keep track of whether or not to set `tap` interfaces to up using the `sysctl`. If set to "yes", then an `if` statement in `__preflight_check` loads the `if_tap` kernel module and then sets the `sysctl`.

- <Out of order> Added `.defaults` property `bridge` and variable `_GDP_bridge` to keep track of the default bridge to assign tap interfaces to.

- <Out of order> Created `.default` properties and variables to contain ZFS specific parameters for new ZFS volumes aka (disks) for guests.
  - Assume you have some experience with ZFS and assumes you know what you are doing. 
  - Properties: `disk_volmode`, `disk_volblocksize`, `disk_dedup`, `disk_compression`, `disk_primarycache`, and `disk_secondarycache`

- Added function `__generate_zvol_disk_options_string` to generate the ZFS string used create ZFS volumes (disks) for guests.

- Added function `__get_guest_name_by_pid` and variable `_GUEST_name_by_pid` to get the name of a guest but the process ID. This is currently used when a `tap` interface is locked by a process and descriptive user output is needed including the guest name that is causing the issue.

- Added function `__generate_bhyve_net_string` to dynamically generate bhyve PCI string (Eg. -s 7,virtio-net,tap{n}) for each network device. VALE devices supported (Eg. -s 7,virtio-net,vale{n}).

- Added function `__get_pool_for_guest` to verify and then set "_GUEST_pool" for supplied guest.

- Added function `__get_corrected_byte_nomenclature` to verify user input, pull the size denomination, use only the first letter, and captilize that letter. Then if the number is evenly divisible by 1024, it increaeses the size denomination.

- Added function `__get_next_vnc_port` to generate next unused VNC port, then assigns variable `_NEXT_vnc_port`.

- Added guests properties `uefi_console_output`, `uefi_mouse_type`, `uefi_vnc_ip`, `uefi_vnc_port`,  `uefi_vnc_res`, and `uefi_pause_until_vnc_client_connect` for use with UEFI guests using VNC consoles.

- Added global property `uefi_vnc_port_start_offset` to indicate when first starting port for VNC. The default is 5900.

- Added function `__verify_iommu_capable` to check if IO MMU is enabled on the system. This is more commonly known as VT-d or AMD-Vi.

- Renamed property `tap` to `net_ifaces`

- Deprecated function `__exportguest` because this functionality will be part of `chyves-utils`. Also it did not export proper UCL format.

- Added global property `auto_load_kernel_mods` to determine whether or not to load the kernel modules when starting guests, otherwise there is a check and exiting error if not loaded. Default is "yes".

- Added global property `consolidate_bhyve_pci_devices` to determine whether or not to use PCI functions for similar devices in bhyve string generation. This is needed when more than 26 PCI devices are going to be connected to a guest.

- Started using library files to break up the code for managability and also for use by other chyves projects.
  - chyves-start-guest
  - chyves-properties
  - chyves-updates
  - chyves-informational
  - chyves-basics
  - chyves-network

- Renamed function `__load` to `__generate_grub_bhyve_command` and rewritten
 - Now only handles grub-bhyve guests, no more bhyveload.
 - Assigns global variable $_LOADER_cmd for the grub-bhyve command to use. This allows for use in a small while loop later on to be use to make sure guests reboot correctly.
 - Deprecated `install` property. If optical media is used from the command line, it is assumed to boot from that the optical media.

- Complete rewrite of `__start`. See here for commit message 595bb84.

- Added function `__generate_bhyve_slot_string` see commit af0d3b3. Sort of replace `__get_bhyve_cmd` but not really.

- Added function `__generate_bhyve_custom_pci_string` see commit 0beb1dd. This creates PCI devices for bhyve from the `pcidev` properties and then feeds to information to `__generate_bhyve_slot_string`. There is special handling for pass through devices.

- Added function `__generate_bhyve_disk_string` see commit 5acfa78. This creates PCI devices for bhyve for each disk and then feeds to information to `__generate_bhyve_slot_string`. 

- Added function `__generate_bhyve_vnc_string` to generate a PCI string for the frame buffer used for the VNC connection for UEFI guests using VNC console output.

- Deprecated function `_get_bhyve_cmd` replaced by `__generate_bhyve_slot_string`.

- Deprecated function `__get_zfs_pcidev_conf` replaced by `__generate_bhyve_custom_pci_string`.

- Deprecated function `__prepare_guest` by several other functions. See commit 8da6b6d.

- Deprecated functions `__boot`, `__install`, and `__uefi` by completely rewritten `__start`.

- Massive expansion of network handling. See `lib/chyves-network` for functions. See initial commit 89d8bba.

##### Developer enhancements:

- Created the DEVELOPMENT.md document to give code examples, guidance, terminology, and general best practice when submitting PRs. This is to maintain a certain

- Added `make docs` directive to `Makefile` in order to build man page file `chyves.8` and 'chyves.8.html` file using the Ruby tool `[ronn](https://github.com/rtomayko/ronn)` from the `chyves.8.ronn` file.

- Added `make clean` directive to `Makefile` in order to remove man page `.gz` file. Useful before using `git commit` when using the directory to install and develop from.

- Standardized whitespace
 - Using spaces for code examples in Markdown documents and the `man` page.
 - Using tabs is now the standard for scripts, this makes it easier to edit from a command line text editor. This is to prevent the internal conversation: "Is it two or three spaces after an `if` statement?". The answer is it is a tab every time.

- Added "DEVELOPER MODE" changing the value of property "dev_mode" from "off" to either [on|-xvn] actives these features:
  - Display the full `bhyve` command used to start the guests just before executing the same command. This is done in `__boot`, `__start_` and `__uefi`.
  - Allow functions and commands to be called straight from the command line with `chyves dev`. Examples of how this would be used:
    - `chyves dev __version` executes the `__version()` function.
    - `chyves dev __list tap active`
    - `chyves dev "echo $That_tricksy_hobbit_variable"`
  - Using the [`-xvn`] flag(s) instead of the word "on" use the Bourne shell special operation flags. The `-x` shows each ling before it executes. The `-v` flag shows each line as it executes. The `-n` flag reads and populates the variables but does not execute the commands.


< Last commit documented on this page: 778172b - DOC: Moar added, lot of big ticket items completed.>
