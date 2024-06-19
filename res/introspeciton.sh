help
compgen -b        # List builtins like help and compgen
man bash

# Display possible completions
compgen -c | grep -i gui  # c like command
compgen -A "<press-tab>"  # With bash > 4.4
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
declare -fp toto

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
