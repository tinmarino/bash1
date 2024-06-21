#!/usr/bin/env bash
# vim: foldmethod=marker
: '
Challenge for the Bash Programming Language presentation
Execute lines independently

Use personal vim:
:Hide ,h
:Show ,s
:Send ,f
'


# Token y Espacios {{{1

# Asignment {{{2
# shellcheck disable=SC2283
a = 42  # Err1
# Fix: a=42
# Rem: Spaces count
# Rem: a = 42 ia:s command "a" recevings "=" and "42" as arguments

# Arithmetic {{{2
# shellcheck disable=SC2100
b=a+1  # Err2
# Fix: b=$(( a + 1 ))
# Rem: The __string__ context is the default context
# Rem: The arithmetic context starts with "((" in command and $(( in expression

# Concatenation {{{2
# shellcheck disable=SC2086
c=the value of a is $a  # Err3
# Fix: c="the value of a is: $a"
# Rem: Spaces count

# Command invocation
# shellcheck disable=SC1073,SC1065
#print(c)  # Err4  (commented for linter)
# Fix: echo "$c"
# Rem: Parenthesis previde array context (in asssignemt expression or subshell in command

# List declaration {{{2
#for ant in ("DV03", "antenna name with spaces"); do echo $ant; done  # Err5
# Fix: for s_ant in DV03 "antenna name with spaces"; do
# Fix:   echo "$s_ant"
# Fix: done
# Rem: Parenthesis | Comma -> Spaces
