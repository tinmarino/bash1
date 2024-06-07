#!/usr/bin/env bash

#set -u


main(){
  mkfifo /tmp/task_pipe
  while true; do
    cat /tmp/task_pipe | {
      worker
    } | nc -l 8080 -q 1 | tee /tmp/task_pipe
  done
}

worker(){
  read -r input;
  #IFS='/' read -ra ADDR <<< "$REQUEST_URI"
  #args=$(IFS='&'; echo "${ADDR[1]}")
  #echo -e "HTTP/2 200 OK\r\nContent-Type: text/plain\r\n"
  input=${input% HTTP*}
  input=${input#* /}
  url_path=${input%%\?*}
  url_path=${url_path%%\?*}
  url_param=${input#*\?}
  IFS='&' read -ra a_param <<< "$url_param"
  >&2 echo "url_path: $url_path!"
  >&2 echo "url_param: $url_param!"

  : "
1/ GET 
2/ path1
3/ path2?param1=value1 HTTP
"
  arg1=$(clean_arg "${a_param[0]}")
  arg2=$(clean_arg "${a_param[1]}")

  if [[ -e "$url_path" ]]; then
    #echo -en "HTTP/2 200 OK\r\n\r\n"
    >&2 echo cat "$url_path"
    serve_file "$url_path"
    exit  # From subshell
  fi
  
  if [[ -z "$arg1" && -z "$arg2" ]]; then
    echo -e "HTTP/2 200 OK\r\nContent-Type: text/html\r\n"
    cat ./script/web/index.html
    exit  # From subshell
  fi


  if [[ "$url_path" == "api" ]]; then
    #cat /dev/stdin
    #env
    echo -e "HTTP/2 200 OK\r\nContent-Type: text/plain\r\n"
    >&2 print_args "${a_url[@]}"
    >&2 echo ./script/task-demo.sh "$arg1" "$arg2"
    ./script/task-demo.sh "$arg1" "$arg2"
  fi
}



serve_file() {
   # From https://github.com/avleen/bashttpd/blob/master/bashttpd
   local file=$1

   CONTENT_TYPE=
   case "$file" in
     *\.css)
       CONTENT_TYPE="text/css"
       ;;
     *\.js)
       CONTENT_TYPE="text/javascript"
       ;;
     *\.svg)
       CONTENT_TYPE="image/svg+xml"
       ;;
     *)
       read -r CONTENT_TYPE < <(file -b --mime-type "$file")
       ;;
   esac

   #add_response_header "Content-Type"   "$CONTENT_TYPE";
   echo -en "HTTP/2 200 OK\r\nContent-Type: $CONTENT_TYPE\r\n"

   read -r CONTENT_LENGTH < <(stat -c'%s' "$file")         && \
   echo  "Content-Length" "$CONTENT_LENGTH"

   echo

   cat "$file"
}

clean_arg(){
  local arg=$1
  arg=${arg%%\?*}  # Remove trailing parameters after "?"
  arg=$(trim_space "$arg")
  arg=$(urldecode "$arg")
  echo -n "$arg";
}

urldecode(){
  # From: https://stackoverflow.com/questions/6250698
  local url=${*//+/ }
  url=${url//+/ }   # Replace + to space
  url=$(echo -ne "${url//%/\\x}")  # Interpret percent encoded
  echo -n "$url"
}

trim_space() {
  : "${1#"${1%%[![:space:]]*}"}"
  : "${_%"${_##*[![:space:]]}"}"
  printf '%s\n' "$_"
}

main
