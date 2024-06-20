#!/usr/bin/perl
use feature say;
 
for $j (1..9){
printf("%02d ", $_+$j*10) for (0..10); say
}
