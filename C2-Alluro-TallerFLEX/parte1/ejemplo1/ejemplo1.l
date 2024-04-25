%{
#include <stdio.h>
%}

%%

[0-9]+  { printf("?"); }
.       { printf("%c", yytext[0]); }

%%

int main() {
    yylex();
    return 0;
}
