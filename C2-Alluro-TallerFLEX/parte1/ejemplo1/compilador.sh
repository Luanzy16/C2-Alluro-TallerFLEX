#!/bin/bash 
    clear
echo "<inicio de ejemplo1>"
    flex -l ejemplo1.l
    gcc -o main lex.yy.c -lfl
echo "<fin>"