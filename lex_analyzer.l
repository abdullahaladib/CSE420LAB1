%option noyywrap

%{
#include<bits/stdc++.h>

#include"symbol_info.h"

#define YYSTYPE symbol_info*

#include "y.tab.h"

extern YYSTYPE yylval;

using namespace std;

void yyerror(char *);


string loglist;

extern int line_num;

extern ofstream outlog;

%}

/* Regular Definitions */

delim	 [ \t\v\r]

/* write regular expressions for whitespace and newline */
ws		 {delim}+

newline  \n

letter_	 [A-Za-z_]
digit	 [0-9]

/* write regular expressions for id, float and integers */
id		 {letter_}({letter_}|{digit})*

/* TODO: define CONST_INT regex -- one or more digits e.g. [0-9]+ */
CONST_INT [0-9]+

/* TODO: define CONST_FLOAT regex -- covers 3.14, .314, 3.14E10, 3.14E-10 etc. */
CONST_FLOAT {digit}+"."{digit}*([Ee][+-]?{digit}+)?|"."{digit}+([Ee][+-]?{digit}+)?|{digit}+[Ee][+-]?{digit}+


%%

{ws}        { /* ignore whitespace */ }
{newline}   { line_num++; }

"++"        {
                symbol_info *s = new symbol_info((string)yytext,"INCOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <INCOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return INCOP;
            }

"--"        {
                symbol_info *s = new symbol_info((string)yytext,"DECOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <DECOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return DECOP;
            }

"<="|">="|"=="|"!=" {
                symbol_info *s = new symbol_info((string)yytext,"RELOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <RELOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return RELOP;
            }

"<"|">"     {
                symbol_info *s = new symbol_info((string)yytext,"RELOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <RELOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return RELOP;
            }

"="         {
                loglist="Line no "+to_string(line_num)+": Token <ASSIGNOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return ASSIGNOP;
            }

"&&"|"||"   {
                symbol_info *s = new symbol_info((string)yytext,"LOGICOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <LOGICOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return LOGICOP;
            }

"!"         {
                loglist="Line no "+to_string(line_num)+": Token <NOT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return NOT;
            }

"+"|"-"     {
                symbol_info *s = new symbol_info((string)yytext,"ADDOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <ADDOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return ADDOP;
            }

"*"|"/"|"%" {
                symbol_info *s = new symbol_info((string)yytext,"MULOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <MULOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return MULOP;
            }

"("         {
                loglist="Line no "+to_string(line_num)+": Token <LPAREN> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return LPAREN;
            }

")"         {
                loglist="Line no "+to_string(line_num)+": Token <RPAREN> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return RPAREN;
            }

"{"         {
                loglist="Line no "+to_string(line_num)+": Token <LCURL> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return LCURL;
            }

"}"         {
                loglist="Line no "+to_string(line_num)+": Token <RCURL> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return RCURL;
            }

"["         {
                loglist="Line no "+to_string(line_num)+": Token <LTHIRD> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return LTHIRD;
            }

"]"         {
                loglist="Line no "+to_string(line_num)+": Token <RTHIRD> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return RTHIRD;
            }

","         {
                loglist="Line no "+to_string(line_num)+": Token <COMMA> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return COMMA;
            }

":"         {
                loglist="Line no "+to_string(line_num)+": Token <COLON> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return COLON;
            }

";"         {
                loglist="Line no "+to_string(line_num)+": Token <SEMICOLON> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return SEMICOLON;
            }

{CONST_FLOAT} {
                symbol_info *s = new symbol_info((string)yytext,"CONST_FLOAT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <CONST_FLOAT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return CONST_FLOAT;
            }

{CONST_INT} {
                symbol_info *s = new symbol_info((string)yytext,"CONST_INT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <CONST_INT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return CONST_INT;
            }

if          {
                loglist="Line no "+to_string(line_num)+": Token <IF> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return IF;
            }

else        {
                loglist="Line no "+to_string(line_num)+": Token <ELSE> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return ELSE;
            }

for         {
                loglist="Line no "+to_string(line_num)+": Token <FOR> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return FOR;
            }

while       {
                loglist="Line no "+to_string(line_num)+": Token <WHILE> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return WHILE;
            }

do          {
                loglist="Line no "+to_string(line_num)+": Token <DO> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return DO;
            }

break       {
                loglist="Line no "+to_string(line_num)+": Token <BREAK> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return BREAK;
            }

continue    {
                loglist="Line no "+to_string(line_num)+": Token <CONTINUE> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return CONTINUE;
            }

return      {
                loglist="Line no "+to_string(line_num)+": Token <RETURN> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return RETURN;
            }

int         {
                loglist="Line no "+to_string(line_num)+": Token <INT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return INT;
            }

float       {
                loglist="Line no "+to_string(line_num)+": Token <FLOAT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return FLOAT;
            }

char        {
                loglist="Line no "+to_string(line_num)+": Token <CHAR> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return CHAR;
            }

void        {
                loglist="Line no "+to_string(line_num)+": Token <VOID> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return VOID;
            }

double      {
                loglist="Line no "+to_string(line_num)+": Token <DOUBLE> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return DOUBLE;
            }

switch      {
                loglist="Line no "+to_string(line_num)+": Token <SWITCH> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return SWITCH;
            }

default     {
                loglist="Line no "+to_string(line_num)+": Token <DEFAULT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return DEFAULT;
            }

goto        {
                loglist="Line no "+to_string(line_num)+": Token <GOTO> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return GOTO;
            }

case        {
                loglist="Line no "+to_string(line_num)+": Token <CASE> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return CASE;
            }

printf      {
                loglist="Line no "+to_string(line_num)+": Token <PRINTLN> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return PRINTLN;
            }

{id}        {
                symbol_info *s = new symbol_info((string)yytext,"ID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <ID> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;
                return ID;
            }
