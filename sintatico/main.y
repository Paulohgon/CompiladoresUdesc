%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%token T_INTEGER
%token T_REAL
%token T_FLOAT
%token T_PRINT
%token T_ID 
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
%token T_FUNCTION
%token T_PROCEDURE
%token T_PONTO
%token T_PONTO_PONTO
%token T_PONTOVIRGULA
%token T_DOISPONTOS
%token T_ABREPARENTESE
%token T_ABRECOLCHETE
%token T_ABRECHAVE
%token T_PALAVRA
%token T_VIRGULA
%token T_LETRAM
%token T_INT
%token T_UNDERLINE
%token T_DO
%token T_RETURN
%token T_FALSE
%token T_TRUE
%token T_VAR
%token T_WHILE
%token T_READ
%token T_FOR
%token T_BOOLEAN
%start programa
%%
programa: T_PROGRAM T_ID T_PONTOVIRGULA corpo T_PONTO {printf("Programa\n");}
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
        /* | chamada_procedimento  {printf("comando\n");} */
        | comandoComposto   {printf("comando\n");}
        | comandoFor    {printf("comando\n");}
        | comandoWhile  {printf("comando\n");}
        ;

atribuicao: variavel T_ATRIBUICAO expressao     {printf("atribuicao\n");}
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

declaracaoVariavel: T_VAR listaIds T_DOISPONTOS tipo   {printf("declaracaoVariavel\n");}
;


/* declaracaoFuncao: T_FUNCTION T_ID T_ABRECOLCHETE declaracaoFuncaoAux T_FECHACOLCHETE T_DOISPONTOS tipoSimples T_PONTOVIRGULA corpo   {printf("declaracaoFuncao\n");}; */

// declaracaoFuncaoAux: listaParametros    {printf("declaracaoFuncaoAux\n");}
//                     |T_VAZIO    {printf("declaracaoFuncaoAux\n");}
//                     ;

listaIds: T_ID      {printf("listaIds\n");}
        | listaIds T_VIRGULA T_ID   {printf("listaIds\n");}
        ;

tipo: tipoAgregado  {printf("tipo\n");}
    | tipoSimples   {printf("tipon");}
    ;

tipoSimples: T_INTEGER  {printf("tipoSimples\n");}
            |T_REAL {printf("tipoSimples\n");}
            |T_BOOLEAN  {printf("tipoSimples\n");}
            ;

// listaParametros: parametros {printf("listaParametros\n");}
//                 |listaParametros T_DOISPONTOS parametros    {printf("listaParametros\n");}
//                 ;

tipoAgregado: T_ARRAY T_ABRECOLCHETE literal T_DOISPONTOS literal T_FECHACOLCHETE T_OF tipo     {printf("tipoAgregado\n");}
;

// parametros: (T_VAR|T_VAZIO) listaIds T_DOISPONTOS tipoSimples   {printf("parametros\n");}

literal: boolLit    {printf("literal\n");}
        | intLit    {printf("literal\n");}
        | floatLit  {printf("literal\n");}
        ;

boolLit: T_TRUE {printf("boolLit\n");}
        |T_FALSE    {printf("boolLit\n");}
        ;

intLit: T_INT   {printf("intLit\n");}
;

floatLit: T_FLOAT   {printf("floatLit\n");}
;

expressaoSimples: expressaoSimples T_OPAD termo {printf("expressaoSimples\n");}
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


int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática) %s\n", s);
	exit(1);
}
