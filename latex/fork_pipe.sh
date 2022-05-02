shopt -s lastpipe; set +m  # permit last pipe command to execute in current shell; disable Monitor mode (i.e. job control)
{ echo -e "begin\ngrepme\nend" | tee /dev/fd/3 | sed -n '/grepme/p' | readarray -t a_filter; } 3>&1; echo "${a_filter[*]}"
