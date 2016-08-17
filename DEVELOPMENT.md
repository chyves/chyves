This document uses keywords (MUST, MAY, SHOULD, etc.) in compliance with RFC 2119.

This project has three primary branches it uses:
- master (stable)
- dev (testing but stable)
- sid (considered unstable and experimental).

The ingress branch for PRs and internal development MUST always be `sid` branch. Large feature changes SHOULD be under `sid.feature-name`. The `sid` branch exists so the code can be pulled in, tested, evaluated, and refined before getting distributed under `dev` and eventually `master` branch. Code that is relatively stable from sid branch will be introduced to dev branch for wider testing. Once the code has been tested on a wider scale then it is integrated into master.

Releases under `master` will be submitted to the ports tree under `sysutils/chyves`, `dev` versions released under `sysutils/chyves-dev`, and `sid` will remain on GitHub. Versions ending in odd numbers are released from the `dev` branch and versions ending in even numbers are released from the `master` branch.

If we (as developers) do a exceedingly job, the only difference between the dev and master releases SHOULD be a version increment.

### Script execution flow
Functions are tiered in such a way that the first tier deals with argument and input verification from the user and the second tier deals with executing against the host. Part of the reason this is done is so that if one host function needs to call another host function, then execution is much quicker as input verification is not needed. This methodology also allows for using the `dev` subcommand for easier debugging.

When `chyves` is executed:
- Stage 1 globally variables are set, these variables do not rely on a primary pool being set; nor do they require `chyves` functions.
- Then the `__preflight_check` function is executed after a few critical functions in `sbin/chyves` are loaded in memory (as part of how Bourne shell scripts execute). The checks that are ran here will cause a fatal error if the check does not pass.
  - Library files are loaded from `../lib/chyves/`.
  - Stage 1 global variables are refined. If a variable is empty, a UUID is used as the variables must contain a value otherwise `grep` will throw errors.
  - A check is ran against the dataset version to ensure compatibility with the version of chyves running.
  - A check is ran to check the CPU has the hardware virtualization capabilities.
- Then `__parse_cmd_main` is executed.
  - For non-guest sub-commands, the parameter values are shifted one parameter and then passed to the next `__parse_cmd_*` function.
  - For guest sub-commands, the parameters are verified for the number of parameters and then verified for correct input type and values. Some guest sub-commands have sub-sub-commands, these are passed to the next `__parse_cmd_*` function but no shift is done as this was wipe out the guest name which may be using MG.
- After the command from the user makes it to the second-to-last (typically) command in the `__parse_cmd_*` tree, it executes the command against the host.
- The final command from all `__parse_cmd_*` functions is an exit.

### Common code practices
Below are common coding practices within the project.

#### Naming convention

##### Functions naming
Functions MUST always start with a double underscore. Example: `__functions`
- Function MAY set a global variable based on the words after the verb called to set global variable. Example: `__verb_future_variable_name`
- Function returning output directly (not a variable) to stdout MUST start with `__return_`.
- Function setting a global variable as it's primary purpose MUST start with `__gvset_`.

##### Variables naming
Variables MUST always start with a single underscore. Example: `_variables`

- Within this practice there is varying capitalization that indicates the origin of the variable.
  - Variables with all capitalization MUST be globally set and created in beginning of script or in `__preflight_check`. Example: `_CAPS_ONLY_GLOBAL_VARIABLE`
  - Variables starting with capitalization for first word and lower case for the remaining MUST be used for global variables set later in script by a called function. Example: `_CAP_mixed_variables`
  - Local variable MUST always be all lower case. Example: `_only_lower`
  - Local variables SHOULD also be declared on the first line of the function. This serves as a reminder that the variables are in use. Example `local _var1 _var2 _var3`
- Properties containing guest properties as set in ZFS as user properties MUST be prefixed with '_GP_'.
- Properties containing guest default properties as set in ZFS as user properties MUST be prefixed with '_GDP_'.

### Whitespace
Whitespace is intentionally used to create visual separation and order. To keep a consistent feel through the project's files the following guidelines are used:

Spaces are used in documents where whitespace is important to how the document is displayed. This applies in the man pages and in-line code examples within Markdown formatted documents.

Tabs are used in scripts where counting the number of spaces becomes tedious. The internal conversation should _never_ be "Is it two or three spaces after an `if` statement?". It is a tab, every time.

 [@EpiJunkie](https://github.com/EpiJunkie) recommends if you are not a `vi`/`vim`/`emacs` veteran to check out GitHub's [Atom](https://atom.io/) editor and configure the `atom-sync` package configured. He suggests the combination of the two make developing from a comfortable desktop environment easy and the `atom-sync` package will sync the files to the development box each time a file is updated on either end. The Atom editor also visually displays tabs (referred to as 'hard tab') as double spaces (referred to as 'soft tabs') for an easier read while still following the prescribed whitespace nomenclature.

### Unusual code
This section covers code that is commonly used with an explanation of what it does.

This bit of code can be a bit confusing when first seen:
```shell
  [ ! -x "${_path_to_binary}" ] && echo "Failed to find executable binary: '$_path_to_binary'" && exit
```

...but actually is the same as this:
```shell
  if [ ! -x "${_path_to_binary}" ]; then
    echo "Failed to find executable binary: '$_path_to_binary'"
    exit
  fi
```

### Commonly used pipe sections
To lift a term from [pipecut](https://code.google.com/archive/p/pipecut/), below are commonly used "pipe sections" to manipulate text for a desire output.


### Script indexed vs. function indexed
The Bourne shell indexes parameters at both the script level and at the function level.

In the Bourne shell, each parameter is described as an incrementing number starting with the `script-name` being `[1]` in script level indexing. See the example below:
```shell
chyves@bhost:~ # script-name "parameter one" "parameter 2" "parameter 3" "parameter 4" ... "parameter 15"
$0 = script-name
$1 = "parameter one"
$2 = "parameter 2"
...
$9 = "parameter 9"
$10 = "parameter one0"
```
Unfortunately `$10` is not referable this is due to the way that Bourne parse the variable. Bourne actually expands the variable to "parameter0" rather than "parameter 10".

The question then becomes: _"How do we use more than nine parameters?"_ The `shift` command can be used to shift the parameters by a certain number of parameters. For example:
```shell
chyves@bhost:~ # script-name "parameter one" "parameter 2" "parameter 3" "parameter 4" ... "parameter 15"
#!/bin/sh

echo $1       # displays "script-name"
shift 13
echo $1       # displays "parameter 14"
```
As you can observe above the "`shift 13`" moved the perspective of `$1` thirteen parameters (to the right). This is really helpful in `for` and `while` loops to process all the parameters given. This is the case for `chyves set` and `chyves create`.

_"Okay, so what is function indexed?"_
Function index is the same concept except from the function's perspective. When a function is called with parameters (within that function) the index 1 (`$1`) is actually the first parameter given rather than the "`script-name`" or rather "`__function_name`" in this case. See the example below:
```shell
__function_name() {
  echo $1       # displays "parameter 1"
  echo $2       # displays "parameter 2"
  echo $3       # displays "parameter 3"
  ...
  echo $9       # displays "parameter 9"
}

__function_name "parameter 1" "parameter 2" "parameter 3" ... "parameter 9"

```
The reason why the `chyves` project prefers function indexed rather than script indexed is a matter of personal preference. In the lead developer's opinion, it makes debugging easier. All but one sub-function use less than five parameters so it makes sense to specify each parameter and restrict unwieldy situations. The two exceptions are the `chyves set` and `chyves create` subfunctions which have the script indexed positional parameter passed via "`$@`" to access all the parameters with the help of `shift`. In practice this mean that `chyves set` and `chyves create` are able to set an unlimited number of properties for guest(s).

### Recommended reading:
[FreeBSD man sh](https://www.freebsd.org/cgi/man.cgi?query=sh&sektion=&n=1)

[Sh - the Bourne Shell -- Grymoire.com](http://www.grymoire.com/Unix/Sh.html)

[Semantic Versioning 2.0.0 -- Semver.org](http://semver.org/)
