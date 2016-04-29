This project has three primary branches it uses: master (stable), dev (testing but stable), and sid (considered unstable and experimental). Releases under master will be submitted to the ports tree under `sysutils/chyves`, dev versions released under `sysutils/chyves-devel`, and sid will remain on GitHub.

http://semver.org/

#### Whitespace
Spaces are used in documents where whitespace is important to how the document is read. This applies in the man pages and in code examples in the Markdown documents.

Tabs are used in scripts where counting the number of spaces become tedious. The internal conversation should _never_ be "Is it two or three spaces after an `if` statement?". It is a tab, every time.

If you are not a `vi`/`vim`/`emacs` veteran, then @EpiJunkie recommends using GitHub's [Atom](https://atom.io/) editor with the `atom-sync` package. The combination of the two, make developing from a comfortable desktop environment easy and the `atom-sync` package will sync the files to the development box each time a file is changed on either end.

#### Unusual code
This section covers code that is commonly used and an explanation of what it does.

This was new syntax that did not make sense to me when I first saw it:
````
  [ ! -x "${_path_to_binary}" ] $$ echo "Failed to find executable binary: '$_binary_to_check_for'"
````

...is the same as this:
````
  if [ ! -x "${_path_to_binary}" ]; then
    echo "Failed to find executable binary: '$_binary_to_check_for'"
fi
````
