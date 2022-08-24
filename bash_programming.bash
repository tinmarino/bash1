#!/usr/bin/env bash
  # shellcheck disable=SC2016  # Expressions don't expand in single quotes, use double quotes for that
  # shellcheck disable=SC2046  # Quote this to prevent word splitting
  # shellcheck disable=SC2291  # Quote repeated spaces to avoid them collapsing into one
  # shellcheck disable=SC2059  # Don't use variables in the printf format string

# +/ Introduction
  : 'BaSh, the Linux shell (GNU 1989)
    -/ Introduction
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
    : 'Interpolation: store values, results in variables
    Bash looks like a macro programming language.
    Macro replacement is called substitution

    | Token      | Substitution |
    | ---        | ---          |
    | ${ ... }   | Paramter     |
    | $( ... )   | Command      |
    | $(( ... )) | Arithmetic   |

    ```tmux
    ts "man bash" Enter "/^EXPANSION" Enter z2 Down Space "/^\s*The\s*order\_.\{-}\.$" Enter
    ts "man bash" Enter "/^SIMPLE COMMAND EXPANSION" Enter
    ts "man bash" Enter "/QUOTING" Enter
    ts "man bash" /EXPANSION / Quote Removal
    ```
    '

    #
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
    # shellcheck disable=SC2097,SC2098
    b=$a echo "$b"  # Output ?

    a=42
    # shellcheck disable=SC2116,SC2005
    b="$(echo "$(echo "$(( a - 42 + "$(echo 5)" ))")")"
    echo "$b"  # Output ?

    a=anything
    # shellcheck disable=SC2050
    [[ anything == '$a' ]] && echo Yes  # Err
    # Fix: [[ anything == "$a" ]] && echo Yes

    # Nested command substitution 1
    file=${BASH_SOURCE[0]}
    file="/alma/ACS-2021NOV/CONTROL/avoid spaces in filenames.sh"
    # shellcheck disable=SC2086
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
    : 'Everithing is relative ... to the execution context
    | Token      | Context      |
    | ---        | ---          |
    | [[ ... ]]  | String       |
    | (( ... ))  | Arithmetic   |
    | { ...; }   | Group        |
    | ( ...; )   | Subshell     |
    | " ... "    | Quoted       |
    | # ...      | Comment      |

    TODO  String and comment
    ts "man bash" Enter  "/^SHELL GRAMMAR" Enter "/Compound Commands" Enter zt
    '

    # shellcheck disable=SC2272
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
    # shellcheck disable=SC2030
    ( a=11; )
    # shellcheck disable=SC2053,SC2031
    [[ 11 == $a ]] && echo Yes  # Err
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

    : 'Use "@" (not "*") and double quote it
    Ex: a_names=(Ruben "Maria Jesus"); printf "%s\n" "${a_names[@]}"

    TODO
    * copy
    * set -- and shift

    <= Only brace expansion, word splitting, and pathname expansion can increase the number of words of the expansion; other expansions expand a single word to a single word.
    <= The only exceptions to this are the expansions of "$@" and "${name[@]}",
    man bash / EXPANSION
    '

    print_args(){
      # shellcheck disable=SC2068
      for s_arg in $@; do  # Err1
        # shellcheck disable=SC2086
        echo $((++cnt))/ $s_arg  # Err2
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


# B/ Bash Scripting
  b1_function_and_scope(){
    : 'Put all code in function
    Take care of positional arguments
    '

    # Everything is global
    var=1
    fct(){ var=2; }  # Err
    fct; echo "$var"
    # Fix: fct(){ local -i var=2; }
  }

  b2_introspection_and_builtin(){
    : 'Where do I come from, where am I, where do I go
    ts "man bash" Enter "/^SHELL BUILTIN COMMANDS" Enter zt z3

    TODO
    declare type      # real (user) introspection

    man bash / PARAMETERS / Shell Variables
    '

    # Hi
    help
    compgen -b        # List builtins like help and compgen
    man bash

    # Display possible completions
    compgen -c | grep -i gui  # c like command
    compgen -A "<press-tab>"  # With bash > 4.4 <= Alma is too old
    compgen -A function
    compgen -v
    # Rem: COMPletion GENerator
    # Rem: help compgen
    # Rem: man bash / SHELL BUILTIN COMMAND / compgne / complete / action

    # Declare variables and give them attributes
    # -- Or print what defined variable is in scope
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

    # Variable inspection
    unset a b c d
    declare -i a=1
    declare    b=value
    # shellcheck disable=SC2034
    declare -a c=(2 3)
    # shellcheck disable=SC2034
    declare -A d=([4]=5 [6]=7 [eight]=9 ['and 10']=11)
    for s in a b c d; do declare -p "$s"; done

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

    # Also see
    # caller trap       # stack tracing and debugging
    # set shopt ulimit uset

    : 'ToRemember
    type fct  # fct(){ :; }
    declare -p var   # var=value
    '
  }

  b3_process_control_and_job(){
    : '
    * [SO: subcmd wait and return](https://stackoverflow.com/questions/356100)
    * [SO: subcmd capture stdout](https://stackoverflow.com/questions/20017805)
    '

    # Define a worker function
    worker(){
      : 'Special 12 and 13'
      local -i num=${1:-0} i=0
      local -i color=$((num % 5 + 30))
      if (( 12 == num )); then return 42; fi
      if (( 13 == num )); then while :; do echo -e "worker \e[1m\e[${color}m$num\e[0m: working $((i++))."; sleep 1; done; return 0; fi
      for i in {1..5}; do
        echo -e "worker \e[1m\e[${color}m$num\e[0m: working $i/5."
        sleep 0.1
      done
    }
    worker 1

    # Fork like irresponsible parent
    multiwork1(){
      declare id=''

      echo -e "\nForking"
      for id; do
        worker "$id" &  # <----- Here is async
      done

      echo -e "\nJoining"
      wait

      echo -e "MultiWork1 Over"
    }
    multiwork1 {1..3}


    # But a good parent, never abandon his children
    # -- So he can know exit status, pending jobs and kill them
    # -- Note that jobs -l (list) or jobs -p (pid) is also printing the PID
    multiwork2(){
      declare id=''
      declare -gA d_pid=() d_ret=()

      echo -e "\nForking"
      for id; do
        worker "$id" &     # <----- Here is async
        d_pid[$id]=$!
        echo "PID of $id is ${d_pid[$id]}"
      done

      echo -e "\nJoining"
      for id; do
        wait "${d_pid[$id]}"
        d_ret[$id]=$?
        echo "Returned id:$id status:${d_ret[$id]}"
      done

      echo "Summary: ${d_pid[*]} | Ret: ${d_ret[*]}"
      echo -e "MultiWork2 Over"
    }
    multiwork2 {1..3}


    # But he can also get the exit status an stdout of each one
    multiwork3(){
      declare id=''
      declare -gA d_pid=() d_ret=() d_out=()
      declare -i i_fd=100

      echo -e "\nForking"
      i_fd=100
      for id; do
        eval "exec $i_fd< <(worker \"$id\")"  # <----- Here is async
        d_pid[$id]=$!
        echo "PID of $id is ${d_pid[$id]}"
        (( i_fd++ ))
      done

      echo -e "\nJoining"
      i_fd=100
      for id; do
        echo WAIT
        wait "${d_pid[$id]}"; d_ret[$id]=$?  # Wait for status
        echo REEAD
        d_out[$id]=$(cat <&$i_fd)  # Wait for stdout
        echo "Returned id:$id   status:${d_ret[$id]}   fd:$i_fd   stdout:${d_out[$id]//$'\n'/:}"
        (( i_fd++ ))
      done

      echo -e "\nClosing"
      i_fd=100
      for id; do
        eval "exec $i_fd<&-"
        (( i_fd++ ))
      done

      echo "Summary: ${d_pid[*]} | Ret: ${d_ret[*]} | Out: ${d_out[*]//$'\n'/:}"
      echo -e "MultiWork3 Over"
    }
    multiwork3 {1..3}


    # Use file descriptor
    : > /tmp/file       # Chonk hard file
    exec 3<> /tmp/file  # Open fd 3
    echo value >&3      # Write to fd
    cat <&3             # Read from fd 3
    exec 3>&- #close fd 3.


    # File descriptor auto allocation
    { echo toto | tee "/dev/fd/$fd"; } {fd}>&1
      
      
    # G generic tip: you can just catch the output of subcommands
    # From: https://stackoverflow.com/a/16292136/2544873
    exec {fd1}>&1
    out1=$(worker 1 | tee "/dev/fd/$fd1")
    exec {fd1}>&-
    echo "$out1"
    
    # Also:
    worker 1 | tee /dev/tty
    worker 2 | tee >(cat - >&{fd})
    
    : 'ToRemember:
    * Harvest the pid of your children with `$!`
    * Harvest the stdout of your children. Fork it to the initial stdout with shell-wide redirection with `exec`
    * At fork: Do not suppose everything is gonna be all
    * At fork: Identify variable shared between parent and children. See ICT-18698 surprises: acacorr_cleaner async.
    '
  }


# C/ Bash Programming
  c1_life_cycle_and_workflow(){
    : 'C1: Software development life cycle

    1. ShBang + safe (set -u)
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

    # Tips


    1. Use ShBang
    2. Use clauses (early returns)
      * __FAIL FAST__ and be aware of exit codes.
    3. Use functions
    4. Use typed variable
    5. Never backtickst -> `$()`
    6. Never `[`, never `test` -> `[[`
    7. Initialise all variable
    8. Verify input argument
    9. Verify required file actually exist with the good rights
    10. Prefer absolute paths
    11. Quote all parameter expansion
    12. Always cleanup with a trap
    13. Try to localize shopt usage and disable option when finished.
    14. Use Bash variable substitution if possible before awk/sed.
    15. Dont be afraid of printf, it iss more powerful than echo.
    16. Use .sh or .bash extension if file is meant to be included/sourced. Never on executable script.
    17. When expecting or exporting environment, consider namespacing variables when subshells may be involved.
    18. Decrease complexity and indentation level
    19. Do not reivent the wheel, or for educative purposes
    20. Comment
    21. Name variable and function properly (meaningfull)
    22. Use stderr if it is for human (an redirect stderr)
    23. Make it both time library and binary
      * `[[ “$0” == “$BASH_SOURCE” ]] && main “$@”`
      * `(return 0 2>/dev/null) ||  main “$@”`
    24. Be consistent
    25. Make it easy

    TODO Demo: A basic parser, and calculator
    '

    awk 'awk code TOREM
    /asdasd/ {exit }
    '
  }

  c2_binary_and_library(){
    :
  }

  c3_program_and_asynchornism(){
    :
  }


# +/ Annex
  annexe1_busybox_commands(){
    : 'BusyBox - The Swiss Army Knife of Embedded Linux
    '
    a_cmd=(
      sed    # Big dady
      # Pipe
      tee    # Duplicate stream
      xargs  # Run command for each parameter
      grep   # Regex filter (better use ripgrep)
      rev    # Reverse columns (characters)
      tac    # Reverse lines
      cut    # Fast column filter -d" " (delimiter) -f2-9 (from 2 to 9)
      # Operation
      timeout  # Run command with a timeout
      date   # Time operation
      bc     # Math operation
      nc     # Network operation (HTTP)
      strace # Kernel operations
    )
    for s_cmd in "${a_cmd[@]}"; do
      apropos -l "^$s_cmd$"
    done
  }

  annexe2_Links(){
    sed '
     s/asda\s*sd/sdasda/g
    '

    : '
      # Program
      * [Shellcheck](https://github.com/koalaman/shellchec)
      * [Vim / ALE](https://github.com/dense-analysis/ale)
      * [Vim / Slime](https://github.com/jpalardy/vim-slime)
      * [Tmux](https://github.com/tmux/tmux)
      * [Dotfiles (my)](https://github.com/tinmarino/vimfiles/tree/master/dotfile)

      # Books
      * [ABS: Advanced Bash Scripting](https://tldp.org/LDP/abs/abs-guide.pdf)
        * __The Bash reference__: An in-depth exploration of the art of shell scripting (by Mendel Cooper)
      * [TLPI: The Linux Programming Interface](https://sciencesoftcode.files.wordpress.com/2018/12/the-linux-programming-interface-michael-kerrisk-1.pdf)
        * __The Linux reference__: A Linux and UNIX System Programming Handbook  (by Michael Kerrisk)

      # Documentation
      * [Object Oriented BaSh](https://stackoverflow.com/questions/36771080)
      * [Google Style for BaSh](https://google.github.io/styleguide/shellguide.html)

      # Code
      * [Rosetta Code](http://rosettacode.org/wiki/Bourne_Again_SHell)
      * [Bash Source code](git://git.savannah.gnu.org/bash.git)
      * [Pure BaSh Bible](https://github.com/dylanaraps/pure-bash-bible)
      * [Unicode math operators](http://xahlee.info/comp/unicode_math_operators.html)
      * [Bash syntax declaration (Bison)](https://github.com/bminor/bash/blob/bash-5.1/parse.y#L356-L372)
      * [Algorithm for prime number](https://programmingpraxis.files.wordpress.com/2012/09/primenumbers.pdf)
      * vim +"e \$VIMRUNTIME/syntax/sh.vim"
    '
  }
