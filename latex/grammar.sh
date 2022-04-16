echo "1 2" 3 | { cat -; help; }
for i in "1 2" 3; do echo "$i" | cat -; done

if :; then :; elif :; then :; else :; fi

for name [ [ in [ word ... ] ] ; ] do list ; done  # while list-1; do list-2; done
if list; then list; [ elif list; then list; ] ... [ else list; ] fi

for (( expr1 ; expr2 ; expr3 )) ; do list ; done
select name [ in word ] ; do list ; done
case word in [ [(] pattern [ | pattern ] ... ) list ;; ] ... esac
until list-1; do list-2; done
# word
# expression
# command
# list
