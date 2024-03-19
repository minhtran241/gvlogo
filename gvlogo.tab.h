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
     CLEAR = 267,
     TURN = 268,
     LOOP = 269,
     MOVE = 270,
     NUMBER = 271,
     END = 272,
     SAVE = 273,
     PLUS = 274,
     SUB = 275,
     MULT = 276,
     DIV = 277,
     EQUAL = 278,
     STRING = 279,
     QSTRING = 280,
     CHAR = 281
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
#define CLEAR 267
#define TURN 268
#define LOOP 269
#define MOVE 270
#define NUMBER 271
#define END 272
#define SAVE 273
#define PLUS 274
#define SUB 275
#define MULT 276
#define DIV 277
#define EQUAL 278
#define STRING 279
#define QSTRING 280
#define CHAR 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 65 "gvlogo.y"
{		// add color rgb to here?
	float f;
	char* s;
	char c;
}
/* Line 1529 of yacc.c.  */
#line 107 "gvlogo.tab.h"
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
