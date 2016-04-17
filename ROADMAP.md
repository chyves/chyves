This early in the project a map is not defined. However many goals are planned:


Created a dataset, `$pool/chyves/.defaults`, which is referenced to build new guests instead of hard references.

Changed the output of `info` to be more verbose with command line flags.

Added comments throughout the code to indicate what is going on.

Added more output to indicate to the end user what is happening in the script

Restructured command layout to have less sub-commands. For example: `list`, `fwlist`, `isolist`, `snaplist`, `taplist` all are combined under `list`. The `list` still displays output for the status of guests, `list iso` displays what `isolist` used to, and so forth.
