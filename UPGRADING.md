This document tracks changes that are made in order to ensure dataset and guests contain the latest structure and syntax. This document is a matter of reference as the process of upgrading has been automated with `chyves dataset <pool> upgrade` and `chyves <guest> upgrade`. While we try to mitigate the need for such a document through planning, this can not always be the case. This can be especially true with new features.

20160911
- chyves guest version incremented to 0301
  - Minor version increment for `audio_play` and `audio_rec` properties.
- dataset version incremented to 0006
  - Added `audio_play` and `audio_rec` to defaults with a null value.

20160910
- chyves version v0.1.9-dev
- chyves guest version incremented to 0300
  - Major version increment for `bhyve_disk_type` property which is used to describe the method to attach ZFS volumes and disk images to guests.
- chyves guest version incremented to 0202
  - Minor version increment for `bhyveload` guest property.
- dataset version incremented to 0005
  - Added `bhyveload` to defaults with a null value.
  - Added `bhyve_disk_type` to defaults with 'ahci-hd' as the value.

20160902
- chyves guest version incremented to 0201
  - Incremented so v0.1.1 and earlier versions do not try to start guests, specifically ones that have the '`os`' property set to 'coreos' or 'openbsd60'.

20160821
 - Public released versions:
  - chyves version: 0.1.0
  - Dataset version: 0004
  - chyves guest version: 0200
