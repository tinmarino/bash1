

# TODO
* Hands on
  * Multi get Cyrostat status
  * ShowRunnginVersion to dict
  * Dispacher
  * MultiFAR
  * Multi-read-doc from file in //
* Fond naming convetion for functions and docstring
* Vim: Embed markdown syntax in docstring
* Show local
* Quote in Quote
  * Idea check if is prime
* $IFS
* curl https://raw.githubusercontent.com/tinmarino/bash1/master/bask_programming.bash

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

# DONE



## A.2 Quote

```bash
printf "%s\n" {1..9} | xargs -Iii echo "printf \"%-3s\""  \$\(\(ii*{1..9}\)\) \; printf \"\\n\" |bash
for i in `seq 9`;do seq -s' ' $i $i $((9*i));done


### Other way
seq 2 9|xargs -Iz seq -s' ' z z z0|cut -d" " -f 2-9 | xargs -n1 factor
seq 9|xargs -Iz seq -s' ' z z z0

seq 2 100|factor|sed 's/.*: //g;/ /d'
seq 1e6|factor|awk '$0=$2*!$3'

echo $((`printf %d \':`#yG))
printf %x \'—  # 2014
printf %d \'A


for i in $(seq 2 9);do seq -s" "  "$i" "$i" "$((9*i))"; done| cut -d" " -f2-9
for j in $(for i in $(seq 2 9);do seq -s" "  "$i" "$i" "$((9*i))"; done| cut -d" " -f2-9); do factor $j; done

echo "$(bc <<< "$(bc <<< "2 * 2") * 2")"
i=3; echo "$(bc <<< "$(bc <<< "$i * 2") * 2")"


source "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")/script/lib_alma.sh"

source "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/script/lib_alma.sh"

# Source lib_alma even if this file is a symlink
gs_root_path=$(readlink -f "${BASH_SOURCE[0]}")
gs_root_path=$(dirname "$gs_root_path")
script_path="$gs_root_path"/script
source "$script_path"/lib_alma.sh
```

## A.2. Expansion

* Interpolation
* Context evaluation
* Macro like

```bash
expansion_bad(){
}

expansion_good(){
}
```

man bash / EXPANSION


## A.3. Control flow

```bash
control_bad(){
  if 1==1; then echo Yes; fi
  
  for ant in ("DV03", "DV25"); do echo $ant; done
}
  
control_good(){
  if true; then echo Yes; else echo No; fi

  for ant in DV03 DV25; do echo $ant; done

  case DV03 in
    DV*) echo Vertex; echo tot; exit;;
    DA*) echo AEM;;
    *) echo Other;;
  esac
}
```

man bash / SHELL GRAMMAR / Compound Commands

## A.4. Advanced types: Array

TODO

* copy
* set -- and shift


```bash
array_bad(){
  a_in=($@)  # Err1
  
  while [[ "$@" != "" ]]; do  # Err
    case $1 in  # Err
      -h)
        echo Help yourself: lint your code!; exit;;  # Err
      *)
        shift
    esac
  done
        
  for s in ${a_in[*]}; do  # Err2
    echo $((cnt++))/ $s  # Err3
  done
}
    
array_good(){
  local a_in=("$@")  # Copy array, use correct expansion: do not split on whitespace twice!
  
  while (( 0 != $# )); do
    case "$1" in  # Err
      -h)
        echo "Help yourself: lint your code!"
        exit
        ;;
      *)
        shift
    esac
  done
  
  local s_elt=""  # Do not leak variable out of your function
  local i_count=0
  for s_elt in "${a_in[@]}"; do
    echo "$(( i_count++ ))/ $s_elt"
  done
}
```

## A.4. Advanced types: Associative arrays

```bash
dict_good(){
  # Initialise
  declare -A d_ant=(
    [DV03]=Martin
    [DA45]=Soledad
  )

  # Append
  local s_ant=DV23
  local s_user=Camilo
  d_ant[$s_ant]=$s_user
  
  # Get keys <- dict
  local a_key=("${!d_ant[@]}")
  
  # Sort keys (optional)
  local a_key_sorted=()
  readarray -t a_key_sorted < <(printf '%s\n' "${a_key[@]}" | sort -k1,3)
  
  # Loop
  local s_key=""
  for s_key in "${a_key_sorted[@]}"; do
    printf "%4s -> %s\n" "$s_key" "${d_ant[$s_key]}"
  done
}
```

## A.5 Introspection

* Configuration
* Workflow
* TODO Roseta code


```bash
set -u
```

# Game

https://codegolf.stackexchange.com/questions/28786/write-a-program-that-makes-2-2-5
```bash
# For people who don't know Bash: $((...expr...)) is a syntax to evaluate arithmetic expressions. $(bc<<<...expr...) does the same using the bc command-line calculator.
v=2                       #v is 2
v+=2                      #v is 4
v=$((v * 5))              #v is 20
v=$((v - 16))             #v is 4
v=$(bc <<< "sqrt($v)+2")  #v is 4 (sqrt(4) is 2)
v=$(bc <<< "$v/4+3")      #v is 4 (4/4 = 1)
echo "2+2=$v"             #So v is 4...?
```

# Game2

```bash
# strings of length 2
x="ab"
y="cd"

# add lengths by concatenation
c="$(cat<<<$x; cat<<<$y)"

# display the lengths of the parts and the sum
echo "${#x} + ${#y} = ${#c}"
```

# Game3

```bash
# Create an array of ascending integers
a=({1..10})

# Use the sum to index into the array
s="2 + 2"
i=$(($s))
echo "$s = ${a[$i]}"
```


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

## B.1

# DONE
* Shbang
  * #!/usr/bin/env bash
  * DONE in minimal parsing
* Arrays
  * DONE at Chapter A
* Restore jupyter
  * DONE doing BaSh presentation
