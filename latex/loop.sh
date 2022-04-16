for a in {1..15}; do
  for (( b=1; b<=15; b=b+1 )); do
    ((b >=a || b == 1)) && { printf "%4d" $((a*b)); } || { printf "    "; }
    continue || break  # here, break is never executed
  done; echo
done

while :; do echo $((i++)); done  # Press Ctrl-C to stop
