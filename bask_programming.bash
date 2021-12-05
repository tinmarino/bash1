#!/usr/bin/env bash

# A/ Take away
  a1_space(){
    : 'A1: Parenthesis or Comma -> Space

    ```
    A variable may be assigned to by a statement of the form
    
           name=[value]
    ```
    man bash / PARAMETERS
    '
    
    # Asignment
    a = 42  # Err1
    # Fix: a=42
    # Rem: Spaces count
    # Rem: a = 42 ia:s command "a" recevings "=" and "42" as arguments

    b=a+1  # Err2
    # Fix: b=$(( a + 1 ))
    # Rem: The __string__ context is the default context
    # Rem: The arithmetic context starts with "((" in command and $(( in expression

    c=a value is $a  # Err3
    Fix: c="a value is $a"
    # Rem: Spaces count

    # TODO
    #print(c)  # Err4
    # Fix: echo $c
    # Rem: Parenthesis previde array context (in asssignemt expression or subshell in command

    # TODO
    #for ant in ("DV03", "antenna name with spaces"); do echo $ant; done  # Err5
    # Fix: for s_ant in DV03 "antenna name with spaces"; do
    # Fix:   echo "$s_ant"
    # Fix: done
    # Rem: Parenthesis | Comma -> Spaces
  }

  a2_quote(){
    : 'A2: 
    man bash / EXPANSION / Quote Removal
    '

    a="1   2   3   4   5"
    echo $a  # Err
    # Fix: echo "$a"

    file="/alma/ACS-2021NOV/CONTROL/avoid put spaces in filenames.sh"
    echo "$(dirname "$(readlink -f $file)")/script/lib_alma.sh"  # Err
    # Fix: source "$(dirname "$(readlink -f "$file")")/script/lib_alma.sh"
    # Fix: 
    # Fix: # Source lib_alma even if this file is a symlink
    # Fix: gs_root_path=$(readlink -f "${BASH_SOURCE[0]}")
    # Fix: gs_root_path=$(dirname "$gs_root_path")
    # Fix: script_path="$gs_root_path"/script
    # Fix: source "$script_path"/lib_alma.sh
    
  }

  a3_context(){
    : 'A3: Everithing is relative ... to the execution context
    | Token      | Context      |
    | ---        | ---          |
    | [[ ... ]]  | String       |
    | (( ... ))  | Arithmetic   |
    | { ...; }   | Group        |
    | ( ...; )   | Subshell     |
    | " ... "    | Quoted       |

    man bash / SHELL GRAMMAR / Compound Commands
    '

    if 1==1; then echo Yes; fi  # Err
    # Fix: if (( 1==1 )); then echo Yes; fi
    # Fix: if true ; then echo Yes; fi
    # Rem: "if" is expected a command and "((" is the arithemtic compound command
    # Rem: man bash / ARITHMETIC EVALUATION

    toto=bakan titi=$toto
    (( toto == titi )) && echo "Yes $toto == $titi" || echo No  # Err
    # Fix: [[ toto == "$titi" ]] && echo Yes || echo No
    # Rem: Do not use string in arithmetic context
    # Rem: Beware autovivication in arithmetic context
    # Rem: (( _nodeclared1 == _notdeclared2 )); echo $?
    # Rem: El contexto arithmetico no cae mal con nadie

    s_with_spaces="toto is nice"
    [[ $s_with_spaces =~ "^toto" ]] && echo Yes || echo No  # Err  ( I want to check if start by toto )
    # Fix: [[ $s_with_spaces =~ ^toto ]] && echo Yes || echo No
    # Fix: rx="^toto is"; [[ "toto is nice" =~ $re ]]; echo $?
    # Rem: Do not be scared of unquoting immediates without spaces

    # Group
    { a=10 } [[ $a == 10 ]] && echo Yes  # Err
    # Fix: { a=10; }; [[ 10 == $a ]]; echo "$? <- $a"

    # Subshell
    ( a=11; ); [[ 11 == $a ]] && echo Yes  # Err
    # Fix: ( a=11; [[ $a == 11 ]]; ); echo "$? (expect 0) <- $a"
    # Fix: a=42 res=42
    # Fix: (
    # Fix:   res=0
    # Fix:   a=11
    # Fix:   [[ $a == 12 ]]
    # Fix:   ((res |= $?))
    # Fix:   echo "Inn: a=$a, res=$res, BASH_SUBSHELL=$BASH_SUBSHELL"
    # Fix:   exit "$res"  # In subshell
    # Fix: )
    # Fix: echo "Ret: $? (expect 1)"
    # Fix: echo "Out: a=$a, res=$res, BASH_SUBSHELL=$BASH_SUBSHELL"

    # TODO quoted
    a="
    echo "$()
  }

  a4_interpolation(){
    : 'A4: Interpolation: get variable and function values
    Looks like macros in C

    | Token      | Substitution |
    | ---        | ---          |
    | $( ... )   | Command      |
    
    man bash / EXPANSION
    man bash / SIMPLE COMMAND EXPANSION
    '

  }

  a5_array(){
    : 'A3: Use "@" (not "*") and double quote it
    Ex: a_names=(Ruben "Maria Jesus"); printf "%s\n" "${a_names[@]}"

    TODO
    * copy
    * set -- and shift

    <= Only brace expansion, word splitting, and pathname expansion can increase the number of words of the expansion; other expansions expand a single word to a single word.
    <= The only exceptions to this are the expansions of "$@" and "${name[@]}",
    man bash / EXPANSION
    '

    args(){
      for s_arg in $@; do  # Err1
        echo $((++cnt))/ $s  # Err2
      done
    }
    # Fix: args(){
    # Fix:   local cnt=1  # Fix2
    # Fix:   for s_arg in "$@"; do  # Fix1
    # Fix:     echo "$((cnt++))/ $s_arg"  # Fix2.2
    # Fix:   done
    # Fix: }
  }


  
# B/ Basic scripts
  b1_snippet(){
    : '
    man bash / SHELL BUILTIN COMMANDS
    '
    # TODO
    set -u

    : ' mutipleline
     fast comment
    '

    echo
    
  }

  b2_workflow(){
    : 'B1: Software development life cycle
    Demo: A basic parser, and calculator

    Disclaimer1: Do not reivent the wheel, or for educative purposes
    Disclaimer2: Make it easy

    1. Shbang + safe (set -u)
    2. Enclose in main
    3. Comment skeleton
    4. Baby steps
      * Code <-> Execute
      * In doubt, try minimal example in shell
      * Use template functions. Ex: tpl(){ : ; }
      * Print steps
      * No early optimisation
      * Document progressively (in usage or docstrings)
      * Use __Linter__
    5. See where it can fail
      * Local variables not leaking
      * External context not leaking
    6. Create a non-regression script
    7. Optimise => Goto 3/

    TOTO reference
    '

    awk 'awk code TOREM 
    /asdasd/ {exit }
    '
  }


# C/ Advanced tricks
  c1_introspection(){
    :'
    help
    compgen, declare, type
    caller
    set, shopt, ulimit, uset

    * Configuration
    * Workflow
    * TODO Roseta code

    man bash / SHELL BUILTIN COMMANDS
    man bash / PARAMETERS / Shell Variables
    '

    # TODO
    compgen -c | grep -i gui
    compgen -v
    compgen -A function
    compgen -A <tab>
    # Rem: COMPletion GENerator

    # TODO
    declare     # all
    help declare
    declare -i -p  # Integer
    declare -a -p  # Array
    declare -A -p  # Dictionary (associative array)
    declare -F -p  # Function Because "declare -f" is showing the associated code
    declare -x -p  # eXport

    # Demo TODO
    compgen -A function | sort
    declare -F -p | cut -d " " -f3 | sort

    # TODO type
    toto(){ echo titi; }
    type toto

    # TODO stack
    print_stack(){
      local i
      for i in "${!FUNCNAME[@]}"; do
        echo "$i/ Function:${FUNCNAME[$i]}, File:${BASH_SOURCE[$i]}, Line:${BASH_LINENO[$i]}"
        #echo -ne "$i/ "
        #caller "$i"
      done
    }
    f1(){ print_stack; }
    f2(){ f1; }
    # Rem: Loop index: Could use ${#arr[@]} like in for i in $(eval echo "{0..$((${#arr[@]}-1))}")

  }

  c2_dict(){
    : '
    '
  }

  c11_async1(){
    : '
    * jobs TODO
    * wait TODO
    TODO job control
    '
  }

  c12_async2(){
    : '
    TODO joc control
    '
  }


# Annexe
  annexe1_busybox_commands(){
    : '
    '
    a_cmd=(
      sed  # Big dady
      xargs  # Piper champion
      grep  # -> ripgrep
      rev  # To reverse characters (columns) of each line
      tac  # To reverse lines
    )
    for s_cmd in "${a_cmd[@]}"; do
      apropos -l "^$s_cmd$"
    done
  }

  annexe2_Links(){
    echo '
      * Book: [Advanced BaSh scripting Guide (ABS)](https://tldp.org/LDP/abs/abs-guide.pdf)
        __The reference__
        An in-depth exploration of the art of shell scripting
        By Mendel Cooper
      
      
      * Book: [The Linux Command Line (TLCL)](http://linuxclass.heinz.cmu.edu/doc/tlcl.pdf)
        by William Shotts
      
      * Post: [Object Oriented BaSh](https://stackoverflow.com/questions/36771080/creating-classes-and-objects-using-bash-scripting)
      
      * Program: [Jupyter BaSh kernel](https://github.com/takluyver/bash_kernel), and [jupyter-vim](https://github.com/jupyter-vim/jupyter-vim)
      
      * Code: [Rosetta Code](http://rosettacode.org/wiki/Bourne_Again_SHell)
    '
  }
