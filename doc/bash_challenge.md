# Syntax


# Normal

# Hard

### 2+2
https://codegolf.stackexchange.com/questions/28786/write-a-program-that-makes-2-2-5

```bash
# For people who don't know Bash: $((...expr...)) is a syntax to evaluate arithmetic expressions. $(bc<<<...expr...) does the same using the bc command-line calculator.
v=2                       # v is 2
v+=2                      # v is 4
v=$((v * 5))              # v is 20
v=$((v - 16))             # v is 4
v=$(bc <<< "sqrt($v)+2")  # v is 4 (sqrt(4) is 2)
v=$(bc <<< "$v/4+3")      # v is 4 (4/4 = 1)
echo "2+2=$v"             # So v is 4...?
```

# String lenght

```bash
# strings of length 2
x="ab"
y="cd"

# add lengths by concatenation
c="$(cat<<<$x; cat<<<$y)"

# display the lengths of the parts and the sum
echo "${#x} + ${#y} = ${#c}"
```

# Game3

```bash
# Create an array of ascending integers
a=({1..10})

# Use the sum to index into the array
s="2 + 2"
i=$(($s))
echo "$s = ${a[$i]}"
```
