#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lde.h"

nodo * inicializa(int id){


    nodo *l;
    l = (nodo *)malloc(sizeof(nodo));
    l->id = id;
    l->prox = NULL;
    l->ant = NULL;
    l->linha=0;
    l->coluna=0;
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
    // while (p->prox != NULL){
    //     p = p->prox;
    //     id++;

    // }
    // novo->id= id;
    // p->prox = novo;
    // novo->ant = p;
    //printf("\nID: %d\tTipo: %s\tToken: %s \t linha:%d \t coluna:%d \n", novo->id,novo->tipo,novo->token,novo->linha,novo->coluna);
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
