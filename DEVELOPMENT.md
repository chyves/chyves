This project has three primary branches it uses: master (stable), dev (testing but stable), and sid (considered unstable and experimental). Releases under `master` will be submitted to the ports tree under `sysutils/chyves`, dev versions released under `sysutils/chyves-devel`, and sid will remain on GitHub. Versions ending in odd numbers are released from the `dev` branch and versions ending in even numbers are released from the `master` branch.

If we as developers do a exceedingly job, the only difference between the sysutils/chyves release and the sysutils/chyves-devel release will be a version increment... in practice however.

The `sid` branch is the ingress branch for PRs and internal development. Large feature changes will be under `sid.feature-name`. The `sid` branch exists so the code can be pulled in, tested, evaluated, and refined before getting distributed under `dev` and eventually `master` branch.

#### Whitespace
Whitespace is intentionally used to create visual separation and order. To keep a consistent feel through the project's files the following guidelines are used:

Spaces are used in documents where whitespace is important to how the document is displayed. This applies in the man pages and in-line code examples within Markdown formatted documents.

Tabs are used in scripts where counting the number of spaces becomes tedious. The internal conversation should _never_ be "Is it two or three spaces after an `if` statement?". It is a tab, every time.

 [@EpiJunkie](https://github.com/EpiJunkie) recommends if you are not a `vi`/`vim`/`emacs` veteran to check out GitHub's [Atom](https://atom.io/) editor and configure the `atom-sync` package configured. He suggests the combination of the two make developing from a comfortable desktop environment easy and the `atom-sync` package will sync the files to the development box each time a file is updated on either end. The Atom editor also visually displays tabs (referred to as 'hard tab') as double spaces (referred to as 'soft tabs') for an easier read while still following the prescribed whitespace nomenclature.

#### Unusual code
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

#### Commonly used pipe sections
To lift a term from [pipecut](https://code.google.com/archive/p/pipecut/), below are commonly used "pipe sections" to manipulate text for a desire output.


#### Script indexed vs. function indexed
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
The reason why the `chyves` project prefers function indexed rather than script indexed is a matter of personal preference. In the lead developer's opinion, it makes debugging easier. All but two sub-functions use less than five parameters so it makes sense specify each parameter and restrict unwieldy situations. The two exceptions are the `chyves set` and `chyves create` subfunctions which have the script indexed positional parameter passed via "`$@`" to access all the parameters with the help of `shift`. In practice this mean that `chyves set` and `chyves create` are able to set an unlimited number of properties for guest(s).

#### Recommended reading:
[FreeBSD man sh](https://www.freebsd.org/cgi/man.cgi?query=sh&sektion=&n=1)

[Sh - the Bourne Shell -- Grymoire.com](http://www.grymoire.com/Unix/Sh.html)

[Semantic Versioning 2.0.0 -- Semver.org](http://semver.org/)
