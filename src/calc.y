%require "3.8"

%code top {
  #include <assert.h>
  #include <ctype.h>  /* isdigit. */
  #include <stdio.h>  /* printf. */
  #include <stdlib.h> /* abort. */
  #include <string.h> /* strcmp. */
  #include "ast.h"

  int yylex (void);
  void yyerror (char const *);
  parser_ast * ast = NULL;
  FILE * input = NULL;
}

%define api.header.include {"calc.h"}

/* Generate YYSTYPE from the types used in %token and %type.  */
%define api.value.type {parser_t}
%token <ast> number
%type  <ast> expr

/* Nice error messages with details. */
%define parse.error detailed

/* Enable run-time traces (yydebug).  */
%define parse.trace

/* Formatting semantic values in debug traces.  */
%printer { fprintf (yyo, "%s", $$->kind); } <ast>;

%% /* The grammar follows.  */

line:
  %empty
|  expr { ast = $1; }
| error { yyerrok; }
;

expr:
  expr '+' number { $$ = create_ast_operation("OPERATION_PLUS", $1, $3); }
| expr '-' number { $$ = create_ast_operation("OPERATION_MINUS", $1, $3); }
| number { $$ = $1; }
;

%%

int yylex(void)
{
    int c;
    while (!feof(input))
    {
        c = getc(input);

        if (c == EOF || c == '\n')
        {
            return 0;
        }

        if (c == ' ' || c == '\t')
        {
            continue;
        }

        if (isdigit(c))
        {
            char *word = (char *)malloc(10);
            ungetc(c, input);
            if (fscanf(input, "%s", word) != 1)
            {
                abort();
            }

            yylval.ast = create_ast("NUMBER", word);

            return number;
        }

        return c;
    }

    return 0;
}

/* Called by yyparse on error.  */
void yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}

parser_ast* parse() {
    input = fopen("/code/calc.txt", "r");
    yyparse();
    fclose(input);

    return ast;
}

int main(int argc, char const *argv[])
{
    /* Enable parse traces on option -p.  */
    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "-p")) {
            yydebug = 1;
        }
    }

    ast = parse();
    if (ast == NULL) {
       abort();
    }

    dump_ast(ast);

    return 0;
}
