/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_PRINT = 258,
    T_FECHACHAVE = 259,
    T_FECHACOLCHETE = 260,
    T_FECHAPARENTESE = 261,
    T_ASPAS = 262,
    T_ARRAY = 263,
    T_PROGRAM = 264,
    T_OPAD = 265,
    T_ATRIBUICAO = 266,
    T_OPMUL = 267,
    T_OPRELACIONAL = 268,
    T_IF = 269,
    T_ELSE = 270,
    T_OF = 271,
    T_THEN = 272,
    T_BEGIN = 273,
    T_END = 274,
    T_PONTO = 275,
    T_PONTO_PONTO = 276,
    T_PONTOVIRGULA = 277,
    T_DOISPONTOS = 278,
    T_ABREPARENTESE = 279,
    T_ABRECOLCHETE = 280,
    T_ABRECHAVE = 281,
    T_VIRGULA = 282,
    T_UNDERLINE = 283,
    T_DO = 284,
    T_RETURN = 285,
    T_VAR = 286,
    T_WHILE = 287,
    T_READ = 288,
    T_FOR = 289,
    T_PALAVRA = 290,
    T_BOOLEAN = 291,
    T_REAL = 292,
    T_INTEGER = 293,
    T_ID = 294,
    T_FLOAT = 295,
    T_TRUE = 296,
    T_FALSE = 297,
    T_INT = 298
  };
#endif
/* Tokens.  */
#define T_PRINT 258
#define T_FECHACHAVE 259
#define T_FECHACOLCHETE 260
#define T_FECHAPARENTESE 261
#define T_ASPAS 262
#define T_ARRAY 263
#define T_PROGRAM 264
#define T_OPAD 265
#define T_ATRIBUICAO 266
#define T_OPMUL 267
#define T_OPRELACIONAL 268
#define T_IF 269
#define T_ELSE 270
#define T_OF 271
#define T_THEN 272
#define T_BEGIN 273
#define T_END 274
#define T_PONTO 275
#define T_PONTO_PONTO 276
#define T_PONTOVIRGULA 277
#define T_DOISPONTOS 278
#define T_ABREPARENTESE 279
#define T_ABRECOLCHETE 280
#define T_ABRECHAVE 281
#define T_VIRGULA 282
#define T_UNDERLINE 283
#define T_DO 284
#define T_RETURN 285
#define T_VAR 286
#define T_WHILE 287
#define T_READ 288
#define T_FOR 289
#define T_PALAVRA 290
#define T_BOOLEAN 291
#define T_REAL 292
#define T_INTEGER 293
#define T_ID 294
#define T_FLOAT 295
#define T_TRUE 296
#define T_FALSE 297
#define T_INT 298

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 22 "main.y"

    int ival;
    float fval;
    char *cval;

#line 149 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
