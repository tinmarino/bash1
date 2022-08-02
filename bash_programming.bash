#!/usr/bin/env bash
  # shellcheck disable=SC2016  # Expressions don't expand in single quotes, use double quotes for that
  # shellcheck disable=SC2046  # Quote this to prevent word splitting
  # shellcheck disable=SC2291  # Quote repeated spaces to avoid them collapsing into one

# +/ Introduction
  wiki 'BaSh Programming Table of Content
    -/ Introduction
    A/ Bash Shelling
    ----------------
      A.1/ Token and space
      A.2/ Interpolation and quote
      B.3/ Context and array
    B/ Bash Scripting
    -----------------
      B.1/ Function and scope
      B.2/ Introspection and builtins
      B.3/ Process control and job
    C/ Bash Programming
    -------------------
      C.1/ Life cycle and workflow
      C.2/ Binary and library
      C.3/ Program and asynchronism
    +/ Annex
  '

# A/ Bash Shelling
  a1_token_and_space(){
    : 'Parenthesis or Comma -> Space

    ```
    "man bash" Enter / "^SHELL GRAMMAR" Enter / "^ *A\s*simple\s*com\_.\{-}operator\." Enter
    A simple command  is  a sequence of optional variable assignments followed by blank-separated words and redirections, and terminated by a control operator
    ```
    Note the blank-separated

    ```
    ts "man bash" Enter / "^PARAMETERS" Enter / "^ *A\s*variable\s*may\_.\{-}value\]" Enter zz
    A variable may be assigned to by a statement of the form
    
           name=[value]
    ```
    '
    
    # Asignment
    # shellcheck disable=SC2283
    a = 42  # Err1
    # Fix: a=42
    # Rem: Spaces count
    # Rem: a = 42 ia:s command "a" recevings "=" and "42" as arguments

    # Arithmetic
    # shellcheck disable=SC2100
    b=a+1  # Err2
    # Fix: b=$(( a + 1 ))
    # Rem: The __string__ context is the default context
    # Rem: The arithmetic context starts with "((" in command and $(( in expression

    # Concatenation
    # shellcheck disable=SC2086
    c=a value is $a  # Err3
    # Fix: c="a value is $a"
    # Rem: Spaces count

    # Command invocation
    # shellcheck disable=SC1073,SC1065
    #print(c)  # Err4  (commented for linter)
    # Fix: echo $c
    # Rem: Parenthesis previde array context (in asssignemt expression or subshell in command

    # List declaration
    #for ant in ("DV03", "antenna name with spaces"); do echo $ant; done  # Err5
    # Fix: for s_ant in DV03 "antenna name with spaces"; do
    # Fix:   echo "$s_ant"
    # Fix: done
    # Rem: Parenthesis | Comma -> Spaces

    : 'ToRemember: 
    BaSh is a Shell languages
    The koken separator is the white space
    Imediate are imediates <= string oriented, macro
    '
  }

  a2_interpolation_and_quote(){
    wiki 'Interpolation: get variable values or command stdout
    Looks like macros in C

    | Token      | Substitution |
    | ---        | ---          |
    | ${ ... }   | Paramter     |
    | $( ... )   | Command      |
    | $(( ... )) | Arithmetic   |
    
    `"man bash" Enter "/^EXPANSION" Enter z2 Down Space "/^\s*The\s*order\_.\{-}\.$" Enter`
    "man bash" / SIMPLE COMMAND EXPANSION

    man bash / QUOTING
    man bash / EXPANSION / Quote Removal

    TODO basic interpolation
    TODO nested quote 
    TODO quote removal 
    '

    # Interpolation reference
    var=value; echo -e \
      \\n\
      -/ ----------------------------------------------------------\\n\
      1/ Brace Expansion'      ': {here,there}{_my,_your}{_poney,_house} \\n\
      2/ Tilde Expansion'      ': ~ \\n\
      3/ Parameter Expansion'  ': $var is ${var//va/b} \\n\
      4/ Command Substitution' ': $(printf "%s " {1..10}) \\n\
      5/ Arithmetic Expansion' ': $(( 90 * 2 / 3 - 18)) \\n\
      6/ Process Substitution' ': <(echo toto) \\n\
      7/ Word spliting'        ': many     whitespaces	tab and newlines\\n\
      8/ Pathname Expansion'   ': * \\n\
      9/ Quote Removal'        ': '' 'many     whitespaces' \\n\
      -/ ----------------------------------------------------------\\n


    # Multiple spaces
    a="1   2   3   4   5"
    # shellcheck disable=SC2086
    echo $a  # Err
    # Fix: echo "$a"

    # Hacky syntax (not intuitive at first)
    a="1   2   3   4   5"
    b=$a
    b="${a} is fine"
    echo "$b"
    b=$a echo "$b"  # Output ?

    a=42
    b="$(echo "$(echo "$(( a - 42 + "$(echo 5)" ))")")"
    echo "$b"  # Output ?

    # Nested command substitution 1
    file=${BASH_SOURCE[0]}
    file="/alma/ACS-2021NOV/CONTROL/avoid spaces in filenames.sh"
    echo "$(dirname "$(readlink -f $file)")/script/lib_alma.sh"  # Err
    # Fix: echo "$(dirname "$(readlink -f "$file")")/script/lib_alma.sh"
    # Fix: 
    # Fix: gs_root_path=$(readlink -f "$file")
    # Fix: gs_root_path=$(dirname "$gs_root_path")
    # Fix: echo "$gs_root_path"/script/lib_alma.sh
    : 'ToRemember
    Quote to prevent word expansion (except array)
    Do not quote if you want word expansion  (except array)
    Quote can be nested as long as there is an interpolation in between
    '

  }

  a3_context_and_array(){
    : 'A3: Everithing is relative ... to the execution context
    | Token      | Context      |
    | ---        | ---          |
    | [[ ... ]]  | String       |
    | (( ... ))  | Arithmetic   |
    | { ...; }   | Group        |
    | ( ...; )   | Subshell     |
    | " ... "    | Quoted       |
    | # ...      | Comment      |

    TODO  String and comment
    man bash / SHELL GRAMMAR / Compound Commands
    '

    if 1==1; then echo Yes; fi  # Err
    # Fix: if (( 1==1 )); then echo Yes; fi
    # Fix: if true; then echo Yes; fi
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
    #{ a=10 } [[ $a == 10 ]] && echo Yes  # Err (commented for linter)
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

    a=anything
    [[ anything == '$a' ]] && echo Yes  # Err
    # Fix: [[ anything == "$a" ]] && echo Yes

    : $'A3: Use "@" (not "*") and double quote it
    Ex: a_names=(Ruben "Maria Jesus"); printf "%s\n" "${a_names[@]}"

    TODO
    * copy
    * set -- and shift

    <= Only brace expansion, word splitting, and pathname expansion can increase the number of words of the expansion; other expansions expand a single word to a single word.
    <= The only exceptions to this are the expansions of "$@" and "${name[@]}",
    man bash / EXPANSION
    '

    print_args(){
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

    TODO Dictionaray alias associative arrays
  }

  
# B/ Basic Scripting
  b1_function_and_scope(){
    :
  }

  b2_introspection_and_builtin(){
    : $'
    man bash
    help
    compgen -b        # list builtins like help and compgen
    declare type      # real (user) introspection
    caller trap       # stack tracing and debugging
    set shopt ulimit uset
                      # configuring

    * Configuration
    * Workflow
    * TODO Roseta code

    man bash / SHELL BUILTIN COMMANDS
    man bash / PARAMETERS / Shell Variables
    '

    # Display possible completions
    compgen -c | grep -i gui  # c like command
    compgen -A "<press-tab>"  # With bash > 4.4 <= Alma is too old
    compgen -A function
    compgen -v
    # Rem: COMPletion GENerator
    # Rem: help compgen
    # Rem: man bash / SHELL BUILTIN COMMAND / compgne / complete / action

    # Declare variables and give them attributes
    declare     # all
    help declare
    declare -i -p  # Integer
    declare -a -p  # Array
    declare -A -p  # Dictionary (associative array)
    declare -F -p  # Function Because "declare -f" is showing the associated code
    declare -x -p  # eXport

    # Some features are accessible by both
    # For example the function list
    compgen -A function | sort
    declare -F -p | cut -d " " -f3 | sort

    # Code inspection
    toto(){ echo titi; }
    type toto

    # Stack tracing
    print_stack(){
      : 'Print current stack trace to stderr'
      local i=0
      local fstg="%1s/ %20s %20s %20s\n"
      >&2 printf "$fstg" "" Function File Line
      for i in "${!FUNCNAME[@]}"; do
        >&2 printf "$fstg" "$i" "${FUNCNAME[$i]}" "${BASH_SOURCE[$i]}" "${BASH_LINENO[$i]}"
      done
    }
    second(){ print_stack; }
    first(){ second; }
    first
    # Rem: I prefer 
    # Rem: Loop index: Could use ${#arr[@]} like in for i in $(eval echo "{0..$((${#arr[@]}-1))}")
  }

  b3_process_control_and_job(){
    : '
    * jobs TODO
    * wait TODO
    TODO job control
    '
  }


# C/ Bash Programming
  c1_life_cycle_and_workflow(){
    : 'C1: Software development life cycle

    Do not reivent the wheel, or for educative purposes
    Make it easy

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

    TODO reference
    '

    awk 'awk code TOREM 
    /asdasd/ {exit }
    '

    TODO Early return to decrease mental stack
    TODO Demo: A basic parser, and calculator
  }

  c2_binary_and_library(){
    :
  }

  c3_program_and_asynchornism(){
    :
  }


# +/ Annex
  annexe1_busybox_commands(){
    : '
    '
    a_cmd=(
      sed  # Big dady
      xargs  # Piper champion
      grep  # -> ripgrep
      rev  # To reverse characters (columns) of each line
      tac  # To reverse lines
      cut  # -d" " (delimiter) -f2-9 (from 2 to 9)
      date   #
      strace
    )
    for s_cmd in "${a_cmd[@]}"; do
      apropos -l "^$s_cmd$"
    done
  }

  annexe2_Links(){
    sed 'toto 
     s/asda\s*sd/sdasda/g
    '

    wiki '
      ## Books
      * [ABS: Advanced Bash Scripting](https://tldp.org/LDP/abs/abs-guide.pdf)
        * __The Bash reference__: An in-depth exploration of the art of shell scripting (by Mendel Cooper)
      * [TLPI: The Linux Programming Interface](https://sciencesoftcode.files.wordpress.com/2018/12/the-linux-programming-interface-michael-kerrisk-1.pdf)
        * __The Linux reference__: A Linux and UNIX System Programming Handbook  (by Michael Kerrisk)

      ## Documentation
      * [Object Oriented BaSh](https://stackoverflow.com/questions/36771080)
      * [Style for BaSh (google)](https://google.github.io/styleguide/shellguide.html)
      
      ## Code
      * [Rosetta Code](http://rosettacode.org/wiki/Bourne_Again_SHell)
      * [Bash Source code](git://git.savannah.gnu.org/bash.git)
      * [Pure BaSh Bible](https://github.com/dylanaraps/pure-bash-bible)
      * [Unicode math operators](http://xahlee.info/comp/unicode_math_operators.html)
      * [Bash syntax declaration (Bison)](https://github.com/bminor/bash/blob/bash-5.1/parse.y#L356-L372)
      * [Algorithm for prime number](https://programmingpraxis.files.wordpress.com/2012/09/primenumbers.pdf)
      * vim +"e \$VIMRUNTIME/syntax/sh.vim"
    '
  }
  
  
  
  TODO to README
      * Book: [The Linux Command Line (TLCL)](http://linuxclass.heinz.cmu.edu/doc/tlcl.pdf)
        by William Shotts
