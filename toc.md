

# Introduction

* [Archivo: fun with one liners](./one_liner.sh)

# 1/ Historia de Shell
## 1.1/ Cuando esta la Shell?

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


### Máquina analítica de Babbage: 1837
* [wiki](https://en.wikipedia.org/wiki/Turing_machine#Historical_background:_computational_machinery)


| N | Operacion   | Ejemplo |
| - | ---         | --- |
| 1 | Calculación | +, -, x |
| 2 | Composición | { inst1; inst2; } |
| 3 | Iteración   | for i in {1..10]; do inst1; done |
| 4 | Condición   | if inst1; then inst2; fi |
| 5 | Redirección | goto label1 |

### La epoca: 1970

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


## 1.2/ Donde esta la Shell?

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






# 2/ Commandos de Shell
## 2.1/ Sentencias (statements)
###

```bash
echo 'Hola colega!'
echo 'Hola colega!' | sed 's/a/A/g'   # Pipe
echo 'Hola colega!'; echo 'Que tal?'  # Statement List
msg='Hola colega!'; echo "$msg"       # Assignement and Expansion


ts "man bash" Enter / "^PARAMETERS" Enter / "^ *A\s*variable\s*may\_.\{-}value\]" Enter zz

```




## 2.2/ Parafos (composed statements)

### If

```bash
if true; then
  echo as simple as that
fi

if (( 1 > 1)); then echo no
elif [[ "$a" == toto ]]; then echo no
elif true; then echo yes
else echo no
fi
```

### For

```bash
for string in a "b c"; do
  echo "$string"
done
```

### Function

```bash
function func(){
  for i; do echo "$((j++)): $i|"; done
}

func a "b c"
```

## 2.3/ Gramatica

## 2.4/ Capitulos (modules)

```bash
# Import script file, here vman command in my PATH
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
## 3.1/ Cyclo de dev: requrimientos, test, dev

Con un archivo en ./demo/

## 3.2/ Linter y lectura critica

* [Web: Shellcheck](https://github.com/koalaman/shellcheck/)

## 3.3/ Introspecion: para ir mas alla

* [Archivo: Introspection](./res/introspeciton.sh)
* Demo with the dispatch command

```
```

# Conclusion

## Commands

```bash

vim +'e $VIMRUNTIME/syntax/sh.vim'  # Vim syntax coloration for Bash

# Quoting and expansions
ts "man bash" Enter "/^EXPANSION" Enter z2 Down Space "/^\s*The\s*order\_.\{-}\.$" Enter
ts "man bash" Enter "/^SIMPLE COMMAND EXPANSION" Enter
ts "man bash" Enter "/QUOTING" Enter
ts "man bash" /EXPANSION / Quote Removal
    
# Grammar Doc
ts "man bash" Enter  "/^SHELL GRAMMAR" Enter "/Compound Commands" Enter zt
ts "man bash" Enter "/^SHELL BUILTIN COMMANDS" Enter zt z3


# Grammar Yacc
ts "vim ~/Program/Bash/parse.y" ENTER 371G
vim ./res/yacc-bash.y  # Obtained with vim command: "'<,'>g/^\w\|^\s*|/t$"

```
## Link

### Books
* [ABS: Advanced Bash Scripting](https://tldp.org/LDP/abs/abs-guide.pdf)
  * __The Bash reference__: An in-depth exploration of the art of shell scripting (by Mendel Cooper)
* [TLPI: The Linux Programming Interface](https://sciencesoftcode.files.wordpress.com/2018/12/the-linux-programming-interface-michael-kerrisk-1.pdf)
  * __The Linux reference__: A Linux and UNIX System Programming Handbook  (by Michael Kerrisk)


