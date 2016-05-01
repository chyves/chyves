#### Version 0.0.0 (2016 April 00)

Internal development.

`chyves` is the puralized, big endian alphabetic increment of `bhyve` but it most manages bhyve guests using ZFS, `nmdm`, `virtio`, `cu` and optionally `tmux` and `grub-bhyve`.

##### Changes made to fork from `iohyve`:

- Forked from `iohyve` at 0.7.5 "Tennessee Cherry Moonshine Edition" release at commit [2ff5b50](https://github.com/pr1ntf/iohyve/tree/2ff5b50d8cda61a8364bd79319152142ac1b4c33).

- Changed command from `iohyve` to `chyves`.

- Changes other internal references from `iohyve` to `chyves`. For example, the VMM names now reference `chy-$guest`.

##### General enhancement and bug fixes:

- Fixed various typos and expanded man page.
 - Added more explanation to the `chyves set` section for what each property influences.

- Updated `chyves help` for the new changes.
 - Added a nomenclature section to indicate what is required and what is optional.


- Created new document structure and folders.
 - The root directory of the project contains documents about the project and also the Makefile for installing from source
 - The installed files are now in their respective places `sbin/`, `rc.d/`, and `man/`.


- Created a new dataset to house all the guests under `$pool/chyves/guests/$guest`.
 - Changed code to correctly reference this new location, including `cut` commands.


- Created a new dataset for referencing the default values for new guests.
 - The ZFS properties contained in `$pool/chyves/guests/.defaults` replace the old hardcoded values.
 - Use `chyves set .defaults` to change from the initial values.


- Created the dataset `$pool/chyves/.config` with two ZFS user properties, `chyves:pool_version` and `chyves:dataset_role` as explained below.

 - The `chyves:pool_version` ZFS property within `$pool/chyves/.config` contains the chyves version the dataset is compatible with. This will be set upon dataset creation and then updated via [chyves-utils](https://github.com/chyves/chyves-utils) using the `chyves-upgrade` command, non-contiguous updates are possible. This will be the automated process of ensuring the dataset contains the necessary properties to run correctly. This will also make future dataset changes easier to implement. This feature will make the file `UPGRADING.md` a matter of reference. There is also a check ran before anything else to ensure the dataset is upgraded, even if the only change made to the dataset structure is an increment in the version. Setup is still able to run if multiple datasets exist. This setup use-case is if you want to migrate guests from one pool to another pool that is not currently setup, limited but possible.

 - The `chyves:dataset_role` ZFS property within `$pool/chyves/.config` contains which role the dataset is used for. The valid values are `primary`, `secondary`, and possibly `offline` in the future. The primary pool will always host the ISO and Firmware resources. The primary pool will also own the `mountpoint` "`/chyves`". All pool that are active and not the primary are considered `secondary`.

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


- Deprecated the distinction of using `fetch` and `cp` for ISO and Firmware resources.
  - Both are handled by the same function of `fetch`.
  - A regular expression is used to determine if the source starts with `http` or `ftp` and uses `fetch` to download the file. Otherwise `cp` is used.


- Consolidated `fetchiso`, `cpiso,` `renameiso`, and `rmiso` into one function/command: `chyves iso` with the use of arguments. For example `chyves fetchiso` is replaced by `chyves iso fetch` and so forth.
 - Added hash check function for remotely fetched ISOs.
   - Before the ISO is downloaded, the user is prompted for a hash. The following hashes are supported md5, sha1, sha256, and sha512.
   - After the file is downloaded the file is hashed, if the hashes match then "Hashes matched" is displayed. If the hashes do not match, the user is prompted to delete the file.
   - If no hash checksum is entered, the user is heckled into feeling bad about their life choices of supporting evil.
 - Added support to for `.gz` and `.xz` compressed iso images for both local and remote fetches.
   - These formats are commonly used for pfSense and FreeBSD releases respectively. Now saving bandwidth costs for the projects is even easier.


- Consolidated  `fetchfw`, `cpfw`, `renamefw`, and `rmfw` into one function/command: `chyves firmware` with the use of arguments. For example `chyves fetchfw` is replaced by `chyves firmware fetch` and so forth.


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

##### Internal code changes:


- Added function `__fault_detected_exit` function to standardized the way to exit with a message and why the exit was necessary.

- Added functions `__verify_valid_pool` and `__verify_valid_guest` functions to verify a pool and guest are valid and exit if not.

- Added function `__create_device_map` to create device map used in `__load`.

- Added function `__get_path_for_guest_dataset` to get the mount path of a guest.


- Added functions `__get_next_console` and `__get_next_tap` to return the next number for respective device.


- Added `__verify_kernel_module_loaded` function to verify, load `-l`, or unload `-u` kernels modules. Exits when no argument is given and the module is not loaded.

- Added variable `_KERNEL_MODULES` to keep track of modules to check for, load, or unload.

- Added `__verify_all_kernel_modules` function to check and load `-l` or unload `-u` kernel modules set in `_KERNEL_MODULES`.

- Added function `__resource_functions` to fetch, rename, delete, and list for Firmware and ISO resources. Also works compatiable with rename and delete for guests resources Potentially can be used for guest disk operations as well.
 - This deprecates the following functions: `__fetchiso`, `__cpiso`, `__renameiso`, `__deleteiso`, `__fetchfw`, `__cpfw`, `__renamefw`, and `__deletefw`.

- Added function `__verify_binary_available` to check if an executable is available on the system.

- Added function `__multi_chyves_zfs_property` to `get`|`set` `chyves:`` ZFS property. Works with `.config`, `.defaults`, and guests.

- Added function `__preflight_check` to run before any other code is to make sure the environment is safe for flight.
 - Added CPU feature check in this section.
   - The variable `_CPU_MISSING_UG` is set to "1" when the running on an Intel CPU that lacks the unrestricted guest `UG` feature is unavailable.
	 - chyves exits if the host does not have `POPCNT` feature which is known as Extended Page Table (EPT) on Intel CPUs or Rapid Virtualization Indexing (RVI) on AMD CPUs.

- Added function `__get_liar_cpu_value` to get CPU core count for guest but this function will lie if the `UG` CPU function is missing.

- Added function `__get_cpu_section_from_dmesg` to print out the CPU section from the `dmesg`. This is used in the `__preflight_check` to determine the CPU features.

- Added variable `_FORBIDDEN_GUEST_NAMES` to prevent guests with these names from being created.

- Added function `__check_if_freenas` to return nothing or "1" if on FreeNAS system.

- Added function `__display_rcboot_priority` to display a human friendly "NO" or "YES (boot-priority-number)" when called.

- Added function `__check_bhyve_process_running` to display a human friendly "NO" or "YES (bhyve-PID)" when called using the `-h` flag. If no flag is used then a "1" is returned.

- Added function `__check_vmm_alocated` to display a human friendly "NO" or "YES" when called using the `-h` flag. If no flag is used then a "1" is returned.

##### Developer enhancements:

- Added `make buildman` directive to `Makefile` in order to build man page file: `chyves.8`.

- Added `make clean` directive to `Makefile` in order to remove man page `.gz` file. Useful before using `git commit` when using the directory to install and develop from.

- Standardized whitespace
 - Using spaces for code examples in Markdown documents and the `man` page.
 - Using tabs is now the standard for scripts, this makes it easier to edit from a command line text editor. This is to prevent the internal conversation: "Is it two or three spaces after an `if` statement?". The answer is it is a tab every time.
