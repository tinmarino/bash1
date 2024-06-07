#!/usr/bin/env bash
# BaSh server with Netcat
#
# Home: https://github.com/tinmarino/abache
# Thanks: moshe


# Define HTTP header <- windows like and finish with 2 newlines
HEADER="HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Cache-Control: no-cache
Connection: close
Server: Abache
Date: $(date)

"

# Hardcode the html <head> tag
read -r -d '' HEAD <<'EOF'
<html lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title>BFS: Bash FileServer</title>
  <meta name="description" content="BaSh HTTP FileServer like python -m http.server\nFor teaching purpose">
  <meta name="author" content="Tinmarino">
</head>
EOF

serve_file(){
  # <- FILEPATH -> CONTENT
  if command -v bat &> /dev/null &&  command -v ansi2html &> /dev/null; then
    CONTENT="$(bat --style plain --theme "ansi-dark" --color always --pager "" "$FILEPATH" | ansi2html)"
  else 
    CONTENT="<pre>$(cat "$FILEPATH" < /dev/null)</pre>"
  fi
}

serve_dir(){
  # <- FILEPATH -> CONTENT
  # shellcheck disable=SC2086  # Double quote to prevent globbing
  read -r -d '' CONTENT <<EOF
$HEAD
<body>\n<table>\n
<tr>\n<td>Name</td><td>Size (bytes)</td></tr>
<tr>\n<td><a href="..">..</a></td><td></td></tr>
$(stat --printf='<tr>\n<td><a href="/%n">%n<a/></td><td>%s</td></tr>\n' $FILEPATH/*)
</tr>\n</table>\n</body>\n</html>\n
EOF
}

# Get port <- command line
if [[ -n "$1" ]]; then PORT=$1 ; else PORT=8080 ; fi
echo "Abache listening on port $PORT"

# Create FIFO (alias NamedPipe)
FIFO_FILE=/tmp/abache
[[ -p $FIFO_FILE ]] && rm $FIFO_FILE
mkfifo $FIFO_FILE

# Serve always
while true; do
  # shellcheck disable=SC2002  # Useless cat
  cat "$FIFO_FILE" | nc -l $PORT -q 1 | while read -r line; do
    # Log
    >&2 echo "Get: at $(date)  $line"

    # Clause: Only respond to GET
    if ! echo "$line" | grep -q '^GET '; then continue; fi

    FILEPATH=$(echo "$line" | awk '{print $2}'| sed 's/%20/ /')
    FILEPATH=${FILEPATH:1}
    FILEPATH=${FILEPATH%%\?*}

    [[ -z "$FILEPATH" ]] && FILEPATH="."
    CONTENT="Error 404: Bad URL <= $FILEPATH"

    # Send file or direcotry content
    if [[ -e "$FILEPATH" ]];  then
      if [[ -f "$FILEPATH" ]]; then serve_file; else serve_dir; fi
    fi
    echo -e "$HEADER$CONTENT" > $FIFO_FILE
    break
  done
done
