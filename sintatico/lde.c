#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lde.h"

FILE *f;

nodo * inicializa(int id){
    nodo *l;
    l = (nodo *)malloc(sizeof(nodo));
    l->id = id;
    l->prox = NULL;
    l->ant = NULL;
    l->linha=0;
    l->coluna=0;
    l->pilha=-1;
    return l;
}

nodo * insere_nodo_fim(char * tipo, char * token, nodo * l, int col,int linha){
    
    int id = 0;
    nodo * p;
    p = l;

    nodo * novo;
    novo = (nodo *) malloc(sizeof(nodo));
    novo->prox = NULL;
    strcpy(novo->token,token);
    strcpy(novo->tipo,tipo);
    novo->coluna = col;
    novo->linha=linha;
    novo->pilha=-1;

    if(l == NULL){
        l = novo;
        novo->ant = NULL;
        novo->id= id;

    }
    else{
        while(p->prox){
            id++;
            p = p->prox;}
        id++;
        p->prox = novo;
        novo->ant = p;
        novo->id= id;
    }
    return l;
    
}

void imprime_lista(nodo *l){

    nodo * p;
    p=l;
    printf("---------\n");
    while(p != NULL ){
        printf("\nID: %d\tTipo: %s\tToken: %s \t linha:%d \t coluna:%d \n", p->id,p->tipo,p->token,p->linha,p->coluna);
        p=p->prox;
    }
}

nodo * libera_lst(nodo *l){

    nodo *p;
    p=l;

    if(p == NULL){
        return NULL;
    }
    while(p->prox != NULL){
        p=p->prox;
        free(p->ant);
    }
    free(p);

    return NULL;
}

void saveInt(int valor){
    f = fopen("output.j","a+");
    fprintf(f,"ldc %i",valor);
}

void loadVar(char * variavel, int indicePilha){
    f = fopen("output.j","a+");
    fprintf(f,"iload %s %i", variavel, indicePilha);
}
void saveOpadd(char op){
    f = open("output.j","a+");
    if(op =='+'){
        fprintf(f,"iadd\n");
    }
    else if(op =='-'){
        fprintf(f,'isub\n');
    }else if(op == 'or'){
        
    }
     
}

void saveOpmul(char op){
     f = open("output.j","a+");
    if(op =='*'){
        fprintf(f,"imul\n");
    }
    else if(op =='/'){
        fprintf(f,'idiv\n');
    }else if(op == 'and'){
        
    }
}