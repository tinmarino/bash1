declare    string="a b"; echo "$string"
declare -i int=21; echo "$(( int * 2 ))"
declare -a array=(a "b c"); for string in "${array[@]}"; do echo "$string"; done
declare -A dict=([a]="b c" ["d e"]=f); for key in "${!dict[@]}"; do echo "$key: ${dict[$key]}"; done
