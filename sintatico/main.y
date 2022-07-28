%{
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include "lde.h"

#define GetCurrentDir getcwd

extern  FILE *yyin;
void yyerror(const char * s);
extern int yylex();
extern int yyparse();
extern nodo *tabela;
int numvariavel =-1;
void generateFooter();
void generateHeader();
void defineVar(char * name, int type);

%}

%union{
    int ival;
    float fval;
    char *cval;
}

%token T_PRINT
%token T_FECHACHAVE
%token T_FECHACOLCHETE
%token T_FECHAPARENTESE
%token T_ASPAS
%token T_ARRAY
%token T_PROGRAM
%token T_OPAD
%token T_ATRIBUICAO
%token T_OPMUL
%token T_OPRELACIONAL
%token T_IF
%token T_ELSE
%token T_OF
%token T_THEN
%token T_BEGIN
%token T_END
%token T_PONTO
%token T_PONTO_PONTO
%token T_PONTOVIRGULA
%token T_DOISPONTOS
%token T_ABREPARENTESE
%token T_ABRECOLCHETE
%token T_ABRECHAVE
%token T_VIRGULA
%token T_UNDERLINE
%token T_DO
%token T_RETURN
%token T_VAR
%token T_WHILE
%token T_READ
%token T_FOR
%token T_PALAVRA
%token T_BOOLEAN
%token T_REAL
%token T_INTEGER
%token T_ID
%token T_FLOAT
%token T_TRUE
%token T_FALSE
%token T_INT


%type<cval> T_PALAVRA T_BOOLEAN T_REAL T_INTEGER T_ID T_OPAD T_OPMUL T_ATRIBUICAO T_OPRELACIONAL tipoSimples listaIds expressaoSimples
%type<fval> T_FLOAT
%type<ival> T_TRUE T_FALSE T_INT intLit

%start programa
%%
programa: T_PROGRAM {generateFooter();} T_ID T_PONTOVIRGULA corpo T_PONTO {generateHeader();}
;

corpo: declaracoes comandoComposto {printf("corpo\n");}
;

comandoComposto: T_BEGIN listaComandos T_END {printf("comandoComposto\n");}
;


listaComandos: {printf("listaComandos\n");} 
                | comando T_PONTOVIRGULA {printf("listaComandos\n");}
                | listaComandos comando T_PONTOVIRGULA {printf("listaComandos\n");}
                ;

comando: atribuicao {printf("comando\n");}
        | condicional   {printf("comando\n");}
        | comandoComposto   {printf("comando\n");}
        | comandoFor    {printf("comando\n");}
        | comandoWhile  {printf("comando\n");}
        ;

atribuicao: variavel T_ATRIBUICAO expressao     {}
;

declaracoes: {printf("declaracoes\n");}
            | declaracao T_PONTOVIRGULA      {printf("declaracoes\n");}
            | declaracoes declaracao T_PONTOVIRGULA     {printf("declaracoes\n");}
            ;

condicional: T_IF expressao T_THEN comando   condicionalAux       {printf("condicional\n");}
;

condicionalAux:    {printf("condicionalAux\n");}
                |T_ELSE comando     {printf("condicionalAux\n");}
                ;

variavel: T_ID seletor  {printf("variavel\n");}
;

expressao: expressaoSimples {printf("expressao\n");}
        |  expressaoSimples T_OPRELACIONAL expressaoSimples     {printf("expressao\n");}
        ;

declaracao: declaracaoVariavel      {printf("declaracao\n");}
;

seletor: seletor T_ABRECOLCHETE expressao T_FECHACOLCHETE       {printf("seletor\n");}
        |    {printf("seletor\n");}
        |T_ABRECOLCHETE expressao T_FECHACOLCHETE   {printf("seletor\n");}
        ;

declaracaoVariavel: T_VAR listaIds T_DOISPONTOS tipoSimples   {printf("\n\n\n");printf($2);printf("\n\n\n");}
;


listaIds: T_ID      {printf("listaIds\n");}
        | listaIds T_VIRGULA T_ID   {printf("listaIds\n");}
        ;

tipo: tipoAgregado  {printf("tipo\n");}
    | tipoSimples   {printf("tipo\n");}
    ;

tipoSimples: T_INTEGER  {printf("tipoSimples\n");}
            |T_REAL {printf("sim\n\n\n");printf($1);printf("\n\n\n");}
            |T_BOOLEAN  {printf("tipoSimples\n");}
            ;



tipoAgregado: T_ARRAY T_ABRECOLCHETE literal T_DOISPONTOS literal T_FECHACOLCHETE T_OF tipo     {printf("tipoAgregado\n");}
;


literal: boolLit    {printf("literal\n");}
        | intLit    {printf("literal\n");}
        | floatLit  {printf("literal\n");}
        ;

boolLit: T_TRUE {}
        |T_FALSE    {}
        ;

intLit: T_INT   {tabela=insere_nodo_fim("T_INT",$1,tabela, int 0,int 0)}
;

floatLit: T_FLOAT   {printf("floatLit\n");}
;

expressaoSimples: expressaoSimples T_OPAD termo {saveOpadd($2);}
                | termo     {printf("expressaoSimples\n");}
                ;
                
termo: termo T_OPMUL fator  {printf("termo\n");}
    | fator     {printf("boolLit\n");}
    ;
   
fator: variavel     {printf("fator\n");}
    |literal        {printf("fator\n");}
    |T_ABREPARENTESE expressao T_FECHAPARENTESE       {printf("fator\n");}
    ;
comandoWhile: T_WHILE expressao T_DO comando {};

comandoFor: T_FOR atribuicao expressaoSimples atribuicao T_ABRECHAVE expressao T_FECHACHAVE{};

%%



int main(int argv, char * argc[]) {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}

void generateHeader()
{   
    FILE * file = fopen("output.j","w+");
    fprintf(file,".source %s","outfileName\n");
	fprintf(file,".class public test\n.super java/lang/Object\n\n"); //code for defining class
	
    fprintf(file,".method public <init>()V /n");
	fprintf(file,"aload_0\n");
	fprintf(file,"invokenonvirtual java/lang/Object/<init>()V\n");
	fprintf(file,"return\n");
	fprintf(file,".end method\n\n");

	fprintf(file,".method public static main([Ljava/lang/String;)V\n");
	fprintf(file,".limit locals 100\n.limit stack 100\n");

	// /* generate temporal vars for syso*/
	// defineVar("1syso_int_var",T_INT);
	// defineVar("1syso_float_var",T_REAL);

	// /*generate line*/
	// fprintf(file, ".line 1");
    // fclose(file);
}

void generateFooter()
{
    FILE *file = fopen("output.j","a+");
	fprintf(file,"\nreturn\n");
	fprintf(file,".end method\n");
}

