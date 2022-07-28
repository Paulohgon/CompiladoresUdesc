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


%type<cval> T_PALAVRA termo  T_BOOLEAN T_REAL T_INTEGER T_ID T_OPAD T_OPMUL variavel T_ATRIBUICAO T_OPRELACIONAL tipoSimples listaIds atribuicao expressaoSimples
%type<fval> T_FLOAT
%type<ival> T_TRUE T_FALSE T_INT intLit

%start programa
%%
programa: T_PROGRAM {generateHeader();} T_ID T_PONTOVIRGULA corpo T_PONTO {generateFooter();}
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
        | comandoPrint {}
        ;

atribuicao: T_ID T_ATRIBUICAO expressao     {generateAtribui($1);}
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

listaIds: T_ID      {}
        | listaIds T_VIRGULA T_ID   {}
        ;

tipo:tipoSimples   {printf("tipo\n");}
    ;

tipoSimples: T_INTEGER  {printf("tipoSimples\n");}
            |T_REAL {printf("tiposimples");}
            |T_BOOLEAN  {printf("tipoSimples\n");}
            ;


comandoPrint:  T_PRINT T_ID {printnoj($2);}
;




literal: boolLit    {printf("literal\n");}
        | intLit    {printf("literal\n");}
        | floatLit  {printf("literal\n");}
        ;

boolLit: T_TRUE {saveInt($1);}
        |T_FALSE    {saveInt($1);}
        ;

intLit: T_INT   {saveInt($1);}
;

floatLit: T_FLOAT   {saveFloat($1)}
;

expressaoSimples: expressaoSimples T_OPAD termo {saveOpadd($2);}
                | termo     {printf("expressaoSimples\n");}
                ;
                
termo: termo T_OPMUL fator  {saveOpmul($2);}
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


