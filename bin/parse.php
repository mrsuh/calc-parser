<?php

if (\version_compare(PHP_VERSION, '7.4', '<')) {
    throw new \RuntimeException('Unsupported PHP version');
}

if (\php_uname('m') !== 'x86_64') {
    throw new \RuntimeException('Unsupported machine type');
}

if (\php_uname('s') !== 'Linux') {
    throw new \RuntimeException('Unsupported operating system');
}

$libc = \FFI::cdef('
typedef struct parser_ast {
    const char* kind;
    const char* value;
    struct parser_ast* children[2];
} parser_ast;
parser_ast* parse(const char *file_path);
', __DIR__ . "/../src/library_linux.so");

function dump($ast, int $indent = 0): void
{
    $node = $ast[0];
    printf("%s%s%s\n",
        (str_repeat(' ', $indent)),
        $node->kind,
        $node->value ? sprintf(" \"%s\"", $node->value) : ''
    );
    for ($i = 0; $i < 2; $i++) {
        if ($node->children[$i] !== null) {
            dump($node->children[$i], $indent + 2);
        }
    }
}

$filePath = $argv[1];
if(!is_file($filePath)) {
    throw new \RuntimeException('Invalid file path');
}

$ast = $libc->parse($filePath);
dump($ast);
