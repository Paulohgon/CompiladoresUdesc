#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct tokens nodo;
struct tokens{
    nodo *prox;
    nodo *ant;
    int id;
    char tipo[100];
    char token[100];
    int linha;
    int coluna; 
    int pilha;

};

nodo * insere_nodo_fim(char * tipo, char * token,nodo * l, int col,int linha);
nodo* inicializa(int id);
void imprime_lista(nodo *l); 
nodo * libera_lst(nodo *l); 
void saveOpadd(char op);
void saveInt(int valor);
void loadVar(char * variavel, int indicePilha);