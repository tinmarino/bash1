# vim: foldmethod=marker
: '
See some JAPH: http://www.cpan.org/misc/japh
Other JAPH links: https://github.com/renatolrr/Japh/tree/master?tab=readme-ov-file
'

# Stat {{{1

# View most frequently used commands {{{2
history | cut  -d ' ' -f 4  - | sort | uniq -i -c | sort -n

# View most frequently used words {{{2
file=res/secure_software_development_fundamentals.md 
tr -c a-zA-Z '\n' < "$file" | sed '/^.\{1,2\}$/d' | sort | uniq -i -c | sort -n


# Graphics {{{1
# Graphics: El efecto del caballero {{{2
while :;do for i in {1..20} {19..2};do printf "\e[31;1m%${i}s \r" █;sleep 0.02;done;done

# Graphics: vieja tv {{{2
P=(' ' █ ░ ▒ ▓);while :;do printf "\e[$[RANDOM%LINES+1];$[RANDOM%COLUMNS+1]f${P[$RANDOM%5]}";done

# Graphics: Math: Fractal de Madelbrot {{{2
# -- See: https://bruxy.regnet.cz/web/linux/EN/mandelbrot-set-in-bash/
p=\>\>14 e=echo\ -ne\  S=(S H E L L) I=-16384 t=/tmp/m$$; for x in {1..13}; do \
R=-32768; for y in {1..80}; do B=0 r=0 s=0 j=0 i=0; while [ $((B++)) -lt 32 -a \
$(($s*$j)) -le 1073741824 ];do s=$(($r*$r$p)) j=$(($i*$i$p)) t=$(($s-$j+$R));
i=$(((($r*$i)$p-1)+$I)) r=$t;done;if [ $B -ge 32 ];then $e\ ;else #---::BruXy::-
$e"\E[01;$(((B+3)%8+30))m${S[$((C++%5))]}"; fi;R=$((R+512));done;#----:::(c):::-
$e "\E[m\E(\r\n";I=$((I+1311)); done|tee $t;head -n 12 $t| tac  #-----:2 O 1 O:-

# Graphics: Matrix {{{2
(echo -e "\033[2J\033[?25l"; R=`tput lines` C=`tput cols`;: $[R--] ; while true
do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];for i in `eval $e {1..$R}`;
do c=`printf '\\\\0%o' $[RANDOM%57+33]` ### http://bruxy.regnet.cz/web/linux ###
$e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c; $s 0.1;if [ $i -ge $d ]
then $e "\033[$[i-d];${j}H ";fi;done;for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
do echo -e "\033[$i;${j}f ";$s 0.1;done)& sleep 0.05;done) #(c) 2011 -- [ BruXy ]


# Arith {{{1
# First prime number {{{2
# From: https://github.com/dylanaraps/codegolf
for((;j=i++<97;)){
let j+=i%{1..97}?0:1,j^3||echo $i
}

# Code that run only once {{{2
# WARNING: DO NOT RUN, destructive
# Source: https://codegolf.stackexchange.com/a/28698/85905
>"$0"

# Fun {{{1

# Musica: Bytebeat Mystery trans by VizNut 2011 {{{2
# -- See: https://www.youtube.com/watch?v=qlrs2Vorw2Y&t=151s
for((t=0;;t++));do((n=(
(t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)
), d=n%255,a=d/64,r=(d%64),b=r/8,c=r%8));printf '%b' "\\$a$b$c";done| aplay


### :e 
