%{
int numChars = 0, numWords = 0, numLines = 0;
%}

%%
\n {numLines++; numChars++;}
[^ \t\n]+ {numWords++; numChars += yyleng;}
. {numChars++;}
%%

int main() {
    yylex();
    printf("%d\t%d\t%d\n", numChars, numWords, numLines);
    return 0;
}

int yylex() {
    int token;
    while ((token = yylex_internal()) != 0) ; // Escanea hasta el final de la entrada
    return 0; // Devuelve 0 al finalizar
}

int yylex_internal() {
    return getchar(); // Escanea un carácter de la entrada estándar
}
