

# TODO
* Hands on
  * ShowRunnginVersion to dict
  * Dispacher
  * MultiFAR
  * Multi-read-doc from file in //
* Fond naming convetion for functions and docstring
* Vim: Embed markdown syntax in docstring
* Quote in Quote
* Show local

# DOne


## A.1. Assignment

```bash
assignment_bad(){
  a = 42  # Err1
  b=a+1  # Err2
  c=a value is $a  # Err4
  print(c)  # Err5
}

assignment_good(){
  a=42  # Spaces count
  b=$(( a + 1 ))  # The default context is the string
  c="a value is $a"  # Spaces count
  echo $c  # Parenthesis -> Spaces
}
```

man bash / PARAMETERS
```text
A variable may be assigned to by a statement of the form

       name=[value]
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


## B.1

# DONE
* Shbang
  * #!/usr/bin/env bash
  * DONE in minimal parsing
* Arrays
  * DONE at Chapter A
* Restore jupyter
  * DONE doing BaSh presentation
