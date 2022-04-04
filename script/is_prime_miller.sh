#!/usr/bin/env bash
: '
'

set -u

is_in_array(){
  : 'Check if arg1 <string> is in rest of args
  Ref: https://stackoverflow.com/a/8574392/2544873
  '
  local element match="$1"; shift
  for element; do [[ "$element" == "$match" ]] && return 0; done
  return 1
}


power_mod(){
  : ' Calculate (x^y) [mod]
  Ref: Fermat at Rosetta code Python
  '
  local -i res=1

  # Parse in
  local -i x=$1
  local -i y=$2
  local -i mod=$3

  # Check in
  if is_in_array 0 "$x" "$y" "$mod"; then
    >&2 echo "Error: one given input is not a number" 
    >&2 echo "Tip: call me like power_mod 2 49 50"
    return 255
  fi

  # Initialize result

  while (( y )); do
    # If power is odd, then update the answer
    if (( y & 1 )); then
      (( res = (res * x) % mod ))
    fi

    # Square the number and reduce
    # the power to its half
    (( y = y >> 1 ))
    (( x = (x * x) % mod ))
  done

  # Return the result
  echo "$res"
  return 0
}

 
is_prime_miller(){  # Note: descriptive command name, may be same as script
  : ' Miller-Rabin primality test.

  Return:
    * 0 => is probably prime
    * 1 => is a composite number
    * 255 => error

  Impl: TODO
    
  >&2 echo "Debug: "

  Ref:
    Copied from: https://rosettacode.org/wiki/Miller%E2%80%93Rabin_primality_test#Python:_Probably_correct_answers
    Wiki: https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test
  '
  # Parse in
  local -i i_check=$1  # Note: local scope + integer declaration
  local -i i_loop=${2:-8}  # Note: default argument

  # Check in
  if (( 0 == i_check )); then
    >&2 echo "Error: given input ($i_check) is not a number" 
    >&2 echo "Tip: call me like is_prime_miller 12 8"
    return 255
  fi

  # Clause: Hard code composite optimisation
  is_in_array "$i_check" 0 1 4 6 8 9 && return 1
 
  # Clause: Hard code prime optimisation
  is_in_array "$i_check" 2 3 5 7 && return 0

  # Init local loop variable
  local -i i_s=0
  local -i i_d=$(( i_check - 1 ))  # Note: I can put space here so I use them for readability

  # Update local variable
  while (( i_d % 2 == 0 )); do
    (( i_d >>= 1 ))
    (( i_s += 1 ))
  done
  # Assert
  #>&2 echo "Debug: i_d=$i_d, i_s=$i_s"
  if (( 2**i_s * i_d !=  i_check - 1 )); then
    >&2 echo "Error: assertion failed $(( 2**i_s * i_d )) = $(( i_check - 1 ))"
    >&2 echo "Tip: this should never happen"
    >&2 echo "-- just a from dev to dev for doc and phase A verification"
  fi

  # Declare closure checker
  trial_composite(){  # Note: yes closures are allowed
    : ' Test at 1/4 probability if $1 is a prime
    Return:
      * 1 nop
      * 0 seems good
    '
    local -i i_a=$1
    # First check: a**d [n] ≡ 1 [n] (Fermat)
    local -i i_pow1=$(power_mod "$i_a" "$i_d" "$i_check")
    if (( i_pow1 == 1 || i_pow1 == i_check - 1 )); then
      return 0
    fi

    # Second check: avoid Fermat liars (alias Carmichael)
    # -- This is the Miller addition
    local -i i
    for i in $(seq "$i_s"); do
      if (( $(power_mod "$i_a" "$((2**i * i_d))" "$i_check") == i_check-1 )); then
         return 0
      fi
    done

    # Given number (i_check) is a composite with witness (i_a)
    return 1
  }

  # Loop check as loong as user asked
  local -i i
  for i in $(seq "$i_loop"); do
    local -i i_rand=$(( RANDOM % (i_check-2) + 2 ))
    #>&2 echo "Debug: $i_rand, $i_check"
    trial_composite "$i_rand" || return 1
  done

  # He passed all tests => seems prime
  return 0
}
