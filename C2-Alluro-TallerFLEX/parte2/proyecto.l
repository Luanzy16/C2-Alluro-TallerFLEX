%{
#include <stdio.h>
#include <string.h>
#include "proyecto.tab.h"
%}

alpha [a-zA-Z]+
number ([0-9])+
espacios [ \t\r\n]+


%%
"siguiente"   {yylval.reservada = yytext; return (TURNO);}

"Moscow"            {yylval.reservada = yytext; return (MAPA);}
"Paris"             {yylval.reservada = yytext; return (MAPA);}
"Amazonía"          {yylval.reservada = yytext; return (MAPA);}
"New York"          {yylval.reservada = yytext; return (MAPA);}
"Antarctica"        {yylval.reservada = yytext; return (MAPA);}
"Holland"           {yylval.reservada = yytext; return (MAPA);}
"Hong Kong"         {yylval.reservada = yytext; return (MAPA);}
"Dark Tooth"        {yylval.reservada = yytext; return (MAPA);}

"Axel"              {yylval.reservada = yytext; return (PERSONAJE);}
"Grasshopper"       {yylval.reservada = yytext; return (PERSONAJE);}
"Mr. Grimm"         {yylval.reservada = yytext; return (PERSONAJE);}
"Hammerhead"        {yylval.reservada = yytext; return (PERSONAJE);}
"Minion"            {yylval.reservada = yytext; return (PERSONAJE);}
"Outlaw"            {yylval.reservada = yytext; return (PERSONAJE);}
"Roadkill"          {yylval.reservada = yytext; return (PERSONAJE);}
"Shadow"            {yylval.reservada = yytext; return (PERSONAJE);}
"Mr.Slam"           {yylval.reservada = yytext; return (PERSONAJE);}
"Spectre"           {yylval.reservada = yytext; return (PERSONAJE);}
"Sweettooth"        {yylval.reservada = yytext; return (PERSONAJE);}
"Thumper"           {yylval.reservada = yytext; return (PERSONAJE);}
"Twister"           {yylval.reservada = yytext; return (PERSONAJE);}
"Warthog"           {yylval.reservada = yytext; return (PERSONAJE);}

"arriba"            {yylval.reservada = yytext; return (MOVIMIENTO);}
"abajo"             {yylval.reservada = yytext; return (MOVIMIENTO);}
"izquierda"         {yylval.reservada = yytext; return (MOVIMIENTO);}
"derecha"           {yylval.reservada = yytext; return (MOVIMIENTO);}

"fire ball"         {yylval.reservada = yytext; return (ATAQUE_ESPECIAL);}
"freeze"            {yylval.reservada = yytext; return (ATAQUE_ESPECIAL);}
"mine"              {yylval.reservada = yytext; return (ATAQUE_ESPECIAL);}
"jump"              {yylval.reservada = yytext; return (ATAQUE_ESPECIAL);}

"disparar"          {yylval.reservada = yytext; return (ATAQUE);}
"fin"               {yylval.reservada = yytext; return (FIN);}

.                   {return OTHER;}
%%


void showError(char* other){
    printf("ErrorLexico: \"%s\" >> ",other);
}

void yyerror(const char *s) {
    fprintf(stderr, "Error de análisis: %s\n", s);
}

