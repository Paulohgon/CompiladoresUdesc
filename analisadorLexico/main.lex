%{
    
    // includes

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lde.h"

    
nodo * tabela = NULL;
int id=0;
int coluna = 1;
int linhas = 1;


%}

DIGITO [0-9]
LETRA [a-z]
LETRAM [A-Z]
PALAVRA [a-z][a-z0-9]*|[A-Z][A-Z0-9]*
ATRIBUICAO :=
PONTUACAO :|;
OPMAT "+"|"-"|"*"|"/"
OPLOG or|and
PARENTESES "("|")"
COLCHETES "["|"]"
CHAVES "{"|"}"
ASPAS [""]
OPRELACIONAL <|>|<=|>=|=|<>
PALAVRA_RESERVADA of|if|then|else|begin|end|procedure|function|true|false|var|while|do|integer|real|boolean|print|read|for|return
SIMBOLO "_"|","
%%

{CHAVES} {
    tabela = insere_nodo_fim("chave",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{COLCHETES} {
    tabela = insere_nodo_fim("colchete",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);

}


{PARENTESES} {
    tabela = insere_nodo_fim("parentese",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{OPRELACIONAL} {
    tabela = insere_nodo_fim("oprel",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{OPLOG} {
    tabela = insere_nodo_fim("oplog",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{OPMAT} {
    tabela = insere_nodo_fim("opmat",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}


{DIGITO}+ {
    tabela = insere_nodo_fim("digito",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{ATRIBUICAO} {
    tabela = insere_nodo_fim("atribuicao",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{PALAVRA_RESERVADA} {
    tabela = insere_nodo_fim("palavraR",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}

{PALAVRA} {
    tabela = insere_nodo_fim("palavra",yytext,tabela,coluna,linhas);
    coluna+=strlen(yytext);
}
{PONTUACAO} {
        tabela = insere_nodo_fim("pontuacao",yytext,tabela,coluna,linhas);
        coluna+=strlen(yytext);
}
{ASPAS} {
        tabela = insere_nodo_fim("aspas",yytext,tabela,coluna,linhas);
        coluna+=strlen(yytext);
}

{SIMBOLO} {
        tabela = insere_nodo_fim("simbolo",yytext,tabela,coluna,linhas);
        coluna+=strlen(yytext);
}
{DIGITO}+"."{DIGITO}* {
        tabela = insere_nodo_fim("num real",yytext,tabela,coluna,linhas);
        coluna+=strlen(yytext);
}
{LETRAM} {
        tabela = insere_nodo_fim("letra maiusc",yytext,tabela,coluna,linhas);
        coluna+=strlen(yytext);
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
	 printf( "Caracter não reconhecido: %s na linha %d e coluna %d\n", yytext, linhas, coluna );
     coluna+=strlen(yytext);
}  

%%

int main(void){

    //tabela = inicializa(id);
    yyin = fopen( "corrigido.txt", "r" ); // Escrever o codigo no arquivo code.braia
    yylex();
    imprime_lista(tabela);



return 0;
}
