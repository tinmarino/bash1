: '
Top 10 perl obfus:
http://www.perlmonks.org?node_id=1110292 
'


# Madelbrot zoomer Perl

# http://www.perlmonks.org/?node_id=329492
perl -e '
 $r=25; $c=80;
                                              $xr=6;$yr=3;$xc=-0.5;$dw=$z=-4/
                                              100;local$";while($q=$dr=rand()
                                             /7){$w+=$dw;$_=join$/,map{$Y=$_*
                                             $yr/$r;
  join""                                    ,map{$                  x=$_*$
 xr/$c;($                                   x,$y)=                 ($xc+$x
  *cos($                                   w)-$Y*               sin$w,$yc+
                                           $x*sin              ($w)+$Y*cos
  $w);$                                   e=-1;$                    a=$b=0
;($a,$b)   =($u-$v+$x,2*$a*               $b+$y)                    while(
$ u=$a*$   a)+($v=$b*$b)<4.5  &&++$e     <15;if                     (($e>$
  q&&$e<   15)||($e==$q and   rand()     <$dr))  {$q=$e;($d0,$d1)   =($x,$
  y); }                        chr(+(   32,96,+  46,45,43,58,73,37  ,36,64
 ,32)[$                        e/1.5]   );}(-$   c/2)..($c/2)-1;}   (-$r/2
 )..($     r/2)-1;select$",     $",$", 0.015;                       system
$^O=~m     ~[wW]in~x?"cls":     "clear";print                       ;$xc=(
$d0+15     *$xc)/16;$yc=($       d1+15*$yc)/                        16;$_*=
1+$z for                         $xr,$yr;$dw                     *=-1 if rand
()<0.02;                          (++$i%110                      )||($z*=-1)}
'

# Fun with reserved keywords
# https://www.perlmonks.org/?node_id=290607
# Explanation: https://stackoverflow.com/questions/14440594/how-does-this-famous-japh-work
perl -e '
not exp log srand xor s qq qx xor
s x x length uc ord and print chr
ord for qw q join use sub tied qx
xor eval xor print qq q q xor int
eval lc q m cos and print chr ord
for qw y abs ne open tied hex exp
ref y m xor scalar srand print qq
q q xor int eval lc qq y sqrt cos
and print chr ord for qw x printf
each return local x y or print qq
s s and eval q s undef or oct xor
time xor ref print chr int ord lc
foreach qw y hex alarm chdir kill
exec return y s gt sin sort split
'


# Camel code
perl ./script/camel_code.pl
