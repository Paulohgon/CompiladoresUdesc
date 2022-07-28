#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lde.h"
extern nodo *tabela;
int store = 0;
FILE *f;
char * outfileName = "corrigido.txt";
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


    fprintf(f,"ldc %i\n",valor);
}
void saveFloat(float valor){


    fprintf(f,"ldc %i\n",valor);
}
void loadVar(char * variavel, int indicePilha){

    fprintf(f,"iload %s %i", variavel, indicePilha);
}
void saveOpadd(char * op){
    if(op[0] == '+'){
        printf("EU NAO AGUENTO MAIS\n\n");
        fprintf(f,"iadd\n");
    }
    else if(op[0] =='-'){
        fprintf(f,'isub\n');
    }else if(op == 'or'){
        
    }
     
}

void saveOpmul(char * op){
    
    if(op[0] =='*'){
        fprintf(f,"imul\n");
    }
    if(op[0] =='/'){
        fprintf(f,"idiv\n");
    }
}
int getid(char*id){
    nodo *novo;
    novo =tabela;
    while(novo->prox != NULL){
        if(strcmp(novo->token,id)==0){
            printf("entrei");
            return novo -> pilha;
        }
        novo=novo->prox;
    }
}

void generateAtribui(char* id){
    
    printf("\n\nidlido %s\n\n",id);
    int idaux=getid(id);
    printf("%i",idaux);
    if(idaux ==-1){
        atualiza(id,store);
        
        fprintf(f,"istore %d\n",store);
        store++;
    }
    else{
        fprintf(f,"istore %d\n",idaux);

    }
}


void atualiza(char*id,int pilha){
    nodo *novo;
    novo = tabela;
    while(novo->prox != NULL){
        if(strcmp(novo->token,id)==0){
            novo->pilha = pilha;
        }
        novo=novo->prox;
    }
}


void generateHeader()
{   
    f = fopen("output.j","w+");
    fprintf(f,".source %s\n",outfileName);
	fprintf(f,".class public test\n.super java/lang/Object\n\n"); //code for defining class
	fprintf(f,".method public <init>()V \n");
	fprintf(f,"aload_0\n");
	fprintf(f,"invokenonvirtual java/lang/Object/<init>()V\n");
	fprintf(f,"return\n");
	fprintf(f,".end method\n\n");
    fprintf(f,".method public static main([Ljava/lang/String;)V\n");
	fprintf(f,".limit locals 100\n.limit stack 100\n");

	// /* generate temporal vars for syso*/
	// defineVar("1syso_int_var",T_INT);
	// defineVar("1syso_float_var",T_REAL);

	// /*generate line*/
	// fprintf(file, ".line 1");
    // fclose(file);
}

void generateFooter()
{
	fprintf(f,"\nreturn\n");
	fprintf(f,".end method\n");
}

void printnoj(char * id){
    int idaux = getid(id);
    fprintf(f, "getstatic java/lang/System/out Ljava/io/PrintStream;\n");
    fprintf(f, "iload %i\n", idaux);
    fprintf(f, "invokevirtual java/io/PrintStream/println(I)V\n");

}