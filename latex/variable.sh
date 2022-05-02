declare    `\color{dark0}\LARGE{string}`="a b"; echo "$string"
declare -i `\color{dark0}\LARGE{int}`=21; echo "$(( int * 2 ))"
declare -a `\color{dark0}\LARGE{array}`=(a "b c"); for string in "${array[@]}"; do echo "$string"; done
declare -A `\color{dark0}\LARGE{dict}`=([a]="b c" ["d e"]=f); for key in "${!dict[@]}"; do echo "$key: ${dict[$key]}"; done
