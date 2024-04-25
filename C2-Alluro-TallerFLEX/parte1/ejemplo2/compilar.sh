#!/bin/bash 
    clear
echo "<inicio de ejemplo1>"
    flex -l ejemplo2.l
    gcc -o contador lex.yy.c -lfl
    ./contador < ejemplo2.l
echo "<fin>"