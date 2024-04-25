%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char nombre[20];
    int vida;
} Personaje;

extern FILE *yyin;
#define MAX_PERSONAJES 4

static Personaje personajes[MAX_PERSONAJES];
static int numPersonajes = 0;

// Funciones:
void agregarPersonaje( char nombre[]);
int calcular_danio(char accion[]);
void restar_danio(char ataque[]);
void determinarGanador();


%}

%token MAPA PERSONAJE MOVIMIENTO OTHER ATAQUE ATAQUE_ESPECIAL TURNO FIN
%type <reservada> MAPA PERSONAJE MOVIMIENTO OTHER ATAQUE ATAQUE_ESPECIAL TURNO 


%union {
    char *reservada;
    int number;
}

%%

prog:
    SELECCION_MAPA SELECCION_PERSONAJES{printf("El juego comienza: \n");} TURNOS
    ;

SELECCION_MAPA:
     MAPA { printf("El mapa escogido fue: %s\n", $1); }
    ;

SELECCION_PERSONAJES: 
    PERSONAJE {printf("Se selecciono al personaje: %s\n", $1); agregarPersonaje($1);} 
    PERSONAJE{printf("Se selecciono al personaje: %s\n", $1); agregarPersonaje($1);} 
    PERSONAJE{printf("Se selecciono al personaje: %s\n", $1); agregarPersonaje($1);}
    PERSONAJE { printf("Se selecciono al personaje: %s\n", $1); agregarPersonaje($1);}
    ;

TURNOS: MOVIMIENTO {restar_danio($1);}TURNO TURNOS 
        | ATAQUE {restar_danio($1);}TURNO TURNOS 
        | ATAQUE_ESPECIAL {restar_danio($1);}TURNO TURNOS 
        | FIN {determinarGanador();}
        ;

%%


void mapa() {
    printf("escoge un mapa: ");
}

int asignarVida(char nombre[]) {

    if (nombre[0] == 'A') {
        return 90;
    }
    else if (nombre[0] == 'M') {
        return 120;
    }
    else if (nombre[0] == 'G') {
        return 150;
    }
    else if (nombre[0] == 'S') {
        return 130;
    }
    else {
        return 100;
    }
}


void agregarPersonaje(char nombre[]) {

    // Verificamos si hay espacio en la lista para agregar un nuevo personaje
    if (numPersonajes < MAX_PERSONAJES) {
        // Copiamos el nombre del personaje
        int i = 0;
        while (nombre[i] != '\0' && i < 19) {
            personajes[numPersonajes].nombre[i] = nombre[i];
            i++;
        }
        personajes[numPersonajes].nombre[i] = '\0'; 
        personajes[numPersonajes].vida = asignarVida(nombre);

        // Incrementamos el contador de personajes
        numPersonajes++;
    } 

    if(numPersonajes == MAX_PERSONAJES){
        for (int i = 0; i < numPersonajes; i++) {
            printf("Personaje %d:\n", i + 1);
            printf("Nombre: %s\n", personajes[i].nombre);
            printf("Vida: %d\n", personajes[i].vida);
            printf("\n");
        }
    } 
}

void restar_danio(char ataque[]) {
    int indice = rand() % 4;
    if (indice < 0 || indice >= 4) {
        printf("Índice fuera de rango.\n");
        return;
    }

    int danio;

    if (strcmp(ataque, "disparar") == 0) {
        personajes[indice].vida -= 20;
        danio = 20;
    } else if (strcmp(ataque, "fire ball") == 0) {
        personajes[indice].vida -= 40;
        danio = 40;
    } else if (strcmp(ataque, "freeze") == 0) {
        personajes[indice].vida -= 30;
        danio = 30;
    } else if (strcmp(ataque, "mine") == 0) {
        personajes[indice].vida -= 40;
        danio = 40;
    } else if (strcmp(ataque, "jump") == 0) {
        personajes[indice].vida -= 25;
        danio = 25;
    } else {
        personajes[indice].vida -= 0;
        danio = 0;
    }

    if (personajes[indice].vida <= -10) {
        printf("porque le diste a un %s muerto? ",personajes[indice].nombre );
    } else if(personajes[indice].vida > 0){
        printf("%s ha recibido %d puntos de daño. Vida restante: %d\n", personajes[indice].nombre, danio, personajes[indice].vida);
    }else{
        printf("%s ha sido eliminado del combate.\n", personajes[indice].nombre);
    }
}

void determinarGanador() {
    int i;
    int vidaMaxima = 0;
    Personaje *ganador = NULL;

    for (i = 0; i < numPersonajes; i++) {
        if (personajes[i].vida > vidaMaxima) {
            vidaMaxima = personajes[i].vida;
            ganador = &personajes[i];
        }
    }

    if (ganador != NULL) {
        printf("El ganador es: %s con una vida restante de %d\n", ganador->nombre, ganador->vida);
    } else {
        printf("No hay un ganador definido.\n");
    }
}


int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    FILE *archivo = fopen(argv[1], "r");
    if (archivo == NULL) {
        fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }


    yyin = archivo;


    yyparse();


    fclose(archivo);

}
    
    
