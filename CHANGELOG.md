#### Version 0.0.0 (2016 April 00)

Initial development.

Forked from `iohyve` at 0.7.5 "Tennessee Cherry Moonshine Edition" release at commit [2ff5b50](https://github.com/pr1ntf/iohyve/commit/2ff5b50d8cda61a8364bd79319152142ac1b4c33).

Changed command from `iohyve` to `chyves`. It rhymes with the original project and creating a memorable logo is in the works.

Created new document structure and folder. Root folder contains documents about the project. The installed files are now in their respective places `sbin/`, `etc/rc.d/`, and `man/man8`

Changes other internal references to `iohyve` to `chyves`. For example, the VMM names now reference `chy-$guest`.

Fixed various typos in man page.

Created a new dataset to house all the guests under `$pool/chyves/guests/$guest`
