#### Version 0.0.0 (2016 April 00)

Internal development.

`chyves` is the puralized, big endian alphabetic increment of `bhyve` but it most manages bhyve guests using ZFS, `nmdm`, `virtio`, `cu` and optionally `tmux` and `grub-bhyve`.

##### Changes made to fork from `iohyve`:

- Forked from `iohyve` at 0.7.5 "Tennessee Cherry Moonshine Edition" release at commit [2ff5b50](https://github.com/pr1ntf/iohyve/tree/2ff5b50d8cda61a8364bd79319152142ac1b4c33).

- Changed command from `iohyve` to `chyves`.

- Changes other internal references from `iohyve` to `chyves`. For example, the VMM names now reference `chy-$guest`.

##### General enhancement and bug fixes:

- Fixed various typos and expanded man page.
 - Added more explaination to the `chyves set` section for what each property influences.

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
 - This can be helpful in custom installations where more information is necessary.

- Consolidated `fetchiso`, `cpiso,` `renameiso`, and `rmiso` into one function/command: `chyves iso` with the use of arguments. For example `chyves fetchiso` is replaced by `chyves iso fetch` and so forth.
 - Added hash check function for fetched ISOs. Before the ISO is downloaded, the user is prompted for a hash. The following hashes are supported md5, sha1, sha256, and sha512. After the file is downloaded the file is hashed, if the hashes match then "Hashes matched" is displayed. If the hashes do not match, the user is prompted to delete the file.
 - Added support to download `.gz` compressed iso images.

- Consolidated  `fetchfw`, `cpfw`, `renamefw`, and `rmfw` into one function/command: `chyves firmware` with the use of arguments. For example `chyves fetchfw` is replaced by `chyves firmware fetch` and so forth.

- Deprecated the distinction of using `fetch` and `copy`|`cp` for ISO and Firmware resouces.
 - Both are handled by the same function of `fetch`.
   - A regular expression is used to determine if the source starts with `http` or `ftp` and uses `fetch` to download the file. Otherwise `cp` is used.

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

##### Developer enhancements:

- Added `make buildman` directive to `Makefile` in order to build man page file: `chyves.8`.

- Added `make clean` directive to `Makefile` in order to remove man page `.gz` file. Useful before using `git commit` when using the directory to install and develop from.
