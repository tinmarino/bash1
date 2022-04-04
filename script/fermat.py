# Python3 program to check if N is Fermat pseudoprime
# to the base A or not
 
from math import sqrt
 
# Function to check if the given number is composite
def checkcomposite(n):
     
    # Check if there is any divisor of n less than sqrt(n)
    for i in range(2,int(sqrt(n))+1,1):
        if (n % i == 0):
            return 1
    return 0
 
def power(x, y, mod):
    """ Calculate (x^y) [mod] """
    # Initialize result
    res = 1
 
    while (y):
        # If power is odd, then update the answer
        if (y & 1):
            res = (res * x) % mod
 
        # Square the number and reduce
        # the power to its half
        y = y >> 1
        x = (x * x) % mod
 
    # Return the result
    return res
 
def Check(n,a):
    """ Check for Fermat Pseudoprime """
    # If it is composite and satisfy Fermat criterion
    if (a>1 and checkcomposite(n) and power(a, n - 1, n) == 1):
        return True
 
    # Else return 0
    return False
