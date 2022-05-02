for i in {0..9}; do ((i_fd=i+100))
   "exec $i_fd< <(echo message \"$i_fd\")"
done  `\small{\# Fork 10 subprocess}`

for i in {0..9}; do ((i_fd=i+100))
  a_out[$i]=$(cat <&"$i_fd")
done  `\small{\# Join and collect output}`

IFS=$'\n' echo "${a_out[*]}"  `\small{\# Print all outputs}`
