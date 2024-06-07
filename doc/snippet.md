# Trick from net
gcc -xc -E -v -

    For C++:

    gcc -xc++ -E -v -
From https://stackoverflow.com/questions/4980819/what-are-the-gcc-default-include-directories

Bash tricks
<file grep toto  # so can edit regex easier
Alr-.  # paste last

setSteMode => setStrModeApeHil

https://www.shell-fu.org/tips.php?sort=popular&page=2

yes hello
rename
nohup ./script.sh &  # Survivres shh fail
timeout 10s ./script.sh

https://git.savannah.gnu.org/cgit/bash.git/  use CDPATH

tail -f

https://github.com/coreutils/coreutils/blob/master/src/tee.c

https://github.com/topics/bash
https://github.com/jlevy/the-art-of-command-line#processing-files-and-data
https://github.com/LeCoupa/awesome-cheatsheets/blob/master/languages/bash.sh
https://github.com/rust-shell-script/rust_cmd_lib

* Prefix '{' a multiline script so can press enter without executing

# Snippet

```bash
get_functions() {
    # Usage: get_functions
    IFS=$'\n' read -d "" -ra functions < <(declare -F)
    printf '%s\n' "${functions[@]//declare -f }"
}

# Sleep
read -rt 0.1 <> <(:)
```


# Snippet variable references

```bash
var="world"
declare "hello_$var=value"
printf '%s\n' "$hello_world"
value

hello_world="value"

# Create the variable name.
var="world"
ref="hello_$var"

# Print the value of the variable name stored in 'hello_$var'.
printf '%s\n' "${!ref}"
value

# Need bash4.3

hello_world="value"
var="world"

# Declare a nameref.
declare -n ref=hello_$var

printf '%s\n' "$ref"
value
```
# WTF is that

```bash
a='\#'; echo "${a@P}"  # Command number, after 4.4
```

# Snippet Random
```bash

"$RANDOM"
```


# More link

* Book: [The Linux Command Line (TLCL)](http://linuxclass.heinz.cmu.edu/doc/tlcl.pdf)
