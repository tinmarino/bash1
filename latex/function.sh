func(){
  for i; do echo "$((j++)): $i|"; done
}

func a "b c"
