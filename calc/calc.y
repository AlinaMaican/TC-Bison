/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
#define YYPARSE_PARAM astDest
int yyerror(char *s);
extern "C" int yylex();
%}

%union{
  int		int_val;
  bool      bool_val;
  float     float_val;
  string*	op_val;
}

%start	input 

%token	<int_val>	INTEGER_LITERAL
%token  <float_val> FLOAT_LITERAL
%token  IF ELSE WHILE
%token  TRUE FALSE
%token '(' ')' 
%token '{' '}'
%type	<int_val>	exp
%type   <bool_val>  b_exp
%type   <float_val> f_exp
%type   <bool_val> booli
%type   <int_val> statement
%type   <int_val> whileStmt
%type   <int_val> ifStmt
%left	PLUS MINUS
%left	MULT DIV
%left   EQ 
%left   BIGEQ 
%left   BIG 
%left   SMALLEQ
%left   SMALL
%left   DIF 
%left   NOT
%left   AND
%left   OR
%left   NEG
%right  POWER

%%

input:	
        /* empty */
        | statement { cout<<"Is it ok?" <<$1 << endl; }
		| exp	{ cout << "Result1: " << $1 << endl; }
        | b_exp { cout << "Result2: " << $1 << endl; }
        | f_exp { cout << "Result3: " << $1 << endl; }
        ;

exp:	INTEGER_LITERAL	{ $$ = $1; }
		| exp PLUS exp	{ $$ = $1 + $3; }
		| exp MULT exp	{ $$ = $1 * $3; }
        | exp MINUS exp { $$ = $1 - $3; }
        | exp DIV  exp  { $$ = $1 / $3; }
        | MINUS exp %prec NEG { $$=-$2; }
        | exp POWER exp { $$=pow($1,$3); }
		;
b_exp:  booli {$$=$1;}
        | exp BIGEQ exp { $$ = $1 >= $3;}
        | exp BIG   exp { $$ = $1 > $3;}
        | exp SMALLEQ exp { $$ = $1 <= $3; }
        | exp SMALL exp   { $$ = $1 < $3; }
        | exp EQ exp { $$ = $1 == $3;}
        | exp DIF exp { $$ = $1 != $3; }
        | f_exp BIGEQ f_exp { $$ = $1 >= $3;}
        | f_exp BIG   f_exp { $$ = $1 > $3;}
        | f_exp SMALLEQ f_exp { $$ = $1 <= $3; }
        | f_exp SMALL f_exp   { $$ = $1 < $3; }
        | f_exp EQ f_exp { $$ = $1 == $3;}
        | f_exp DIF f_exp { $$ = $1 != $3; }
        | b_exp EQ b_exp { $$ = $1 == $3;}
        | b_exp DIF b_exp { $$ = $1 != $3; }   
        | NOT b_exp %prec NEG {$$ = !($2); } 
        | b_exp AND b_exp { $$ = $1 && $3; }
        | b_exp OR b_exp { $$ = $1 || $3; }
        ;

booli: TRUE {$$ = 1;}
    | FALSE {$$ = 0;}
    ;

f_exp: FLOAT_LITERAL { $$ = $1; }
       | f_exp PLUS f_exp	{ $$ = $1 + $3; }
	   | f_exp MULT f_exp	{ $$ = $1 * $3; }
       | f_exp MINUS f_exp { $$ = $1 - $3; }
       | f_exp DIV  f_exp  { $$ = $1 / $3; }
       | MINUS f_exp %prec NEG { $$=-$2; }
       | f_exp POWER f_exp { $$=pow($1,$3); }
	   ;

statement:  INTEGER_LITERAL {$$ = $1;}
            | exp 
            | f_exp 
            | b_exp 
            | whileStmt {$$=$1;}
            | ifStmt {$$=$1;}
            ;

whileStmt:WHILE '(' exp ')' statement{$$=1;}
          | WHILE '(' b_exp ')' statement{$$=1;}
          | WHILE '(' f_exp ')' statement{$$=1;} 
          ;

ifStmt :IF '(' exp ')'  statement {$$=1;}
        | IF '(' b_exp ')' statement {$$=1;}
        | IF '(' f_exp ')' statement {$$=1;}
        ;
%%
#include <stdlib.h>
int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}



