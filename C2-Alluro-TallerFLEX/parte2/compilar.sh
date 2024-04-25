#!/bin/bash
    clear
echo "<comienzo de ejcucion>"
    flex -l proyecto.l
    bison -dv proyecto.y
    gcc -o proyecto proyecto.tab.c lex.yy.c -lfl
echo "<final de ejecucion>"