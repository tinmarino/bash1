

# Introduction

* Enseñansas: Base de programacion, especifiades de Bash
* Objectivo: Usar Bash como un lengague de programación y no de scripting.

* [Archivo: fun with one liners](./one_liner.sh)

# 1/ Historia de Shell
## 1.1/ Donde esta la Shell?

### Los niveles de virtualisación

```bash
pstree --color=age -sp $$
```

### Los niveles de abstración de los lenguages

* Ver [archivo dibujo de los niveles](./res/draw-rings.txt)

| Nivel             | Lenguage     | Descripción |
| ----------------- | ------------ | --------------------- |
| Shell             | Bash         | Linux |
|                   | Powershell   | Windows |
|                   | Zsh          | Mac |
| ----------------- | ------------ | --------------------- |
| Interpretado      | Python       | Multiuso, legible y popular |
|                   | Perl         | Procesamiento de texto |
|                   | PHP          | Web backend |
|                   | Javascript   | Web frontend |
| ----------------- | ------------ | --------------------- |
| Intermediario     | Java         | Oracle: Aplicaciones empresariales |
|                   | C#           | Microsft: Aplicaciones Microsoft |
|                   | Go           | Google: Aplicaciones concurrentes |
|                   | Haskell      | Lenguaje funcional |
| ----------------- | ------------ | --------------------- |
| Systema           | C, C++       | La base de todo |
|                   | Rust         | Mas seguro que C |
| ----------------- | ------------ | --------------------- |
| Maquina           | Assembly     | Lenguajes de los procesadores |
| ----------------- | ------------ | --------------------- |
| Hardware          | VHDL         | Lenguaje de descripción de hardware |
|                   | Verilog      |   |




## 1.2/ Cuando esta la Shell?

### Maquina universal de Turing: 1936
* [wiki](https://es.wikipedia.org/wiki/M%C3%A1quina_de_Turing)

```text
+---------------------------------------------------+
| X | X | X | Y | Z | Z | X | Y | X | Z | X | Z | X |
+---------------------------------------------------+
                      ^
```

1. Avanzar una Celda
2. Retroceder una Celda
3. Escribir un Símbolo
4. Leer un Símbolo
5. Cambiar de Estado


### Problema de la parada: 1936
* [wiki](https://es.wikipedia.org/wiki/Problema_de_la_parada)

```python
def Termina(f):
    """ Supongamos que aquí
       se encuentra un código maravilloso 
       que soluciona el problema de la parada.
       Esta función regresa True si la función f termina o False en otro caso
    """

def Diagonal(f):
    # Si termina ...
    if Terminal(f):
        # ... Sigue infinitmente
        while True: pass
    # Si NO termina ...
    else:
        # ... Termina
        return
        
Diagonal(Diagonal)  # Ya Chao Turing
```


### Máquina analítica de Babbage: 1837
* [wiki](https://en.wikipedia.org/wiki/Turing_machine#Historical_background:_computational_machinery)
| N | Operacion   | Ejemplo |
| - | ---         | --- |
| 1 | Calculación | +, -, x |
| 2 | Composición | { inst1; inst2; } |
| 3 | Iteración   | for i in {1..10]; do inst1; done |
| 4 | Condición   | if inst1; then inst2; fi |
| 5 | Redirección | goto label1 |


### Maquina de Von Neuman: 1945
* [wiki](https://en.wikipedia.org/wiki/Von_Neumann_architecture)

```text
              +----------------+
              | +------------+ |
+-------+     | |            | |     +--------+
|       |     | | Procesador | |     |        |
| Input |---->| |            | |---->| Output |
|       |     | +------------+ |     |        |
+-------+     |     |   ^      |     +--------+
              |     |   |      |
              |     v   |      |
              | +------------+ |
              | |            | |
              | | Memoria    | |
              | |            | |
              | +------------+ |
              +----------------+
```


### La epoca Unix: 1970

```bash
TZ=NGT date -d @0 +"%a, %d %b %Y %H:%M:%S GMT"
# Thu, 01 Jan 1970 00:00:00 GMT
```

### El mundo moderno: 1990 .. presente

| Novedad | Descripción |
| ---     | --- |
| Bash    | nuevo shell |
| WWW     | internet |
| UTF8    | caracteres unicode |
| GPU     | tarjeta grafica |


# 2/ Commandos de Shell
## 2.1/ Sentencias (statements)

### Documentacion de comandos simples

```bash
# Compound command
ts "man bash" Enter  "/^SHELL GRAMMAR" Enter "/Compound Commands" Enter zt
# Assigment 
ts "man bash" Enter / "^PARAMETERS" Enter / "^ *A\s*variable\s*may\_.\{-}value\]" Enter zz
```


### Ejemplos de comandos simples

```bash
echo 'Hola colega!'                   # Simple Command
echo 'Hola colega!' | sed 's/a/A/g'   # Pipe
echo 'Hola colega!'; echo 'Que tal?'  # Statement List
msg='Hola colega!'; echo "$msg"       # Assignement & Expansion
echo 'Hola colega!' > /tmp/msg        # Redirection stdout
sed 's/a/A'g < /tmp/msg               # Redirection stdin
(( a = 21 * 2 )); echo "$a"           # Arithmetica
```


## 2.2/ Parafos (composed statements)

### Condición: If

```bash
ts "man bash" Enter / "^\s*if\s*list\_.\{-}fi$" Enter

if true; then
  echo as simple as that
fi

if (( 1 > 1 )); then echo no
elif [[ "$a" == toto ]]; then echo no
elif true; then echo yes
else echo no
fi
```

### Iteración: For

```bash
ts "man bash" Enter / "^\s*for\s*name\_.\{-}done$" Enter

for string in a "b c"; do
  echo "$string"
done
```

### Función

* [Single Entry, Single Exit](https://softwareengineering.stackexchange.com/questions/11870)

```bash
ts "man bash" Enter / "^\s*fname\s*()\_.\{-}\]$" Enter

func(){
  for i; do echo "$((j++)): $i!"; done
}

func a "b c"; echo "Status: $?"              # Command statement
echo "$(func "e   f" g)"; echo "Status: $?"  # Command expansion
cat < <(func "h  i" j); echo "Status: $?"    # Command substitution
```


### Declaración

```bash
declare    string="a b"; echo "$string"
declare -i int=21; echo "$(( int * 2 ))"
declare -a array=(a "b c"); for string in "${array[@]}"; do echo "$string"; done
declare -A dict=([a]="b c" ["d e"]=f); for key in "${!dict[@]}"; do echo "$key: ${dict[$key]}"; done
```


### Expansión

```bash
var=value; echo -e \
  \\n\
  -/ ----------------------------------------------------------\\n\
  1/ Brace Expansion'      ': {here,there}{_my,_your}{_poney,_house} \\n\
  2/ Tilde Expansion'      ': ~ \\n\
  3/ Parameter Expansion'  ': $var is ${var//va/b} \\n\
  4/ Command Substitution' ': $(printf "%s " {1..10}) \\n\
  5/ Arithmetic Expansion' ': $(( 90 * 2 / 3 - 18)) \\n\
  6/ Process Substitution' ': <(echo toto) \\n\
  7/ Word spliting'        ': many     whitespaces	tab and newlines\\n\
  8/ Pathname Expansion'   ': * \\n\
  9/ Quote Removal'        ': '' 'many     whitespaces  ' "double   quotes"\\n\
  -/ ----------------------------------------------------------\\n

```

## 2.3/ Gramatica

```bash
# Man Bash / SHELL GRAMMAR
ts "man bash" Enter / "^SHELL GRAMMAR" Enter / "^ *A\s*simple\s*com\_.\{-}command\." Enter

# Code Bash / parse.y (Yacc)
ts "vim ~/Program/Bash/parse.y" ENTER 371G
vim ./res/yacc-bash.y  # Obtained with vim command: "'<,'>g/^\w\|^\s*|/t$"

# Vim Color
vim +'e $VIMRUNTIME/syntax/sh.vim'  # Vim syntax coloration for Bash
```


## 2.4/ Capitulos (modules)

```bash
# Import script [file](file.md), here vman command in my PATH
source "$(command -v vman)"
# shellcheck disable=SC2002  # Useless cat
cat "$(command -v vman)" | vman_main

# Conditional main call
# -- More robust than [[ $0 != "$BASH_SOURCE" ]]
# -- But must be run at top level (not in a function)
# -- See: https://stackoverflow.com/a/28776166/2544873
if ! (return 0 2>/dev/null); then
  main "$@"; exit $?
fi

# Show the current script path
echo "$0"
printf "%s |" "${BASH_SOURCE[@]}"
```


# 3/ Demo de código (Task Manager)
## 3.1 Desafio

* [pagina de desafio](./challenge.sh)

## 3.2/ Cyclo de dev: requerimientos, test, dev

* [Flujo de desarollo](./tip-dev.md)

Con un archivo en ./demo/


## 3.3/ Linter y lectura critica

* [Web: Shellcheck](https://github.com/koalaman/shellcheck/)

## 3.4/ Mas alla: Introspection

* [Archivo: Introspection](./res/introspeciton.sh)
* Demo with the dispatch command

```bash
# List command in scope with "corr" in their name
compgen -c | grep -i corr

# Print line separated PATH variable
echo "${PATH//:/$'\n'}"

# Slurp: read file to string
string=$(<file.txt)
```

# Conclusion
## Commands

```bash
# Man Quoting and expansions
ts "man bash" Enter "/^EXPANSION" Enter z2 Down Space "/^\s*The\s*order\_.\{-}\.$" Enter
ts "man bash" Enter "/^SIMPLE COMMAND EXPANSION" Enter
ts "man bash" Enter "/QUOTING" Enter
ts "man bash" /EXPANSION / Quote Removal
    
# Man Grammar Doc
ts "man bash" Enter  "/^SHELL GRAMMAR" Enter "/Compound Commands" Enter zt
ts "man bash" Enter "/^SHELL BUILTIN COMMANDS" Enter zt z3


# Grammar
ts "vim ~/Program/Bash/parse.y" ENTER 371G
vim ./res/yacc-bash.y  # Obtained with vim command: "'<,'>g/^\w\|^\s*|/t$"
vim +'e $VIMRUNTIME/syntax/sh.vim'  # Vim syntax coloration for Bash

```

## Link

### Books
* [ABS: Advanced Bash Scripting](https://tldp.org/LDP/abs/abs-guide.pdf)
  * __The Bash reference__: An in-depth exploration of the art of shell scripting (by Mendel Cooper)
* [TLPI: The Linux Programming Interface](https://sciencesoftcode.files.wordpress.com/2018/12/the-linux-programming-interface-michael-kerrisk-1.pdf)
  * __The Linux reference__: A Linux and UNIX System Programming Handbook  (by Michael Kerrisk)


