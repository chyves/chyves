This document tracks changes that are made in order to ensure dataset and guests contain the latest structure and syntax. This document is a matter of reference as the process of upgrading has been automated with `chyves dataset <pool> upgrade` and `chyves <guest> upgrade`. While we try to mitigate the need for such a document through planning, this can not always be the case. This can be especially true with new features.

20160902
- chyves guest version incremented to 0201
  - Incremented so v0.1.1 and earlier versions do not try to start guests, specifically ones that have the '`os`' property set to 'coreos' or 'openbsd60'.

20160821
 - Public released versions:
  - chyves version: 0.1.0
  - Dataset version: 0004
  - chyves guest version: 0200
