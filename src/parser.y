%require "3.8"

%code top {
  #include <stdio.h>  /* fprintf. */
  #include "ast.h"

  int yylex(char **content);
  void yyerror(char **content, char const *);
  parser_ast *ast = NULL;
}

%param {char **content}

%define api.header.include {"parser.h"}
%define api.value.type {parser_t}

%token <number> TOK_NUMBER
%type  <ast> expr

%left '-' '+'

%%

line:
  %empty
|  expr { ast = $1; }
;

expr:
    TOK_NUMBER    { $$ = create_ast("NUMBER", $1); }
|   expr '+' expr { $$ = create_ast_operation("OPERATION_PLUS", $1, $3); }
|   expr '-' expr { $$ = create_ast_operation("OPERATION_MINUS", $1, $3); }
;

%%

void yyerror (char **content, char const *s)
{
  fprintf (stderr, "%s\n", s);
}

parser_ast* parse(const char *file_path) {

    FILE *file = fopen(file_path, "r");
    fseek(file, 0, SEEK_END);
    long fsize = ftell(file);
    fseek(file, 0, SEEK_SET);

    char *content = (char *)malloc(fsize + 1);
    fread(content, fsize, 1, file);
    fclose(file);

    content[fsize] = 0;

    yyparse(&content);

    return ast;
}

int main(int argc, char const *argv[])
{
    if(argc < 2) {
        return 1;
    }

    ast = parse(argv[1]);
    if (ast == NULL) {
       return 1;
    }

    dump_ast(ast, 0);

    return 0;
}
