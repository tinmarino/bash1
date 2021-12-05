#!/usr/bin/env bash

# A/ Take away
  a1_space(){
    : 'A1: Parenthesis or Comma -> Space

    <= A variable may be assigned to by a statement of the form
    <= 
    <=        name=[value]
    man bash / PARAMETERS
    '
    
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

    print(c)  # Err4
    # Fix: echo $c
    # Rem: Parenthesis previde array context (in asssignemt expression or subshell in command

    for ant in ("DV03", "antenna name with spaces"); do echo $ant; done  # Err5
    # Fix: for s_ant in DV03 "antenna name with spaces"; do
    # Fix:   echo "$s_ant"
    # Fix: done
    # Rem: Parenthesis | Comma -> Spaces
  }

  a2_context(){
    : 'A2: Everithing is relative ... to the execution context
    | Token     | Context     |
    | ---       | ---         |
    | [[ ... ]] | String      |
    | (( ... )) | Arithmetic  |
    | { ...; }  | Group       |
    | ( ...; )  | Subshell    |
    | " ... "   | Quoted      |
    
    * Interpolation
    * Context evaluation
    * Macro like

    man bash / EXPANSION
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
  }

  a3_array(){
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
  
  a5_introspection(){
    :'
      * Configuration
      * Workflow
      * TODO Roseta code

    man bash / SHELL BUILTIN COMMANDS
    man bash / PARAMETERS / Shell Variables
    '

    # TODO
    set -u

    toto(){ echo titi; }
    type toto

    # TODO
    compgen -c | grep -i gui
    # Rem: COMPletion GENerator
  }
  
# B/ Basic scripts
  b1_workflow(){
    : 'B1: Software development life cycle
    Demo: A basic parser, and calculator

    1. Shbang + safe (set -u)
    2. Enclose in main
    3. Comment skeleton
    4. Baby steps
      4.1 Code <-> Execute
      4.2 In doubt, try minimal example in shell
      4.3 Use template functions. Ex: tpl(){ : ; }
      4.4 Print steps
      4.5 No early optimisation
      4.6 Document progressively (in usage or docstrings)
      4.7 Use Linter
    5. See where it can fail
      5.1 Local variables not leaking
      5.2 External context not leaking
    6. Create a non-regression script
    7. Optimise => Goto 3/

    TOTO reference
    '
  }


# C/ 

# Annexe
  annexe1_busybox_commands(){
    echo '
      * sed
      * grep -> ripgrep
      * 
    '

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
