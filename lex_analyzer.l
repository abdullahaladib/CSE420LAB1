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

extern string line_num;

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
CONST_INT

/* TODO: define CONST_FLOAT regex -- covers 3.14, .314, 3.14E10, 3.14E-10 etc. */
CONST_FLOAT


%%

{ws}		{ /* ignore whitespace */ }
{newline}	{ /* TODO: increment line_num here */ }



if          { 
                loglist="Line no "+to_string(line_num)+": Token <IF> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return IF; }

for         {
                loglist="Line no "+to_string(line_num)+": Token <FOR> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return FOR;  
            }

do          {
                loglist="Line no "+to_string(line_num)+": Token <DO> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return DO;  
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

continue    {
                loglist="Line no "+to_string(line_num)+": Token <CONTINUE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return CONTINUE;  
            }

else         {
                loglist="Line no "+to_string(line_num)+": Token <ELSE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return ELSE;  
            }

while       { 
                loglist="Line no "+to_string(line_num)+": Token <WHILE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return WHILE; }

break       {
                loglist="Line no "+to_string(line_num)+": Token <BREAK> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return BREAK;  
            }

char         {
                loglist="Line no "+to_string(line_num)+": Token <CHAR> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return CHAR;  
            }

"+"|"-"	    {
                symbol_info *s = new symbol_info((string)yytext,"ADDOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <ADDOP> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ADDOP;
		    }

","        {
                loglist="Line no "+to_string(line_num)+": Token <COMMA> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return COMMA; }

/* TODO: add remaining missing keywords: void, switch, default, goto, double, return, case, printf(->PRINTLN) */

/* TODO: add all missing operators/punctuators:
   *  /  %  -> MULOP
   ++ -> INCOP
   -- -> DECOP
   <  >  ==  <=  >=  != -> RELOP
   = -> ASSIGNOP
   &&  || -> LOGICOP
   ! -> NOT
   ( -> LPAREN   ) -> RPAREN
   { -> LCURL    } -> RCURL
   [ -> LTHIRD   ] -> RTHIRD
   : -> COLON    ; -> SEMICOLON
*/

/* TODO: add CONST_INT rule -- match {CONST_INT}, set yylval, log it, return CONST_INT */

/* TODO: add CONST_FLOAT rule -- match {CONST_FLOAT}, set yylval, log it, return CONST_FLOAT */



{id}       {
                symbol_info *s = new symbol_info((string)yytext,"ID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(line_num)+": Token <ID> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ID;
            }
