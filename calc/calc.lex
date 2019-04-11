/* Mini Calculator */
/* calc.lex */
%option noyywrap
%{
#include "heading.h"
#include "tok.h"
int yyerror(char *s);
extern "C" int yylex();
%}

digit		[0-9]
int_const	{digit}+
float {digit}+"."{digit}*    

%%

{int_const}	{ yylval.int_val = atoi(yytext); return INTEGER_LITERAL; }
{float} { yylval.float_val = atof(yytext); return FLOAT_LITERAL; }
"+"		{ yylval.op_val = new std::string(yytext); return PLUS; }
"-"     { yylval.op_val = new std::string(yytext); return MINUS; }
"*"		{ yylval.op_val = new std::string(yytext); return MULT; }
"/"     { yylval.op_val = new std::string(yytext); return DIV; }
"=="    { yylval.op_val = new std::string(yytext); return EQ; }
">="    { yylval.op_val = new std::string(yytext); return BIGEQ; }
">"     { yylval.op_val = new std::string(yytext); return BIG; }
"<="    { yylval.op_val = new std::string(yytext); return SMALLEQ; }
"<"     { yylval.op_val = new std::string(yytext); return SMALL; }
"!="    { yylval.op_val = new std::string(yytext); return DIF; }
"!"     { yylval.op_val = new std::string(yytext); return NOT; }
"&&"    { yylval.op_val = new std::string(yytext); return AND; }
"||"    { yylval.op_val = new std::string(yytext); return OR;}
"^"     { yylval.op_val = new std::string(yytext); return POWER;}
"if"    { yylval.op_val = new std::string(yytext); return IF;}
"else"  { yylval.op_val = new std::string(yytext); return ELSE;}
"while" { yylval.op_val = new std::string(yytext); return WHILE;}
"{"     { yylval.op_val = new std::string(yytext); return '}';}
"}"     { yylval.op_val = new std::string(yytext); return '{';}
"("     { yylval.op_val = new std::string(yytext); return '(';}
")"     { yylval.op_val = new std::string(yytext); return ')';}
"true"  { return TRUE;}
"false" { return FALSE;}
[ \t]*		{}
[\n]		{ yylineno++;	}

.		{ std::cerr << "SCANNER "; yyerror(""); exit(1);	}

