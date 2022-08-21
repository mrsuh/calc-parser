#ifndef AST_H
#define AST_H

typedef struct parser_ast {
    const char* kind;
    const char* value;
    struct parser_ast* children[2];
} parser_ast;

typedef union parser_t {
    char* number;
    parser_ast* ast;
} parser_t;

parser_ast* create_ast(const char* kind, const char* value);

parser_ast* create_ast_operation(const char* kind, parser_ast* left, parser_ast* right);

void dump_ast(parser_ast* ast, int indent);

parser_ast* parse(const char *file_path);

#endif
