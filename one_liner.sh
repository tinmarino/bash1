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



# Fun {{{1

# Musica 3: Bytebeat VizNut 2011 {{{2
# -- Esta melodia la llame "Mysterie trans".
for((t=0;;t++));do((n=(
(t>>7|t|t>>6)*10+4*(t&t>>13|t>>6)
), d=n%255,a=d/64,r=(d%64),b=r/8,c=r%8));printf '%b' "\\$a$b$c";done| aplay

# vim: foldmethod=marker
