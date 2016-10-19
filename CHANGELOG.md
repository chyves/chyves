#### Version 0.2.3-dev (2016 October 19)

- DOC: FIX: Typo in example for Arch guest.  [f4a3c32](https://github.com/chyves/chyves/commit/f4a3c32090a1c9a7e04b79a52f1d8c24f1fd32d1)

- DOC: FIX: Remove disclaimer when installing Debian 8.3+ from docs as this is no longer valid.  [a71973c](https://github.com/chyves/chyves/commit/a71973cc5e6be17e098f0343709acb453acdabec)

- DOC: Added clarity in example when deleting clones. [0d018fc](https://github.com/chyves/chyves/commit/0d018fca378da6016ae3a06e3d0289bad0517901)

- DOC: FIX: Reference to old sub-command (`chyves bguest install`). [1679a38](https://github.com/chyves/chyves/commit/1679a382ae009ecd8a592eb9d3fc605e3f630384)

- FIX: Reference to old variable broke `os=custom`. [c0c6486](https://github.com/chyves/chyves/commit/c0c6486394a9e3fc4da141fa0ffe6b509229f8a9)

#### Version 0.2.2-dev (2016 October 1)

- Less restriction when checking for '-S' in `bargs` while setting wired memory variable. [8107ad9](https://github.com/chyves/chyves/commit/8107ad9abbd479ba523ff4dd50cbe2c052de47fc)

- The `chyves unset` command allows unsetting `eject_iso_on_n_reboot`, `pcidev_{n}`, and `virtio_block_options_disk{n}` but the error message indicated that only `pcidev_{n}` was allow when attempting an unsupport property.  [af512ee](https://github.com/chyves/chyves/commit/af512eebbfd0f3a4eb7b4e9733d75598695ce8ed)

- Many minor fixes in the man page.
  - Clarified a value of '0' means off for `eject_iso_on_n_reboot`. [fe746fd](https://github.com/chyves/chyves/commit/fe746fd0efce81788e4f15a1e4532987623565b8)
  - Typo in `eject_iso_on_n_reboot` guest property. [5187ccf](https://github.com/chyves/chyves/commit/5187ccfc15b8f1d1006ef8cf8fb0d29951bf9e43)
  - Document that `check_for_updates` can be set to 'off'.  [c52ec05](https://github.com/chyves/chyves/commit/c52ec05a17fad0025aaeaa3d42094a9abf6b2788)
  - Typo in `bridge{n}_tap_members` example. [5894336](https://github.com/chyves/chyves/commit/589433607d8be13d5d1305336792a22c44516b96)
  - Removed ending period on command example.  [89d9f5b](https://github.com/chyves/chyves/commit/89d9f5b3fe6e5dabcab8d284d1b23365219a107d)
  - Removed reference to `chyves dataset <pool> promote` until written/committed. [f676648](https://github.com/chyves/chyves/commit/f6766488aa3a8045459392d7a40ff400168e30ee)

- FIX: Corrected function name to delete ISO resource when an incorrect hash value is given. Previously was referencing old function and syntax. [9ec89db](https://github.com/chyves/chyves/commit/9ec89db774aa7ae906f132141574cc4aac77cd2c)

- FIX: Typo in variable for dataset verification in `__resource_delete()`. [238b478](https://github.com/chyves/chyves/commit/238b478ed9af84faa16f7b9a6571c230e972e529)

- Guest properties are reloaded at each `chyves_guest_version` increment during a `chyves <guest> upgrade`. This has no impact for past changes, however if there is a future property change which relies on the value of a property and that value is changed more than once, then it is possible to have a dirty state. This is intended to mitigate that possibility. [8ed90ca](https://github.com/chyves/chyves/commit/8ed90cad3073e953f8e972bc5ec024396f7fe063)

#### Version 0.2.1-dev (2016 September 25)

- FIX: Improved handling for guests started with `rc.conf`. [9cf54d9](https://github.com/chyves/chyves/commit/9cf54d9353317589199f2369a685a98b96669c31)

- ENH: Reworked `__generate_grub_bhyve_command()` for efficiency. [541a0dd](https://github.com/chyves/chyves/commit/541a0dd73be340f1b34279e257167bd8857c7ecf)

- Consolidated `grub-bhyve` support for OpenBSD to reference installation media name for version number. [1827aae](https://github.com/chyves/chyves/commit/1827aaed39e16b1d09f08108a6b274e1f2bcbe8c)
  - This assumes OpenBSD continues to use same naming scheme for their ISOs and that the kernel continues to be located on the installation media at '`/X.Y/amd64/bsd.rd`' where 'X' is the single digit major version number and 'Y' is the single digit minor number.
  - After installation all guests use the same handling method to start the guest with `grub-bhyve`.

- Added [VyOS](http://vyos.net) support for `grub-bhyve`. [85bf9bc](https://github.com/chyves/chyves/commit/85bf9bced9240920a6d4e780a70064c870d4228b)

- Added sound support utilizing code from [Google Summer of Code 2016 project by Alex Teaca](https://wiki.freebsd.org/SummerOfCode2016/HDAudioEmulationForBhyve). [e4f9b45](https://github.com/chyves/chyves/commit/e4f9b4582ed18d59218702857cef59c6847e5bef)
  - Two additional commits to fixed typo. [57d00cb](https://github.com/chyves/chyves/commit/57d00cb899d0f964e81691eb6188d628a2983eb0) and [270fe77](https://github.com/chyves/chyves/commit/270fe7782bdcffd1b80659a22ca7716d99c678ed)
  - This requires that the `bhyve` binary has been patched. Currently there is no check that can be ran on the host to verify audio support. This is a new `bhyve` feature and will have some sharp edges.
  - Please report results (success and failures) to [Alex Teaca](https://docs.freebsd.org/cgi/getmsg.cgi?fetch=30255+0+archive/2016/freebsd-virtualization/20160911.freebsd-virtualization). He has called for testing.

#### Version 0.1.9-dev (2016 September 10)

Minor features added.

- DOC: Minor changes to README.md [855a208](https://github.com/chyves/chyves/commit/855a2081b603c3b3c8e9cef0e3b411b6287afd8b)

- DOC: Minor change to code comments in `__start`. [fd9b0c1](https://github.com/chyves/chyves/commit/fd9b0c1ae43b90f9f0d4a391d9dac5b2e88f0712)

- ENH: Add property 'bhyve_disk_type' to control disk attachment method between `virtio-blk` and `ahci-hd`. [e7266ea](https://github.com/chyves/chyves/commit/e7266eae6fa5200893031b7428fd16ad9206cfa1)
  - Increments `chyves_guest_version` to 0300.
  - Merged with `dataset_version` to 0005 changes.

- ENH: Ability to include additional `bhyveload` flags when starting FreeBSD guests. [587eaae](https://github.com/chyves/chyves/commit/587eaae3b0ee6dc3186ceab8ced0fd1bfac719fa)
  - This was added after reading [an article](http://callfortesting.org/bhyve-boot-environments/) by @michaeldexter.
  - Increments `chyves_guest_version` to 0202.
  - Increments `dataset_version` to 0005.

- FIX: Reworked `_FREEBSD_NET_DRIVERS_GREP_STRING` string again to remove wireless devices and add a few missing drivers. [c582b59](https://github.com/chyves/chyves/commit/c582b59252ae35a7707aa88b0cb225e0a4f8a2e3)

- DOC: Fixed language for Intel e1000 emulation in man page as it was still referencing 12-CURRENT as being required. [7886c65](https://github.com/chyves/chyves/commit/7886c65c1195c416e909437b6876495b996c9507)

- ENH: Added ability to attach 32 disks to a single AHCI controller per PCI slot on FreeBSD 10 and 11 due to MFCs. [](https://github.com/chyves/chyves/commit/6f607f2921afd24059f69286f7ec0fd0a748de9a)
  - Originally committed to 12-CURRENT at [r302459](https://secure.freshbsd.org/commit/freebsd/r302459)
  - MFCed to 11-STABLE at [r304422](https://secure.freshbsd.org/commit/freebsd/r304422)
  - MFCed to 10-STABLE at [r304420](https://secure.freshbsd.org/commit/freebsd/r304420)

#### Version 0.1.8-dev (2016 September 9)

Hot fixes

- FIX: Typo from commit b8d6ed0 - FIX: Add parameter number check for 'chyves dev'. [05e9d30](https://github.com/chyves/chyves/commit/05e9d30d24c4f46e366938c2cc98a97bc6b7fe91)

- Missed commit - Version increment to v0.1.7-dev for recent changes. [00ec843](https://github.com/chyves/chyves/commit/00ec8435db5ae05ffc53c2dd63bacd2b17080066)

#### Version 0.1.7-dev (2016 September 8)

Thanks to @invisnet for adding `lagg` to physical interfaces and the suggestion to correctly handle MTU on bridges.

- Merged in fix from @invisnet to add `lagg` to physical interfaces. [28f05f3](https://github.com/chyves/chyves/commit/28f05f318bbb6795bc0f4896ef3197649b75c240)

- FIX: Add parameter number check for `chyves dev`. [b8d6ed0](https://github.com/chyves/chyves/commit/b8d6ed06666ae9d7bd8f6a8675e04ac7c0c8a32b)

- FIX: Added handling of MTU for network bridges. [536dd8b](https://github.com/chyves/chyves/commit/536dd8b9a017942798d9d2f045c720dddf0371ac)

- FIX: Update reference to old variable name in `__generate_bhyve_net_string`.  [10648b6](https://github.com/chyves/chyves/commit/10648b626f2b842d153b91e914ee57e4be482008)

#### Version 0.1.6-dev (2016 September 5)

- FIX: Issue when rebooting guest's using `revert_to_snapshot` or `eject_iso_on_n_reboot`. [2e11c22](https://github.com/chyves/chyves/commit/2e11c22f420a10accf9736eec13a0e8723179d4b)

- ENH: Indicate default bridge for `chyves list bridges`. [4b67678](https://github.com/chyves/chyves/commit/4b67678dee68155c3b6eff22c2b05f02c685fc2d)

- FIX: Issue where `eject_iso_on_n_reboot`=0 would eject before first start. [d5ba410](https://github.com/chyves/chyves/commit/d5ba4106d9884f2e9c11191f8a63ea26a46ee043)

- FIX: Issue when deleting guest when `network_design_mode` is set to 'system'.[6a546c9](https://github.com/chyves/chyves/commit/6a546c95eea5419f557b3988d7371b83a6734676)

- FIX: Add ability to change `net_ifaces` when network design mode is set to 'system'. [8c709e4](https://github.com/chyves/chyves/commit/8c709e45aaa2136828071e5faef7828a29186b22)

- DOC: Changed log comments for number of reboots. [db6a6ba](https://github.com/chyves/chyves/commit/db6a6ba8763f754eb7a527344c513420f7f950db)

- Moved clone handling in `__parse_cmd_ingress` [29d1fd1](https://github.com/chyves/chyves/commit/29d1fd15d50b4004f16634c5adf4b2892ee8c1a5)
  - In the future, clone a guest will be able to be specified and this is the first step by removing it from the `case` switch.

- Enhancements and fixes for `chyves info`.
  - Added '`-w`' flag to truncate output to terminal width. [e4f651d](https://github.com/chyves/chyves/commit/e4f651d7e1179c03ef5b569d4a3fee36f040247e)
  - Added '`-u`' flag to display UEFI properties. The UEFI console output type, firmware, VNC IP and port, mouse type, pause boot until VNC connect, and VNC resolution are displayed. [a4a24ce](https://github.com/chyves/chyves/commit/a4a24ce986ebc48bd254056db673b7762e1ede25)
  - Updated code comments and minor fixes. [095c8cb](https://github.com/chyves/chyves/commit/095c8cb24eb479a9906cf2d44adb371c79dee58f)

- Fixed issues with `chyves <guest> console vnc` not working due to inverse matches. [7924a5e](https://github.com/chyves/chyves/commit/7924a5e39834e1be14e0774242af4a55ee296ff8)

#### Version 0.1.5-dev (2016 September 2)

- Increment CGV to 0201. [e9e4d0a](https://github.com/chyves/chyves/commit/e9e4d0a93737d11ce33a816d889732dac1fda07d)
  - Incremented so v0.1.1 and earlier do not try to start guests, specifically ones that have the '`os`' property set to 'coreos' or 'openbsd60'.

- Minor changes to documents. [1464736](https://github.com/chyves/chyves/commit/146473651c34c28546ab79ea6ae4a20b4068d868), [1a3b287](https://github.com/chyves/chyves/commit/1a3b28795eda834ea213667ebfa301c23ce5b1a2), [7d3043a](https://github.com/chyves/chyves/commit/7d3043ab518dfb89d6ecc9ea49694a516ea7c88b), [3aad0d6](https://github.com/chyves/chyves/commit/3aad0d64caf5e246b672d12a141727d5da21c979), and [756cd7a](https://github.com/chyves/chyves/commit/756cd7a89707ca43c87b0bc9d23b036a87dcfb0a).

- Added check in guest rename to see if guest is running. The dataset needs to be renamed and the zvol can not be in use. [b32d92e](https://github.com/chyves/chyves/commit/b32d92e7facb6582b0965f1c5e923858992fee22)

- Fixed issue with `chyves upgrade` where it would perpetually claim it was out of date. [aa317d2](https://github.com/chyves/chyves/commit/aa317d2453c81c245f6659b352ef82893b113fc5)

- Completed Intel e1000 NIC emulation attachment. [d356178](https://github.com/chyves/chyves/commit/d356178a64fc0c364634d12ab160f156c294879a)

- Changed version nomenclature to 9 major versions rather than 999. [116b1b5](https://github.com/chyves/chyves/commit/116b1b55a0ef677296af693dedbd606748253600)

- Fixed reference to old variable name in `__generate_grub_bhyve_command`. [082b570](https://github.com/chyves/chyves/commit/082b570ade713c49a43182794b724f4ca184ab1a)

- Removed references to stop and start VM to remove optical media from VM in man page examples. [0b3691f](https://github.com/chyves/chyves/commit/0b3691f132f0c064d783fdc2da489707ee1fa997)

- Add CoreOS as a `grub-bhyve` preconfigured OS. [562f9c5](https://github.com/chyves/chyves/commit/562f9c5e8b887824dc51510f3e426c44709091de)
  - Thanks to @olgeni for [his PR to vm-bhyve](https://github.com/churchers/vm-bhyve/pull/112).

#### Version 0.1.4-dev (2016 August 28)

Thanks to @3add3287 for rcboot fix.

- Fixes an issue with rcboot when only one guest exists on system. [6a7c8a2](https://github.com/chyves/chyves/commit/6a7c8a2c5522076d1b481161ff0ccb7c2a547561)

#### Version 0.1.3-dev (2016 August 27)

Fixes various issues. Minor enhancements.

- FIX: Typos in previous CHANGELOG.md entry. [a6807ac](https://github.com/chyves/chyves/commit/a6807acdf19627bd463a5d3afdedf7adb213cc70)

- ENH: Give host version information for `chyves version`. [96c6c08](https://github.com/chyves/chyves/commit/96c6c08aa98861a592d6f0c7a9e264660db094f9)

- FIX: Do not run check for new chyves version when not installed yet. [87c081f](https://github.com/chyves/chyves/commit/87c081f4f1ad3bc8ba7670d95916a71b609937c6)

- FIX: Create new 'uefi_vnc_port' when cloning guest with unique properties. [94e21f0](https://github.com/chyves/chyves/commit/94e21f03ba9be0ea36bbfadea24d6f190cf8ade7)

- FIX: Error when displaying `$_NEXT_serial` in `__clone_guest`. [1b4e619](https://github.com/chyves/chyves/commit/1b4e619805fe38f9fe18c333c71afe92bd8d5dbf)

- FIX: Reference to old variable names in `__generate_grub_bhyve_command`. [3ffa905](https://github.com/chyves/chyves/commit/3ffa905d343ef8c0d61bc74b48fdde43534af2d3)

- ENH: Allow Intel e1000 emulation on non-12-CURRENT hosts due to recent MFCs. [b8260e2](https://github.com/chyves/chyves/commit/b8260e2453821d9124576e55ecc0bcf1a934aa85)

- FIX: Setting COMPILER_TYPE on FreeNAS required for `make install` in `Makefile`. [a3701ad](https://github.com/chyves/chyves/commit/a3701ad26fd981f349dc47d7a5f9ac64ce192de5)

- FIX: Issue when specifying a branch in 'chyves upgrade'. [15cd40f](https://github.com/chyves/chyves/commit/15cd40fdd0a9643540c85bcccd796eb80a0bb878)

#### Version 0.1.2-dev (2016 August 27)

FreeNAS hot fix.

- FIX: FreeNAS handling of root directory via symbolic links. [77cf6f8](https://github.com/chyves/chyves/commit/77cf6f82c6a9b5c7117721b87d826eef3a891623)

#### Version 0.1.1 (2016 August 27)

Documentation changes.

- DOC: Address VGA/GPU passthrough in man page. [be3ba7c](https://github.com/chyves/chyves/commit/be3ba7c2aa079934f6bc3ac7b6da88e6551ef915)
  - [See Issue #3 on chyves GitHub page.](https://github.com/chyves/chyves/issues/3).

- DOC: Included RAM parameters for guest examples which require more than 256M of RAM. [0dd18aa](https://github.com/chyves/chyves/commit/0dd18aa7a490ae2bc0b009503a8bdf618cf10084)
  - As suggested by [/u/sirdond](https://www.reddit.com/user/sirdond).

- DOC: Included a generic Windows guest example in the man page. [485265d](https://github.com/chyves/chyves/commit/485265d41f44a8ab2e5ea82ecad235e7acb30721)

- DOC: Updated Intel e1000 requirements in man page. [ba949ad](https://github.com/chyves/chyves/commit/ba949ad927101496ce4db0f0a04eb4895b3c302a)
  - Still need to figure the OS integer to check for in the code to make this work.

- DOC: Typo in man/chyves.8.ronn [e1f985b](https://github.com/chyves/chyves/commit/e1f985bfba1d5935f6414b1af2155d7ec8202fee)

- DOC: Fixed typos and links in CHANGELOG.md, TODO.md, USAGE.md.  [c5b9c9d](https://github.com/chyves/chyves/commit/c5b9c9dd777b81880012565c6c624b628fc1ca0e)

#### Version 0.1.0 (2016 August 21)

Public release

- DOC: Update for chyves global properties for Github checker. [53527c2](https://github.com/chyves/chyves/commit/53527c271d131c9473f9ea160247d4fb495c23cf)

- Various minor tweaks to get the two commands below working.

- Turned on the ability check for new versions of chyves on GitHub based on the global property 'check_for_updates'. [92881c2](https://github.com/chyves/chyves/commit/92881c29c6e9508a73d10f5b3866dbf4fbd362b2)

- New command `chyves upgrade [master|dev|check]` to upgrade or check the latest version for the particular running branch on GitHub. [6055762](https://github.com/chyves/chyves/commit/6055762231344b67ebef0f1d347d9be96bf022ae)

#### Version 0.0.17 (2016 August 21)

- Allow guest property `virtio_block_options_disk{n}` to be `unset`. [5189276](https://github.com/chyves/chyves/commit/51892769e1f4183f0a3e12aefdb9957f70dd7192)

- Consolidated `firmware` and `iso` on SYNOPSIS section of man page. [75ff9a8](https://github.com/chyves/chyves/commit/75ff9a82f758b3785086ad53bff89feed3f9d2b8)

- Added new property `eject_iso_on_n_reboot`. This is both a global and guest property. The global property is reference when the guest property is not set. This ejects the ISO resource after `{n}` reboots. [9d1bee9](https://github.com/chyves/chyves/commit/9d1bee95b001553085ceee8587fa6fbf1ab39291)

- Fixed error when a guest has no disks. [9682731](https://github.com/chyves/chyves/commit/9682731df698aee2bcc6851cc91051a4de4e10f8)

- Fixed typo for diagnostic logging. [cc92b00](https://github.com/chyves/chyves/commit/cc92b00fe7824d67ccf6f1cf7311c939065ab2b6)

- Added OpenBSD 6.0 support for `grub-bhyve`. [263d53c](https://github.com/chyves/chyves/commit/263d53ccf890dc5c79266d88a9cc7ce1e45d3abe)

- Fixed `grep` argument in `__check_for_chyves_update`. [bd6de40](https://github.com/chyves/chyves/commit/bd6de4097bb8b8f86ff097f57f6c3a4da90ecfad)

- Updated `__check_for_chyves_update` to use `__log` rather than `echo`. [c53e997](https://github.com/chyves/chyves/commit/c53e997ba7edbecedff720f898d61fb975c65943)

- Fixed reference to old network command syntax. [f6a8f0](https://github.com/chyves/chyves/commit/f6a8f064d8722e1146d0fb831c0de9c79828cefc)

- Fixed issue with output when no clones exist. [f6a8f06](https://github.com/chyves/chyves/commit/f6a8f064d8722e1146d0fb831c0de9c79828cefc)

- Partial fixed issue when rolling back a guest snapshot that is more than 88 characters. [faba5ca](https://github.com/chyves/chyves/commit/faba5ca1f8735b36b905eb3e3fdeec74b56c6853)

- Added 'chvyes <guest> snapshot list` command. [3a6a926](https://github.com/chyves/chyves/commit/3a6a92687421a1db095ace210cb0467a7bda7d59)

- Added `reset` to end of `console` command to redraw dimensions. [d04340b](https://github.com/chyves/chyves/commit/d04340b5846939a583b802ce24e6b180b58cc004)

- Various fixes to doc files.

- Fixed error output when attempting to write logs to template guest. [6df1865](https://github.com/chyves/chyves/commit/6df1865dd4bb212caed02ab6b8354243f0620e6a)

- Fixed grep error output when `chyves` not setup on system. [f8c2cb3](https://github.com/chyves/chyves/commit/f8c2cb3bf0c3767d32a004aa876876fc59ac8105)

- Fixed bug when grabbing first disk for `bhyveload`. [5bc7a75](https://github.com/chyves/chyves/commit/5bc7a7525d7d2748a078cfe084f9a3f059c2c7a8)

#### Version 0.0.15 (2016 August 17)

- Fixed issue when rolling back a snapshot on a guest with different network config. Incremented chyves guest version. [63885ed](https://github.com/chyves/chyves/commit/63885ede2087295ad53e999d617524885cefc5a3)

- ENH: Added `-no-exit` flag for `__verify_tap_not_in_use` [c1c056e](https://github.com/chyves/chyves/commit/c1c056e11cf7b832bcd3df9a3f5bbe0cebae2e7d)

- FIX: Variable in `__verify_iface_on_guest` missing. [3f784e8](https://github.com/chyves/chyves/commit/3f784e8903bf2cb8532ae6169b1fcef6d67aed1b)

- ENH: Split `__network_remove` into two functions. [4920c13](https://github.com/chyves/chyves/commit/4920c1315600ebc1a49e7096b51d27e523d1c2f7)

- FIX: Various problems with parsing for network add and remove. [3882dbb](https://github.com/chyves/chyves/commit/3882dbbcdab43682741e5c7525a670dbddaa8dd7)

- FIX: Regex too loose for `grep`ping for tap interface in network library.  [c432053](https://github.com/chyves/chyves/commit/c432053c52243410c60146c70d9869c3eaa631c7)

- FIX: Refined `__parse_cmd_resources` [4e0c106](https://github.com/chyves/chyves/commit/4e0c10690fb1ed4d1c26076ef27c6ae1acee5677)

- FIX: Issue when assign bridge to private role. [442fe7c](https://github.com/chyves/chyves/commit/442fe7c58a5ce572911446afb4ff1afdca240c45)

- FIX: Error when setting default bridge. [1b04ed8](https://github.com/chyves/chyves/commit/1b04ed80f81437f56bb3b68889d4de544f91e0fa)

- Fixed issue with headers for `chyves list pools` [76b9c83](https://github.com/chyves/chyves/commit/76b9c8370b7b5a1b8e1eb7675f2da08e69286e06)

- Added check for running host version when using VNC console output. [662e072](https://github.com/chyves/chyves/commit/662e072e14e065c681d5f36b57c2796e509210ac)

- Various changes to doc files to bring to release state.

- Disallow changing `serial` property on running guest. [4ef8a4a](https://github.com/chyves/chyves/commit/4ef8a4a58421e4c0217f94e2d21f4d155d334c9c)

- Properties are not recorded to the log when pulling the value from the configuration file. Also also introduces 'stdout_level' setting '4' which is non-settable and never outputs to stdoutput. [382161a](https://github.com/chyves/chyves/commit/382161a341d558a71e102581c557ce2c031a61c9)

- Fixed issue introduced by [4d60946](https://github.com/chyves/chyves/commit/4d60946507fac60b63b096e38a2359b126002f6f), non-trailing denominations re-allowed. [de875c3](https://github.com/chyves/chyves/commit/de875c3557e0a1939c4a12b3e23dc550bcb75407)

- Fixed edge case where a reverting start or reboot snapshot would not reload guest settings. [8cfb332](https://github.com/chyves/chyves/commit/8cfb332c27616cef007d3e667ee66ccc2d2322a7)

- Moved 'start' snapshot reverting `if` statement so that above commit was apparent what the changes were. [e50eea8](https://github.com/chyves/chyves/commit/e50eea81d8d2b92acb8c441449819bf0cb354423)

- Fixed issue where bhyve and loader command would only be recorded when the `dev_mode` not set to 'off'. [87f24a0](https://github.com/chyves/chyves/commit/87f24a0b8e9449e49f00d4729739a6d94e9a8542)

#### Version 0.0.13 (2016 August 15)

- Guests can now be reverted to a previous snapshot state on start, reboot, both, or not at all (default). The new properties 'revert_to_snapshot' and 'revert_to_snapshot_method' control the snapshot and the method respectively for this process. [0e7f083](https://github.com/chyves/chyves/commit/0e7f083b24d24afd38da3e47bfe4c44620eb4c05)

- Added limited support for raw file based images. [3c37e0a](https://github.com/chyves/chyves/commit/3c37e0a8168ff3fe8e8ae3e4749cb5175550475f)

- Added verbosity to `chyves list property` and now checks for two parameters. [fb2eb31](https://github.com/chyves/chyves/commit/fb2eb31d8886d906e640f59ff9468c09f04afb8d)

- Changed the reported size value from `usedbychildren` to `used` for `chyves info -z`. [0e9dca2](https://github.com/chyves/chyves/commit/0e9dca2070b8ea4d17aa1351753acc58024f0a3c)

- Allow trailing 'b' for size denominations. [4d60946](https://github.com/chyves/chyves/commit/4d60946507fac60b63b096e38a2359b126002f6f)

- Support for 32 AHCI hard drive devices on a single PCI slot for hosts running 12-CURRENT. [d9f769f](https://github.com/chyves/chyves/commit/d9f769f0b83598fa9af5665898e168f9c4ea2cde)

- Set defaults based on host OS version for 'bargs', use '-S' flag on 10.3+. [60d6d15](https://github.com/chyves/chyves/commit/60d6d157c80e04125c0f7733dbb5c664101022a0)

- Minor revisions in `__generate_bhyve_slot_string()`. [e98e7a3](https://github.com/chyves/chyves/commit/e98e7a34c4ed8ecd0777dfa3c7064c20e1a655b3)

- Added new function `__stop_guest_loader()` to stop a hung loader process on guest boot and for `chyves <guest> stop`.  [ed324bb](https://github.com/chyves/chyves/commit/ed324bb5c60fa12df9c38804debb1ac73baa10dc)

- Newer chyves guest version are not allowed to start on older versions. This is preventative for the future. [2b8fce5](https://github.com/chyves/chyves/commit/2b8fce564b8e9cd979c72bea8cc038b51f85e5ea)

- Added `make what` directive to show what commands were available. [a66943a](https://github.com/chyves/chyves/commit/a66943a87769206d425d3b72879594b3d6f7e913)

- Fixed missing disk sub-section in man page. [e89035c](https://github.com/chyves/chyves/commit/e89035c36a48d5c8d7625e2bac38a39b689aeb16)

- Finished commit to using keyword 'properties' rather than 'parameters' for guests qualities. [b111b03](https://github.com/chyves/chyves/commit/b111b03295e21b32943e46decff2b2925f60d269)

- Finished commit for consolidate disk note/desc in synopsis. [b111b03](https://github.com/chyves/chyves/commit/b111b03295e21b32943e46decff2b2925f60d269)

- Null value can now be set for `default_info_flags` and `default_list_flags`. [79a641a](https://github.com/chyves/chyves/commit/79a641a0805221be6ad959d6719b584368ea45f9)

- Created new command `chyves <guest>|MG|all unset <pcidev_{n}>` to unset a property on a guest. [260f4ae](https://github.com/chyves/chyves/commit/260f4ae07827636b16b7c905b1384db091f8554e)

- Minor speed improvement from loading order in `__add_guest_disk()`. [acba72d](https://github.com/chyves/chyves/commit/acba72d87fb5188c611e414f70e32f8f229ccd8c)

#### Version 0.0.11 (2016 August 12)

- Fixed issue with `bhyve` string for VNC frame buffer. [a0d68d7](https://github.com/chyves/chyves/commit/a0d68d77bfe9dde4a90117fd5d41fe9a4725121e)

- Merged fix for incorrect UEFI firmware path when starting guest. Thanks to [Andrew D.](https://github.com/chyves/chyves/commit/). [bb60b4b](https://github.com/chyves/chyves/commit/bb60b4be309358fedc10eb85bdb9ac3fc2783733)

- Fixed issue with when deleting guest. [8387e7e](https://github.com/chyves/chyves/commit/8387e7eebd560e1e62a501d977f47e530f71f0bd)

- Committed to using keyword 'properties' rather than 'parameters' for guests qualities. [aae3376](https://github.com/chyves/chyves/commit/aae33768c98e307786018271e6c4cf2dc065c32e)

- Fixed issue for `chyves info` with diskless guests. [9baf434](https://github.com/chyves/chyves/commit/9baf43405e6f56a2eb10f06cd41e2c4adb65966c)

- Consolidate disk note/desc in synopsis. [a7d21a4](https://github.com/chyves/chyves/commit/a7d21a47e2ec505af99c677f781b7dd1f4e4c306)

- Fixed issue referencing renamed functioned. [404e9dd](https://github.com/chyves/chyves/commit/404e9dd5255f56a99743994f95d68e8f72b7bdbb)

- Added check for existence of local file when importing. [9680c23](https://github.com/chyves/chyves/commit/9680c236b90b9ff691bf192c40fb31dc75d6615a)

#### Version 0.0.9 (2016 July 24)

Fix.

- Typo caught by /u/Open_Systems, `rcvar` != `sysrc`. [4a47aaf](https://github.com/chyves/chyves/commit/4a47aaf26860f86a5833ff6bbfda056d946cc458)

#### Version 0.0.7 (2016 July 24)

Docs and minor fixes.

- Converted to using Ruby gem: `ronn` for the man page from `txt2man`. See [issue #1](https://github.com/chyves/chyves/issues/1) for details. [ed90a46](https://github.com/chyves/chyves/commit/ed90a464baa491e1390008133e9f8653d063f621)

- Referenced html man page in [README.md](README.md). [ee90338](https://github.com/chyves/chyves/commit/ee903385b365ace0ace3171d4a0c3723e50de954)

- Utilized the '[LINK INDEXES](http://rtomayko.github.io/ronn/ronn.1#LINK-INDEXES)' function of `ronn` to link to external man pages (FreeBSD specifically). [0da85ca](https://github.com/chyves/chyves/commit/0da85cad21ddd3338bc6e180d99b16d41170c8e9)

- Minor changes to `chyves <guest> upgrade`. This should have been committed in version 0.0.5 but there is no ill effects. Running `chyves <guest> upgrade` or waiting until the next dataset increment will resolve the issue. [7c338dd](https://github.com/chyves/chyves/commit/7c338ddfbd0f173d3decd71007a6b3b21f86e06e)

- Refreshed docs: [README.md](README.md) [756193d](https://github.com/chyves/chyves/commit/756193db5be9d71171927b579abbee90897d631e), [MAN PAGE files](man/chyves.8.html) [4589d5a](https://github.com/chyves/chyves/commit/4589d5acbd3b20fdf6782dd72d45afbec52afd07), and [USAGE.md](USAGE.md) [28f5aa0](https://github.com/chyves/chyves/commit/28f5aa05dbaf5f36b7a956a08893a58f65184eee).

- Refreshed table of contents in sbin/chyves. [5cf15a7](https://github.com/chyves/chyves/commit/5cf15a713b849dffd254ec8dc41ca5b5112b9431)

- Other minor fixes.

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

- Added `make deinstall` directive to `Makefile` for source installations. This removes all the installed files from the system.

- Added `make rcremove` directive to `Makefile` for source installations. This removes the configuration contained in the `/etc/rc.conf` file using the `sysrc` command.

- Added `make installrc` directive to `Makefile` for source installations. This enables booting chyves guests which have a possible integer set for the `rcboot` parameter. This adds the '`chyves_enable=YES`' configuration in the `/etc/rc.conf` file using the `sysrc` command.

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

- Guests now reboot properly and all other `bhyve` exit codes reclaims the VMM resources.

- Deprecated `chyves scram`, replaced by `chyves all stop`

- Rewrite of `clone`. New syntax is: `chyves <guest> clone <clonenames>|MG [-ce|-cu|-ie|-iu] [<pool>]`. Four flags for cloning. True ZFS clone and independent clones with or without new properties.

- Renamed property `con` to `serial`

- Rewrote disk functions now includes
  - `chyves <guest> disk add [<size>]`
  - `chyves <guest> disk disk{n} description <description>`
  - `chyves <guest> disk disk{n} notes <note>`
  - `chyves <guest> disk delete disk{n}`
  - `chyves <guest> disk resize disk{n} <new-size>`
  -  and `chyves <guest> disk list`.

- A rewrite of the `list` and `info` commands.

- No longer hard coded to use `disk0` as the boot device, uses the numerically first device.

- Check ran while starting guest to see if related `grub-bhyve` or `bhyveload` process is running for guest and kills it if so.

- Renamed parameter from `fw` to `uefi_firmware`.

##### Internal code changes:


- Added function `__fault_detected_exit` function to standardized the way to exit with a message and why the exit was necessary.

- Added functions `__verify_valid_pool` and `__verify_valid_guest` functions to verify a pool and guest are valid and exit if not.

- Added function `__generate_generic_device_map` to create device map used in `__load`.

- Added function `__return_guest_dataset_mountpoint` to get the mount path of a guest.


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

- Added function `__return_cpu_section_from_dmesg` to print out the CPU section from the `dmesg`. This is used in the `__preflight_check` to determine the CPU features.

- Added variable `_GUEST_NAMES_FORBIDDEN_GREP_STRING` to prevent guests with these names from being created.

- Added function `__return_one_if_freenas` to return nothing or "1" if on FreeNAS system.

- Added function `__return_guest_rcboot_priority` to display a human friendly "NO" or "YES ($boot-priority-number)" when called.

- Added function `__return_guest_bhyve_pid` to display a human friendly "NO" or "YES ($bhyve-PID)" when called using the `-h` flag. If no flag is used then the bhyve PID is returned.

- Added function `__return_guest_vmm_allocated` to display a human friendly "NO" or "YES" when called using the `-h` flag. If no flag is used then a "1" is returned.

- Added function `__verify_number_of_arguments` to check the number of parameters and exits if not met or if exceeded.

- Changed parameters to be function indexed rather than script indexed.
  - This limits the number of addressable parameters to nine due to the Bourne shell, which does not matter.
  - `chyves set` is the one exception, it is still script indexed.

- Added variable `_PRIMARY_POOL` to global variables instead of polling `__gvset_primary_pool` more than once.

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

- Added function `__gvset_guest_name_by_pid` and variable `_GUEST_name_by_pid` to get the name of a guest but the process ID. This is currently used when a `tap` interface is locked by a process and descriptive user output is needed including the guest name that is causing the issue.

- Added function `__generate_bhyve_net_string` to dynamically generate bhyve PCI string (Eg. -s 7,virtio-net,tap{n}) for each network device. VALE devices supported (Eg. -s 7,virtio-net,vale{n}).

- Added function `__gvset_guest_pool` to verify and then set "_GUEST_pool" for supplied guest.

- Added function `__get_corrected_byte_nomenclature` to verify user input, pull the size denomination, use only the first letter, and captilize that letter. Then if the number is evenly divisible by 1024, it increaeses the size denomination.

- Added function `__get_next_vnc_port` to generate next unused VNC port, then assigns variable `_NEXT_vnc_port`.

- Added guests properties `uefi_console_output`, `uefi_vnc_mouse_type`, `uefi_vnc_ip`, `uefi_vnc_port`,  `uefi_vnc_res`, and `uefi_vnc_pause_until_client_connect` for use with UEFI guests using VNC consoles.

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

- Renamed `destroy` to `reclaim` because while the command for bhyvectl is destroy, it conflicts with the zfs use of the word destroy and causes confusion.

- Renamed `__parse_cmd` to `__parse_cmd_ingress`. Now input is first ingested by __parse_cmd_ingress() and then either user input is verified or passed to another __parse_cmd_*() function for further ingestion.
 - On top of parameter verification, user input verification is now handled at the __parse_cmd_*() level. This makes calls from other functions a little faster as if a function is calling another function it should have already verified the input from the user.  

- Inverted __readonly_cmd() to __root_credentials_required().

- Moved __verify_*() functions to a library file.

- Renamed `__stop` to `__stop_guest_gracefully` and moved to library file `lib/chyves-guests-stop`

- Renamed `__destroy` to `__destroy_guest_vmm_resouces` and moved to library file `lib/chyves-guests-stop`

- Deprecated `__forcekill` and moved functionality into `__destroy_guest_vmm_resouces`.

- Complete rewrite of `__cloneguest`

- Added function `__parse_cmd_console` to parse user input for console sub-commands and loads nmdm kernel module.

- Added library file `lib/chyves-guest-console` with `__console_reset`, `__console_run`, `__console_tmux`, `__get_guest_console_pid`, and `__verify_console_not_in_use`.

- Added function `__verify_user_input_for_properties` to verify user input for properties. Adjusted values get set to global variable “$_ADJUSTED_value” and then replace original value in the function that called it.

- Added function `__parse_cmd_snapshot` to parse user input for snapshot commands. Real big and nasty.

- Changed to using `grep -c` for counting because it does a better job than `wc -l` by not having leading spaces.

- Added function `__log` which both logs and `echo`s the messages to the screen. There are different output levels including '0' which is effectively off. Everything gets logged on the primary pool and guest related tasks are intended to be written on the guest but this is not always the case depending on the whether the `_GP_mountpoint` variable is loaded. The global parameters `stdout_level`, `log_to_file`, and `log_mode` are used to control the output.

- Added library file `lib/chyves-return` with:
  - `__return_cpu_section_from_dmesg`
  - `__return_guest_bhyve_pid`
  - `__return_guest_bhyveload_pid`
  - `__return_guest_dataset_mountpoint`
  - `__return_guest_disk_list`
  - `__return_guest_grub_bhyve_pid`
  - `__return_guest_list`
  - `__return_guest_rcboot_priority`
  - `__return_guest_snapshot_list_level1`
  - `__return_guest_snapshot_list_level2`
  - `__return_guest_snapshot_last`
  - `__return_guest_vmm_allocated`
  - `__return_new_line_delimit_as_comma_string`
  - `__return_new_line_delimit_as_grep_string`
  - `__return_new_line_delimit_as_space_string`
  - `__return_one_if_freenas`
  - `__return_pools_active`
  - `__return_pools_all`
  - `__return_pools_offline`

- Renamed `__setup` to `__dataset_install` as this only sets up the dataset.

- Added library file `lib/chyves-resources`
  - `__guest_delete`
  - `__guest_delete_backend`
  - `__resource_delete`
  - `__guest_rename`
  - `__resource_import`
  - `__resource_rename`

- Added function `__fault_detected_warning_continue` to warn and 'continue'.

- Added function `__fault_detected_warning_break` to warn and 'break'.

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

< Last commit documented on this page: https://github.com/chyves/chyves/commit/7b3d2a44ada0ceb8786d6b6ddc735c7f3ccf29b7 >
