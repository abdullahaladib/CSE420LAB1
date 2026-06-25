%{

#include"symbol_info.h"

#define YYSTYPE symbol_info*

int yyparse(void);
int yylex(void);

extern FILE *yyin;


ofstream outlog;

string line_num;

// TODO: declare yyerror(char*) and any helper functions here

%}

/* TODO: declare ALL tokens here -- currently only IF ELSE FOR are declared.
   Missing: WHILE DO BREAK CONTINUE RETURN PRINTLN
            INT FLOAT CHAR VOID
            ID CONST_INT CONST_FLOAT
            ADDOP MULOP INCOP DECOP RELOP ASSIGNOP LOGICOP NOT
            LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA COLON SEMICOLON
   Also add %nonassoc for if-else to resolve the dangling-else conflict (0 conflicts required) */
%token IF ELSE FOR

%%

start : program
	{
		outlog<<"At line no: "<<line_num<<" start : program "<<endl<<endl;
	}
	;

program : program unit
	{
		outlog<<"At line no: "<<line_num<<" program : program unit "<<endl<<endl;
		outlog<<$1->getnameofsymbol()+"\n"+$2->getnameofsymbol()<<endl<<endl;
		
		$$ = new symbol_info($1->getnameofsymbol()+"\n"+$2->getnameofsymbol(),"program");
	}
	| unit
	{
		/* TODO: log and set $$ for the base case (unit only) */
	}
	;

/* TODO: add missing grammar rules between program and func_definition:
   unit, variable_decl, type_specifier, declaration_list
   param_list, compound_statement, statements, statement,
   expression_statement, variable, expression, logic_expression,
   rel_expression, simple_expression, term, unary_expression,
   factor_info, factor, argument_list, arguments
   -- basically everything from the grammar PDF except start/program/func_definition/statement(FOR) */

func_definition : type_specifier ID LPAREN param_list RPAREN compound_statement
		{
			/* TODO: log and set $$ for func with param list -- same pattern as the rule below but $6 for body */
		}
		| type_specifier ID LPAREN RPAREN compound_statement
		{
			outlog<<"At line no: "<<line_num<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement "<<endl<<endl;
			/* BUG: getnameofsymbol used without () on two lines below -- add () to fix compile error */
			outlog<<$1->getnameofsymbol()<<" "<<$2->getnameofsymbol()<<"()\n"<<$5->getnameofsymbol<<endl<<endl;
			$$ = new symbol_info($1->getnameofsymbol+" "+$2->getnameofsymbol()+"()\n"+$5->getnameofsymbol(),"func_def");
		}
		;

statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement
	  {
	    	outlog<<"At line no: "<<line_num<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement "<<endl<<endl;
			outlog<<"for("<<$3->getnameofsymbol()<<$4->getnameofsymbol()<<$5->getnameofsymbol()<<")\n"<<$7->getnameofsymbol()<<endl<<endl;
			$$ = new symbol_info("for("+$3->getnameofsymbol()+$4->getnameofsymbol()+$5->getnameofsymbol()+")\n"+$7->getnameofsymbol(),"stmnt");
	  }
	  /* TODO: add remaining statement alternatives:
	     variable_decl | expression_statement | compound_statement
	     IF LPAREN expression RPAREN statement
	     IF LPAREN expression RPAREN statement ELSE statement  <- dangling-else, needs %nonassoc fix
	     WHILE LPAREN expression RPAREN statement
	     PRINTLN LPAREN ID RPAREN SEMICOLON
	     RETURN expression SEMICOLON
	     each with log + $$ assignment */

%%

int main(int c, char *v[])
{
	if(c != 2)
	{
		/* TODO: print usage error and return 1 */
	}
	yyin = fopen(v[1], "r");
	/* TODO: rename output file to <student_id>_log.txt per spec */
	outlog.open("my_log.txt", ios::trunc);
	
	if(yyin == NULL)
	{
		cout<<"Couldn't open file"<<endl;
		return 0;
	}
    
	yyparse();
	
	/* TODO: print total line count to outlog here */
	
	outlog.close();
	
	fclose(yyin);
	
	return 0;
}