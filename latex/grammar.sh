echo "1 2" 3 | { cat -; help; }
for i in "1 2" 3; do echo "$i" | cat -; done



select name [ in word ] ; do list ; done
case word in [ [(] pattern [ | pattern ] ... ) list ;; ] ... esac
until list-1; do list-2; done
# word < expression < command < list
