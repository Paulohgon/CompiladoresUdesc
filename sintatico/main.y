%{

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define GetCurrentDir getcwd

extern  FILE *yyin;
void yyerror(const char * s);

extern int yylex();
extern int yyparse();

char outfileName[] = "codigo.txt";
extern int lineCounter;

%}

%token T_INTEGER T_REAL T_BOOLEAN T_FLOAT
%token T_DO T_WHILE T_VAR T_FALSE T_RETURN T_TRUE T_FOR T_READ T_PRINT
%token  T_ATRIBUICAO T_PALAVRA T_VIRGULA T_LETRAM T_INT T_ID T_UNDERLINE
%token T_ABRECHAVE T_FECHACHAVE
%token T_ABRECOLCHETE T_FECHACOLCHETE
%token T_ABREPARENTESE T_FECHAPARENTESE
%token T_PONTO T_PONTO_PONTO T_PONTOVIRGULA T_DOISPONTOS T_ASPAS
%token T_IF T_ELSE T_OF T_THEN T_BEGIN T_END T_FUNCTION T_PROCEDURE T_ARRAY
%token T_OPAD T_OPMUL T_OPRELACIONAL  T_PROGRAM

%%
programa: T_PROGRAM T_ID T_PONTOVIRGULA corpo {printf("Programa\n");};

corpo: declaracoes comandoComposto {printf("corpo\n");};

comandoComposto: T_BEGIN listaComandos T_END {printf("comandoComposto\n");};


listaComandos:  {printf("listaComandos\n");} 
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

atribuicao: variavel T_ATRIBUICAO expressao     {printf("atribuicao\n");};

declaracoes: declaracao T_PONTOVIRGULA      {printf("declaracoes\n");}
            |    {printf("declaracoes\n");}
            | declaracoes declaracao T_PONTOVIRGULA     {printf("declaracoes\n");}
            ;

condicional: T_IF expressao T_THEN comando   condicionalAux       {printf("condicional\n");};

condicionalAux:    {printf("condicionalAux\n");}
                |T_ELSE comando     {printf("condicionalAux\n");}
                ;

variavel: T_ID seletor  {printf("variavel\n");};

expressao: expressaoSimples {printf("expressao\n");}
        |  expressaoSimples T_OPRELACIONAL expressaoSimples     {printf("expressao\n");}
        ;

declaracao: declaracaoVariavel      {printf("declaracao\n");};

seletor: seletor T_ABRECOLCHETE expressao T_FECHACOLCHETE       {printf("seletor\n");}
        |    {printf("seletor\n");}
        |T_ABRECOLCHETE expressao T_FECHACOLCHETE   {printf("seletor\n");}
        ;

declaracaoVariavel: T_VAR listaIds T_DOISPONTOS tipo   {printf("declaracaoVariavel\n");};


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

// parametros: (T_VAR|T_VAZIO) listaIds T_DOISPONTOS tipoSimples   {printf("parametros\n");}

literal: boolLit    {printf("literal\n");}
        | intLit    {printf("literal\n");}
        | floatLit  {printf("literal\n");}
        ;

boolLit: T_TRUE {printf("boolLit\n");}
        |T_FALSE    {printf("boolLit\n");}
        ;

intLit: T_INT   {printf("intLit\n");};

floatLit: T_FLOAT   {printf("floatLit\n");};

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
comandoWhile: T_WHILE expressao T_DO comando

comandoFor: T_FOR atribuicao expressaoSimples atribuicao T_ABRECHAVE expressao T_FECHACHAVE

%%


int main(int argv, char * argc[]) {
	FILE *myfile;
	if(argv == 1) 
	{
		myfile = fopen("input_code.txt", "r");
		//outfileName = "input_code.txt";
	}
	// else 
	// {
	// 	myfile = fopen(argc[1], "r");
	// 	outfileName = string(argc[1]);
	// }
	if (!myfile) {
		printf("I can't open input code file!\n");
		char cCurrentPath[200];
		 if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath)))
		     {
		     return -1;
		     }
		printf("%s\n",cCurrentPath);  
				getchar();

		return -1;

	}
	yyin = myfile;
	yyparse();
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática, Linha: %d): %s\n", lineCounter, s);
	exit(1);
}