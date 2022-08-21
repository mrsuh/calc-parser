#include "ast.h"
#include "parser.h"
#include <stdio.h> // sprintf
#include <stdlib.h> // malloc

int yylex(char **content)
{
    for(;;) {
        char *last = *content;
        /*!re2c
            re2c:define:YYCTYPE  = char;
            re2c:define:YYCURSOR = *content;
            re2c:yyfill:enable   = 0;
            [\+\-]                { return *(*content-1); }
            [0-9]+                {
                                    int size = *content-last;
                                    yylval.number = (char *)malloc(size);
                                    sprintf(yylval.number, "%.*s", size, last);
                                    return TOK_NUMBER;
                                  }
            [ \t]+                { continue; }
            [\x00]                { return YYEOF; }
        */
    }

    return YYUNDEF;
}
