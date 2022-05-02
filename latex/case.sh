parse_argument(){ while [[ "$#" -gt 0 ]]; do
case $1 in
  --ant) antenna=$2; shift ;;
  -v) verbose=1; ;;
  *) echo unknown argument; ;;
esac
shift; done; echo "antenna:$antenna, verbose:$verbose"; }
