<?php

if (\version_compare(PHP_VERSION, '7.4', '<')) {
    throw new \RuntimeException('Unsupported PHP version');
}

if (\php_uname('m') !== 'x86_64') {
    throw new \RuntimeException('Unsupported machine type');
}

switch (\php_uname('s')) {
    case 'Linux':
        $libraryFileName = 'calc_linux.so';
        break;
    default:
        throw new \RuntimeException('Unsupported operating system');
}

$libc = \FFI::cdef('
typedef struct parser_ast {
    const char* kind;
    const char* value;
    struct parser_ast* children[2];
} parser_ast;
parser_ast* parse();
', __DIR__ . "/../src/" . $libraryFileName);

function dump($ast, int $indent = 0): void
{
    $node = $ast[0];
    printf("%s%s%s\n",
        (str_repeat(' ', $indent)),
        $node->kind,
        $node->value ? sprintf(" \"%s\"", $node->value) : ''
    );
    for($i = 0; $i < 2; $i ++) {
        if($node->children[$i] !== NULL) {
            dump($node->children[$i], $indent + 2);
        }
    }
}

$ast  = $libc->parse();
dump($ast);
