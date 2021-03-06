%option noyywrap
%{
    // includes

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lde.h"
#include "main.tab.h"
#define YY_DECL int yylex ()
nodo * tabela = NULL;
int id=0;
int coluna = 1;
int linhas = 1;


%}

ATRIBUICAO ":="
PONTO "."
DIGITO [0-9]
INT {DIGITO}+
FLOAT {INT}{PONTO}{INT}|{PONTO}{INT}|{INT}{PONTO}
ID [a-z][a-z0-9]*|[A-Z][A-Z0-9]*
OPAD "+"|"-"|"or"
OPMUL "*"|"/"|"and"
ASPAS ["]
OPRELACIONAL "<"|">"|"<="|">="|"="|"<>"

%%

"_" {
    yylval.cval = yytext;
    tabela = insere_nodo_fim("underline", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_UNDERLINE;
}

"," {
    tabela = insere_nodo_fim("virgula", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_VIRGULA;
}



{OPMUL} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("opmul", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_OPMUL;
}


{OPAD} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("opad", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_OPAD;
}


{FLOAT} {
    yylval.fval = atof(yytext);
    tabela = insere_nodo_fim("float", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_FLOAT;
}

{PONTO} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("ponto", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_PONTO;
}
".." {
    tabela = insere_nodo_fim("ponto_ponto", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_PONTO_PONTO;
}
";" {
    tabela = insere_nodo_fim("pontoVirgula", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_PONTOVIRGULA;
}

":" {
    tabela = insere_nodo_fim("doisPontos", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_DOISPONTOS;
}

"return" {
    tabela = insere_nodo_fim("return", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_RETURN;
}

"for" { 
    tabela = insere_nodo_fim("for", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_FOR;
}

"read" {
    tabela = insere_nodo_fim("read", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_READ;
}
"program" {
    tabela = insere_nodo_fim("progam", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_PROGRAM;
}

"print" {
    tabela = insere_nodo_fim("print", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_PRINT;
}

"boolean" {
    tabela = insere_nodo_fim("boolean", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_BOOLEAN;
}

"array" {
    {
    tabela = insere_nodo_fim("array", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_ARRAY;
}
}
"real" {
    tabela = insere_nodo_fim("real", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    printf("\n\n\nLEXICO %s",yytext);
    printf("\n\n\n");
    return T_REAL;
}

"integer" {
    tabela = insere_nodo_fim("integer", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_INTEGER;
}

"do" {
    tabela = insere_nodo_fim("do", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_DO;
}

"while" {
    tabela = insere_nodo_fim("while", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_WHILE;
}

"var" {
    tabela = insere_nodo_fim("var", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_VAR;
}

"false" {
    yylval.ival = 0;
    tabela = insere_nodo_fim("false", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_FALSE;
}

"true" {
    yylval.ival = 1;
    tabela = insere_nodo_fim("true", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_TRUE;
}



"if" {
    tabela = insere_nodo_fim("if", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_IF;
}

"else" {
    tabela = insere_nodo_fim("else", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_ELSE;
}

"of" {
    tabela = insere_nodo_fim("of", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_OF;
}

"then" {
    tabela = insere_nodo_fim("then", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_THEN;
}

"begin" {
    tabela = insere_nodo_fim("begin", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_BEGIN;
}

"end" {
    tabela = insere_nodo_fim("end", yytext, tabela, coluna, linhas);
    coluna += strlen(yytext);
    return T_END;
}


"{" {
    tabela = insere_nodo_fim("abreChave",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_ABRECHAVE;
}

"}" {
    tabela = insere_nodo_fim("fechaChave",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_FECHACHAVE;
}

"[" {
    tabela = insere_nodo_fim("abreColchete",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_ABRECOLCHETE;
}

"]" {
    tabela = insere_nodo_fim("fechaColchete",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_FECHACOLCHETE;
}

"(" {
    tabela = insere_nodo_fim("abreParentese",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_ABREPARENTESE;
}

")" {
    tabela = insere_nodo_fim("fechaParentese",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_FECHAPARENTESE;
}

{OPRELACIONAL} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("oprelacional",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_OPRELACIONAL;
}

{INT} {
    yylval.ival = atoi(yytext);
    tabela = insere_nodo_fim("inteiro",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_INT;
}

{ATRIBUICAO} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("atribuicao",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_ATRIBUICAO;
}

{ID} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("palavra",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_ID;
}

{ASPAS} {
    yylval.cval = strdup(yytext);
    tabela = insere_nodo_fim("aspas",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
    return T_ASPAS;
}





[ \t]+ {
	coluna+=strlen(yytext);
}    

\"[^}\n]*\" {
    tabela = insere_nodo_fim("string",yytext,tabela,coluna,linhas);
	coluna+=strlen(yytext);
}    

\n {
	linhas++;
	coluna = 1;
}

"//"[^//\n]*
. {
	 printf( "Caracter n??o reconhecido: %s na linha %d e coluna %d\n", yytext, linhas, coluna );
     coluna+=strlen(yytext);
}  

%%

