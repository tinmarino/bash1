# TODO fill others
cmd <<< "string"  # Redirect a single line of text to the stdin ofcmd. This is called a here-string.
cmd1 | cmd2 | cmd3 | cmd; echo ${PIPESTATUS[@]}  # Find out the exit codes of all piped commands.
cmd <(cmd1) <(cmd2)  # Redirect stdout ofarguments tocmd. cmd1andcmd2to two anonymous fifos, then pass both fifos as
