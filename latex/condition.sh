if true; then
  echo as simple as that
fi

if (( 1 > 1)); then echo no
elif [[ "$a" == toto ]]; then echo no
elif true; then echo yes
else echo no
fi

