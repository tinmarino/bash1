
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && snippet_stack "$@"

print_args(){
  ### Print input arguments, one per line
  local cnt=1
  for s_arg in "$@"; do
    echo "$((cnt++))/ $s_arg"
  done
}
