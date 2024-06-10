apache2 -X -d . -f apache-bash.conf

# apache2 -X -d . -f apache-bash.conf -C"PidFile `mktemp`"  -C"Listen 1025" -C"ErrorLog error.log" -C"DocumentRoot `pwd`"
