# Dev Life Cycle

1. ShBang (#!/usr/bin/env bash) + safe mode (set -u)
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
5. Never backlist -> `$()`
6. Never `[`, never `test`, prefer the Bashism `[[`
7. Initialise all variable
8. Verify input argument
9. Verify required file actually exist with the correct permision => is reaable
10. Prefer absolute paths or start the locals with "./" to avoid the command to interpret them as arguments
11. Quote all parameter expansion
12. If cleanup is needed, use a trap
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
25. Keep it simple stupid KISS = make it easy
26. Do not repeat yourself (use named functions at least)


