#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include "ast.h"

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

void dump_ast(parser_ast* ast, int indent) {
    for(int i = 0; i < indent; i++) {
        printf(" ");
    }

    printf("%s", ast->kind);

    if(ast->value != "") {
        printf(" \"%s\"", ast->value);
    }
    printf("\n");

    for(int i = 0; i < 2; i++) {
        if(ast->children[i] != NULL) {
            dump_ast(ast->children[i], indent + 2);
        }
    }
}
