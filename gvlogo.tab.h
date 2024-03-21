/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     RUN = 258,
     SHUTDOWN = 259,
     GOTO = 260,
     WHERE = 261,
     SEP = 262,
     PENUP = 263,
     PENDOWN = 264,
     PRINT = 265,
     CHANGE_COLOR = 266,
     PRINT_COLOR = 267,
     PRINT_PEN_STATE = 268,
     CLEAR = 269,
     TURN = 270,
     LOOP = 271,
     MOVE = 272,
     NUMBER = 273,
     END = 274,
     SAVE = 275,
     PLUS = 276,
     SUB = 277,
     MULT = 278,
     DIV = 279,
     EQUAL = 280,
     STRING = 281,
     QSTRING = 282,
     CHAR = 283
   };
#endif
/* Tokens.  */
#define RUN 258
#define SHUTDOWN 259
#define GOTO 260
#define WHERE 261
#define SEP 262
#define PENUP 263
#define PENDOWN 264
#define PRINT 265
#define CHANGE_COLOR 266
#define PRINT_COLOR 267
#define PRINT_PEN_STATE 268
#define CLEAR 269
#define TURN 270
#define LOOP 271
#define MOVE 272
#define NUMBER 273
#define END 274
#define SAVE 275
#define PLUS 276
#define SUB 277
#define MULT 278
#define DIV 279
#define EQUAL 280
#define STRING 281
#define QSTRING 282
#define CHAR 283




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 66 "gvlogo.y"
{
	float f;
	char* s;
	char c;
}
/* Line 1529 of yacc.c.  */
#line 111 "gvlogo.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

extern YYLTYPE yylloc;
