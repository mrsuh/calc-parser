#ifndef AST_H
# define AST_H

typedef struct parser_ast {
    const char* kind;
    const char* value;
    struct parser_ast* children[2];
} parser_ast;

typedef union parser_t {
    parser_ast* ast;
} parser_t;

parser_ast* create_ast(const char* kind, const char* value) {
    parser_ast* ast = (parser_ast*)malloc(sizeof(parser_ast));
    ast->kind = kind;
    ast->value = value;
    ast->children[0] = NULL;
    ast->children[1] = NULL;

    return ast;
}

parser_ast* create_ast_operation(const char* kind, parser_ast* left, parser_ast* right) {
    parser_ast* ast = (parser_ast*)malloc(sizeof(parser_ast));
    ast->kind = kind;
    ast->value = "";
    ast->children[0] = left;
    ast->children[1] = right;

    return ast;
}

void dump_ast(parser_ast* ast) {
    printf("kind: %s, value: %s\n", ast->kind, ast->value);
    for(int i = 0; i < 2; i++) {
        if(ast->children[i] != NULL) {
            dump_ast(ast->children[i]);
        }
    }
}

#endif
